---
id: EXEC-004
title: Signal Builder (Execution-Layer Signal Mechanism)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - INFRA-003
  - EXEC-003
related:
  - RFC-007
last_updated: 2026-07-21
---

# Signal Builder (Execution-Layer Signal Mechanism)

Quarto documento da sequência travada de entrega (`ADR-009`). Detalha um mecanismo de geração de sinal a partir de indicadores e regras de negócio. Este documento **não altera** `ARCH`, `DOMAIN`, `ADR`, `RFC` ou `SPEC` — apenas especifica um contrato funcional novo, associado ao componente `Signal Builder` já catalogado em `SPEC-001`.

**Nota de nomenclatura**: o brief de origem referenciava "Signal Engine". O nome canônico em `SPEC-001` (Execution Components) é **`Signal Builder`** — mesma correção já aplicada em `ADR-009` para `EXEC-004`.

---

## Validação Prévia (Document Validation Pipeline) — divergência real encontrada

Esta validação encontrou uma divergência mais significativa que a de `EXEC-003`/`RFC-006`, e que **não pôde ser resolvida neste documento** (sem autorização para alterar `ARCH-001`/`SPEC-002`, congelados):

**`ARCH-001`** define o fluxo oficial: `Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order`.

**`SPEC-002`** (Interface Contracts, congelado) já define o contrato de `Signal Builder`:

> Responsabilidade: Transformar Decision em Signal operacional. Entrada: Decision. Saída: Signal. Consumidores: Order Manager.

Ou seja: `Signal Builder` deveria consumir uma `Decision` (já produzida pelo Core Domain, após `Opportunity Service`/`Decision Service`) e produzir um `Signal` para `Order Manager`.

O brief de origem desta entrega descreve um componente **estruturalmente diferente**: consome `Market Context` e `Indicator Snapshot` **diretamente**, aplica regras/filtros próprios, e produz `SignalResult` (BUY/SELL/NO_SIGNAL) — **sem passar por `Opportunity` nem por `Decision`** — consumido por `Risk Service` (`EXEC-003`), não por `Order Manager`.

Isso não é uma variação de nomenclatura — é um **pipeline alternativo completo** que substitui, na prática, toda a cadeia `Opportunity Service → Decision Service → Signal Builder` do Core Domain (`DOMAIN-001`, `DOMAIN-005`, `SPEC-003`) por um único componente de Execution operando diretamente sobre indicadores. Registrado como `RFC-007` (Requires Architectural Decision). Este documento segue adiante especificando o contrato do brief de origem — nomeado aqui **Signal Builder (Execution-Layer Signal Mechanism)** para distingui-lo textualmente do `Signal Builder` de `SPEC-002` — sob o entendimento explícito de que ele **não substitui nem redefine** o fluxo de `ARCH-001`; a reconciliação fica pendente de `RFC-007`.

---

# Objetivo

Definir o contrato funcional responsável por transformar indicadores e regras de negócio em sinais de negociação.

---

# Responsabilidades

- receber contexto de mercado;
- receber indicadores calculados;
- avaliar regras de negócio;
- aplicar filtros;
- produzir sinais determinísticos;
- informar justificativa da decisão.

---

# Não Responsabilidades

Não deve:

- calcular indicadores;
- buscar dados;
- abrir ordens;
- calcular risco;
- gerenciar posições;
- comunicar diretamente com MT5.

---

# Entradas

- `Market Context`;
- `Indicator Snapshot` (via `Indicator Provider`, `INFRA-003`);
- `Configuration` (via `Configuration Provider`, `SPEC-001`).

---

# Saídas

- `SignalResult`.

---

# Signal Result

Estrutura mínima:

- Decision;
- Confidence;
- Reasons;
- Trigger;
- Indicator Snapshot;
- Timestamp;
- Evaluation Id.

---

# Decisões

Apenas três decisões são permitidas:

- `BUY`;
- `SELL`;
- `NO_SIGNAL`.

Nenhum outro estado.

---

# Regras

Este documento **não implementa estratégia** — define apenas o mecanismo. As regras devem ser:

- parametrizáveis;
- determinísticas;
- independentes;
- reutilizáveis.

---

# Pipeline

```
Market Context
↓
Indicator Validation
↓
Rule Evaluation
↓
Filter Evaluation
↓
Conflict Resolution
↓
Signal Decision
↓
SignalResult
```

---

# Filtros

O mecanismo deve permitir filtros independentes (ex.: tendência, volatilidade, horário, spread, confirmação), sem implementar nenhum filtro específico neste documento.

---

# Conflitos

Comportamento a definir quando:

- regras conflitarem;
- indicadores forem inválidos;
- dados forem insuficientes;
- filtros bloquearem entrada.

Em qualquer um destes casos, o resultado deve ser `NO_SIGNAL` ou `SignalError` (ver "Eventos"), nunca uma decisão `BUY`/`SELL` obtida por critério de desempate não documentado.

---

# Eventos

- `SignalEvaluationStarted`;
- `SignalGenerated`;
- `SignalRejected`;
- `SignalError`.

---

# Interface

Contrato conceitual, sem implementação, sem MQL5:

```
Evaluate()
↓
SignalResult
```

---

# Dependências

## Permitidas

- `Indicator Provider` (`INFRA-003`);
- `Configuration Provider` (`SPEC-001`).

## Proibidas

- `MT5 Adapter` diretamente;
- `Order Manager`/`Position Manager` diretamente (saída vai para `Risk Service`, conforme "Consumidores").

---

# Consumidores

- `Risk Service` (`EXEC-003`).

**Observação**: consistente internamente com `EXEC-003`, cuja primeira entrada declarada é exatamente `Signal Result`. A consistência entre `EXEC-003` e `EXEC-004` não resolve, porém, a divergência com `ARCH-001`/`SPEC-002` registrada acima — os dois documentos `EXEC-00X` descrevem, juntos, um pipeline operacional coerente entre si, mas paralelo ao fluxo oficial `Opportunity → Decision → Signal`.

---

# Casos de Teste

1. BUY;
2. SELL;
3. NO_SIGNAL;
4. Indicadores inválidos;
5. Dados insuficientes;
6. Regras conflitantes;
7. Filtro bloqueando entrada.

---

# Critérios de Aceitação

- determinístico;
- produzir sempre o mesmo resultado para a mesma entrada;
- sem efeitos colaterais;
- completamente testável isoladamente.

---

# Limitações

Não implementa:

- estratégia específica;
- execução;
- gestão de risco;
- gestão de posições.

---

# Traceability

- Architecture Baseline v1.0/v1.1 (`ADR-007`, `ADR-009`) — nenhum documento congelado alterado.
- Canonical Component Catalog (`SPEC-001`) — `Signal Builder` catalogado como Execution Component; contrato deste documento é adicional/alternativo, não substitutivo (ver "Validação Prévia").
- `EXEC-003` (Risk Service — consumidor direto).
- `INFRA-003` (Indicator Provider — origem de Indicator Snapshot).
- `RFC-007` — divergência de pipeline com `ARCH-001`/`SPEC-002`.
- `DOCUMENT_INDEX.md`, `TRACEABILITY.md` — atualizados nesta entrega.

---

# Definition of Done

O documento estará concluído quando qualquer desenvolvedor puder implementar o componente sem necessidade de decisões adicionais — exceto a resolução de `RFC-007` (reconciliação com o fluxo `Opportunity → Decision → Signal` de `ARCH-001`/`SPEC-002`), explicitamente sinalizada como pendência externa a este documento.

---

# Próxima Entrega

`EXEC-005 — MT5 Adapter`, conforme sequência travada em `ADR-009`.
