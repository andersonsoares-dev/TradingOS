---
id: EXEC-003
title: Risk Service (Pre-Order Risk Gate)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - SPEC-003
  - EXEC-001
  - EXEC-002
  - ADR-009
related:
  - RFC-006
last_updated: 2026-07-21
---

# Risk Service (Pre-Order Risk Gate)

Terceiro documento da sequência travada de entrega (`ADR-009`). Detalha o componente responsável pelo controle de risco das operações antes do envio das ordens. Este documento **não altera** `ARCH`, `DOMAIN`, `ADR`, `RFC` ou `SPEC` — apenas especifica um contrato funcional novo, associado ao componente `Risk Service` já catalogado em `SPEC-001`.

**`EXEC-003` é rótulo de posição na sequência de entrega travada em `ADR-009`, não uma reclassificação de Bounded Context.** `Risk Service` continua catalogado em `SPEC-001` como **Core Domain Service** — a mesma observação já registrada em `ADR-009` é reafirmada aqui.

---

## Validação Prévia (Document Validation Pipeline) — divergência real encontrada

Antes de detalhar o componente, esta validação encontrou uma divergência que **não pôde ser resolvida neste documento** (não há autorização para alterar `SPEC-003`, congelado):

`SPEC-003` (Domain Services, frozen) já define um contrato para `Risk Service`:

> Responsabilidade: Avaliar o risco da Opportunity. Entrada: Opportunity, Market Context. Saída: Risk Profile.

O brief de origem desta entrega solicita um contrato **diferente**, operando em outro ponto do fluxo (imediatamente antes do envio da ordem, não na avaliação da Opportunity):

> Entrada: Signal Result, Symbol Information, Account Information, Current Exposure, Configuration. Saída: Risk Approved / Risk Rejected / Risk Warning / Risk Error / Risk Evaluation Result.

Estes são dois contratos distintos para o mesmo nome de componente (`Risk Service`), servindo dois propósitos diferentes — um avalia risco no nível do Core Domain (Opportunity → Risk Profile), o outro é um gate operacional pré-envio de ordem (Signal Result + contexto de conta/exposição → aprovação/rejeição). Registrado como `RFC-006` (Requires Architectural Decision). Este documento segue adiante especificando o contrato do brief de origem — o **Pre-Order Risk Gate** — sob o entendimento explícito de que ele **não substitui nem redefine** o `Risk Service` de `SPEC-003`; a reconciliação entre os dois (mesmo componente com dois papéis? dois componentes distintos que precisam de nomes diferentes?) fica pendente de `RFC-006`.

Adicionalmente, a dependência `Account Provider` (ver "Dependências") não consta no Canonical Component Catalog (`SPEC-001`) — registrada na mesma `RFC-006`.

---

# Objetivo

Definir o contrato funcional do componente responsável pelo controle de risco das operações antes do envio das ordens. Este componente é o único autorizado a aprovar ou rejeitar uma operação sob a ótica de risco nesta etapa do fluxo (pré-envio).

---

# Responsabilidades

- receber uma solicitação de avaliação de risco;
- validar parâmetros obrigatórios;
- calcular exposição da operação;
- validar limites configurados;
- aprovar ou rejeitar a operação;
- informar o motivo da decisão;
- publicar eventos de risco.

---

# Não Responsabilidades

**Não** deve:

- gerar sinais;
- abrir ordens;
- enviar ordens ao broker;
- gerenciar posições;
- calcular indicadores técnicos;
- executar chamadas ao MT5.

---

# Entradas

- `Signal Result`;
- `Symbol Information` (via `Data Provider`, `INFRA-002`);
- `Account Information`;
- `Current Exposure` (via `Position Manager`, `EXEC-002`);
- `Configuration` (via `Configuration Provider`, `SPEC-001`).

---

# Saídas

- `Risk Approved`;
- `Risk Rejected`;
- `Risk Warning`;
- `Risk Error`;
- `Risk Evaluation Result`.

---

# Risk Evaluation Result

Estrutura mínima:

- Status;
- Decision;
- Risk Score;
- Exposure;
- Maximum Allowed;
- Violations;
- Timestamp;
- Evaluation Id.

---

# Validações

Obrigatórias:

- risco máximo por operação;
- risco máximo diário;
- exposição máxima;
- número máximo de posições;
- volume permitido;
- configuração válida.

---

# Regras

Este documento **não define valores**. Define apenas os contratos. Todos os limites devem ser parametrizáveis. Nenhum valor deve estar fixo em código.

---

# Estados

```
Idle
↓
Evaluating
↓
Approved | Rejected | Warning | Error
```

---

# Eventos

- `RiskEvaluationStarted`;
- `RiskApproved`;
- `RiskRejected`;
- `RiskWarning`;
- `RiskError`.

---

# Interfaces

Contrato conceitual, sem implementação, sem MQL5:

```
EvaluateRisk()
↓
RiskEvaluationResult
```

---

# Dependências

## Permitidas

- `Configuration Provider` (`SPEC-001`);
- `Position Manager` (`EXEC-002`);
- `Account Provider` — **não catalogado em `SPEC-001`**, ver "Validação Prévia" e `RFC-006`.

## Proibidas

- Core Domain (este componente não gera `Opportunity`/`Decision`, apenas consome resultados já processados);
- `MT5 Adapter` diretamente (nenhuma chamada ao MT5).

---

# Consumidores

- `Order Manager` (`EXEC-001`);
- Logging;
- Auditoria.

---

# Casos de Teste

1. Operação aprovada;
2. Exposição excedida;
3. Limite diário excedido;
4. Volume inválido;
5. Configuração inválida;
6. Dados insuficientes;
7. Erro interno.

---

# Critérios de Aceitação

- determinístico;
- produzir sempre o mesmo resultado para a mesma entrada;
- sem efeitos colaterais;
- independente do broker;
- completamente testável isoladamente.

---

# Limitações

Não implementa:

- estratégia;
- indicadores;
- execução;
- gestão de posições.

---

# Traceability

- Architecture Baseline v1.0/v1.1 (`ADR-007`, `ADR-009`) — nenhum documento congelado alterado.
- Canonical Component Catalog (`SPEC-001`) — `Risk Service` catalogado como Core Domain Service; contrato deste documento é adicional, não substitutivo (ver "Validação Prévia").
- `EXEC-001` (Order Manager — consumidor).
- `EXEC-002` (Position Manager — origem de Current Exposure).
- `RFC-006` — divergência de contrato com `SPEC-003` e dependência não catalogada (`Account Provider`).
- `DOCUMENT_INDEX.md`, `TRACEABILITY.md` — atualizados nesta entrega.

---

# Definition of Done

O documento estará concluído quando qualquer desenvolvedor puder implementar o componente sem necessidade de decisões adicionais sobre suas responsabilidades, entradas, saídas e comportamento — exceto a resolução de `RFC-006` (reconciliação com `SPEC-003` e catalogação de `Account Provider`), explicitamente sinalizada como pendência externa a este documento.

---

# Próxima Entrega

`EXEC-004 — Signal Builder` (nome canônico `SPEC-001`; o brief desta sequência já havia sido corrigido de "Signal Engine" em `ADR-009`), conforme sequência travada.
