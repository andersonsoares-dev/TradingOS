---
id: RFC-007
title: Signal Builder Pipeline Divergence (ARCH-001/SPEC-002 vs EXEC-004)
version: 1.0.0
status: Open
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-002
  - SPEC-003
  - EXEC-004
related:
  - RFC-006
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-007: Signal Builder Pipeline Divergence

## Classificação

Requires Architectural Decision (severidade alta — afeta se o pipeline de Core Domain é usado ou contornado)

## Contexto

Durante a Validação Prévia de `Docs/03-architecture/EXEC-004-Signal-Builder.md`, foi identificada uma divergência significativa entre o fluxo oficial já definido na Baseline e o pipeline descrito no brief de origem desta entrega.

**Fluxo oficial (`ARCH-001`)**:
> Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order

**Contrato já existente de `Signal Builder` (`SPEC-002`, congelado)**:
> Responsabilidade: Transformar Decision em Signal operacional. Entrada: Decision. Saída: Signal. Consumidores: Order Manager.

**Pipeline descrito no brief de `EXEC-004`**:
> Entrada: Market Context, Indicator Snapshot, Configuration → (Indicator Validation → Rule Evaluation → Filter Evaluation → Conflict Resolution → Signal Decision) → SignalResult (BUY/SELL/NO_SIGNAL) → consumido por Risk Service (`EXEC-003`).

O pipeline de `EXEC-004` **não consome uma `Decision`** e **não produz um `Signal` para `Order Manager`** — ele consome `Market Context` e indicadores diretamente, e entrega o resultado a `Risk Service` (`EXEC-003`), não a `Order Manager`. Isso significa que, tal como especificado, `EXEC-004` (junto com `EXEC-003`) descreve um pipeline operacional completo que **não passa pela Opportunity (`DOMAIN-001`) nem pela Decision (`DOMAIN-005`)** — as duas entidades centrais do Core Domain construídas ao longo desta Baseline, com Domain Services próprios já especificados em `SPEC-003` (`Opportunity Service`, `Decision Service`).

Esta é uma divergência mais séria que a de `RFC-006` (Risk Service): ali, dois contratos coexistiam sob o mesmo nome; aqui, um pipeline inteiro de Execution parece **substituir funcionalmente** a cadeia de Core Domain, não apenas nomear diferente uma peça isolada.

## Proposta em aberto

Esta RFC não decide qual pipeline é o correto. Alternativas possíveis, apenas para registro:

1. **`EXEC-003`/`EXEC-004` descrevem um MVP operacional intencional** — um caminho mais curto (indicadores → sinal → risco → ordem) para viabilizar a Primeira Execução (`ADR-009`) antes que `Opportunity`/`Decision`/`Market Context Builder`/`Opportunity Service`/`Decision Service` estejam implementados. Neste caso, o pipeline de `ARCH-001` (`Opportunity → Decision → Signal`) seria a arquitetura-alvo de longo prazo, e `EXEC-003`/`EXEC-004` um "modo de operação" explicitamente transitório — o que precisaria ser dito claramente em `ARCH-001` ou em ADR próprio, não deixado implícito.
2. **É um mal-entendido de terminologia** — "Market Context" e "Decision" nos briefs de origem podem estar sendo usados coloquialmente (não como os agregados formais `DOMAIN-004`/`DOMAIN-005`), e a intenção real seria consumir a saída já formal de `Decision Service`. Neste caso, `EXEC-004` precisaria ser corrigido para consumir `Decision`, não `Market Context`/`Indicator Snapshot` diretamente.
3. **O Core Domain (`Opportunity`/`Decision`) é redundante para a Release 1.0** e o projeto decide conscientemente operar apenas na camada de Execution até que haja motivo real para reativar o pipeline de Core Domain — decisão que precisaria revisitar `ADR-002` (Domain Evolution) e o investimento já feito em `DOMAIN-001`/`DOMAIN-005`/`SPEC-003`.

## Encaminhamento

Dado o impacto (decide se meses de trabalho em `DOMAIN-001`/`DOMAIN-005`/`SPEC-003` são usados na Release 1.0 ou contornados), recomenda-se que esta RFC seja resolvida por ADR explícito antes de `EXEC-005` ser tratado como o fechamento da sequência operacional — ou, ao menos, antes de qualquer implementação de `EXEC-003`/`EXEC-004` começar.

## Status

Open — aguardando decisão do Product Owner / Chief Architect.
