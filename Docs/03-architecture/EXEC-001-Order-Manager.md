---
id: EXEC-001
title: Order Manager
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - SPEC-003
  - INFRA-002
  - INFRA-003
related:
  - RFC-001
  - EXEC-002
last_updated: 2026-07-21
---

# Order Manager

Especifica o componente `Order Manager`, já catalogado em `SPEC-001` (Execution Components, status `Future`). Este documento **não altera** `DOMAIN`, `ARCH`, `SPEC`, `ADR` ou `RFC` — apenas detalha, em nível de contrato funcional, um componente já existente no Canonical Component Catalog.

**Nota de numeração/prefixo**: solicitado originalmente como `SPEC-006-Order-Manager.md`. `SPEC-006` já existe (`Business Rules`). Além da colisão de id, os documentos `SPEC-00X` até hoje sempre descrevem uma categoria inteira de componentes (Domain Services, Application Services, Business Rules); o detalhamento de um componente único já segue outro padrão neste projeto — `INFRA-00X`, usado para `Data Provider` (`INFRA-002`) e `Indicator Provider` (`INFRA-003`), ambos em `Docs/03-architecture/`. Por consistência, `Order Manager` (Execution Component) segue o mesmo padrão sob o prefixo `EXEC-00X`, na mesma pasta.

---

## Validação Prévia (Document Validation Pipeline)

- **SPEC-001**: `Order Manager` já catalogado (Execution Components, status `Future`) — nenhum componente novo criado.
- **SPEC-002**: nenhum contrato formal de `Order Manager` existe hoje em `SPEC-002` — este documento não o adiciona a `SPEC-002` (frozen), apenas detalha o componente em documento próprio, como já feito para `Data Provider`/`Indicator Provider` sem alterar `SPEC-002`.
- **ARCH-001**: `Order Manager` pertence ao Bounded Context Execution; dependências permitidas/proibidas aplicadas sem exceção.
- **RFC-001** (Risk Profile Classification, Open): identificada dependência real — ver "Dependências" abaixo.

---

# Objetivo

Definir o contrato funcional do componente responsável pelo gerenciamento do ciclo de vida das ordens da Release 1.0.

---

# Responsabilidades

`Order Manager` é responsável por:

- receber solicitações de abertura de ordens;
- validar pré-condições;
- construir a requisição de ordem;
- encaminhar a requisição ao `MT5 Adapter`;
- receber confirmações;
- receber rejeições;
- publicar eventos para os demais componentes.

---

# Não Responsabilidades

`Order Manager` **não** deve:

- gerar sinais;
- calcular indicadores;
- calcular risco;
- calcular lote;
- fechar posições automaticamente;
- gerenciar posições abertas;
- acessar diretamente APIs do MT5.

Gerenciamento de posições abertas é responsabilidade de `Position Manager` (`SPEC-001`, Execution Components, status `Future`). Acesso direto ao MT5 é responsabilidade exclusiva de `MT5 Adapter`.

---

# Entradas

`Order Manager` recebe obrigatoriamente:

- **Signal Result** — saída do pipeline de sinal (`Signal Builder`/`Decision Service`, conforme `SPEC-001`/`SPEC-002`);
- **Risk Result** — saída do `Risk Service` (`SPEC-001`, status `Planned`);
- **Symbol Information** — via `Data Provider` (`INFRA-002`, `GetSymbol()`);
- **Configuration** — via `Configuration Provider` (`SPEC-001`).

---

# Saídas

`Order Manager` produz:

- `Order Request`;
- `Order Accepted`;
- `Order Rejected`;
- `Order Cancelled`;
- `Order Error`.

---

# Estados

Máquina de estados do ciclo de vida de uma ordem:

```
Idle
↓
Preparing
↓
Validating
↓
Sending
↓
Accepted | Rejected | Cancelled | Error
```

## Transições e condições

| De | Para | Condição |
|---|---|---|
| Idle | Preparing | `SubmitOrder()` chamado com `Signal Result` e `Risk Result` válidos |
| Preparing | Validating | `Order Request` construída a partir das entradas |
| Validating | Sending | Todas as validações pré-envio (ver "Validações") aprovadas |
| Validating | Rejected | Qualquer validação pré-envio falhou — ordem nunca chega a ser enviada ao `MT5 Adapter` |
| Sending | Accepted | `MT5 Adapter` retorna confirmação do Broker |
| Sending | Rejected | Broker rejeita a ordem (ex.: volume inválido, símbolo inexistente) |
| Sending | Error | Falha de comunicação ou timeout com o `MT5 Adapter`/Broker |
| Preparing, Validating, Sending | Cancelled | Cancelamento explícito solicitado pelo consumidor antes da confirmação do Broker |

---

# Validações

Antes do envio (transição Validating → Sending), validar:

- mercado aberto;
- símbolo habilitado;
- volume permitido;
- spread máximo;
- distância mínima de Stop;
- configuração válida.

Qualquer falha nesta etapa produz `Order Rejected` sem contato com o `MT5 Adapter`.

---

# Tratamento de Erros

| Cenário | Tratamento |
|---|---|
| Mercado fechado | `Order Rejected` na validação pré-envio, sem tentativa de envio |
| Rejeição do Broker | `Order Rejected`, motivo do Broker propagado no evento |
| Timeout | `Order Error`, registrado via `Logger` |
| Volume inválido | `Order Rejected` na validação pré-envio |
| Símbolo inexistente | `Order Rejected` na validação pré-envio |
| Erro de comunicação | `Order Error`, registrado via `Logger`, sem repetição automática implícita |

---

# Eventos

`Order Manager` publica:

- `OrderSubmitted`;
- `OrderAccepted`;
- `OrderRejected`;
- `OrderCancelled`;
- `OrderError`.

---

# Interface

Contrato conceitual, sem implementação, sem código MQL5:

```
SubmitOrder(Order Request)
↓
OrderResult (Accepted | Rejected | Cancelled | Error)
```

---

# Dependências

## Permitidas

- `Risk Service` (`SPEC-001`, status `Planned`);
- `Configuration Provider` (`SPEC-001`);
- `MT5 Adapter` (`SPEC-001`, Execution Components, status `Planned`).

## Proibidas

- Core Domain (`Order Manager` nunca gera `Opportunity`/`Decision`, apenas consome seus resultados já processados);
- acesso direto a indicadores ou dados de mercado (via `Data Provider`/`Indicator Provider` apenas indiretamente, através de `Symbol Information`, nunca diretamente).

**Observação — dependência não satisfeita hoje**: o formato de `Risk Result` depende da classificação de `Risk Profile`, que é objeto de `RFC-001` (Risk Profile Classification), ainda `Open`. Este documento consome `Risk Result` como uma entrada abstrata (ver "Entradas") sem antecipar sua estrutura — quando `RFC-001` for decidida, este documento poderá precisar de uma revisão de compatibilidade, sem que isso constitua uma inconsistência presente.

---

# Consumidores

`Order Manager` é consumido por:

- `Position Manager` (`SPEC-001`, status `Future`);
- Logging;
- Auditoria.

---

# Casos de Teste

Cenários mínimos a documentar/implementar:

1. Ordem aceita;
2. Ordem rejeitada;
3. Mercado fechado;
4. Spread acima do limite;
5. Volume inválido;
6. Timeout;
7. Falha de comunicação.

---

# Critérios de Aceitação

O componente deve:

- ser determinístico;
- ser independente do MT5 (testável contra um `MT5 Adapter` substituível/mock);
- ser testável isoladamente;
- não possuir efeitos colaterais além dos eventos publicados e da requisição enviada ao `MT5 Adapter`.

---

# Limitações

`Order Manager` não implementa:

- estratégia;
- gestão de risco;
- gestão de posições;
- execução direta (acesso a API do MT5 é exclusivo do `MT5 Adapter`).

---

# Traceability

- Architecture Baseline v1.0 (`ADR-007`) — nenhum documento congelado alterado.
- `SPEC-001` (Order Manager catalogado, Execution Components).
- `SPEC-002` (nenhum contrato formal de Order Manager ainda existe ali — gap pré-existente, não introduzido por este documento).
- `SPEC-003` (Risk Service, referenciado como origem de Risk Result).
- `INFRA-002`/`INFRA-003` (Data Provider/Indicator Provider, origem indireta de Symbol Information).
- `RFC-001` (dependência não satisfeita — Risk Profile Classification, Open).
- `DOCUMENT_INDEX.md`, `TRACEABILITY.md` — atualizados nesta entrega.

---

# Definition of Done

O documento estará concluído quando qualquer desenvolvedor puder implementar o `Order Manager` sem necessidade de decisões adicionais sobre seu comportamento funcional — exceto a resolução de `RFC-001` (formato de `Risk Result`), explicitamente sinalizada como pendência externa a este documento.

---

# Próxima Entrega

`EXEC-002 — Position Manager`, conforme roadmap da Trilha 1 (Platform).
