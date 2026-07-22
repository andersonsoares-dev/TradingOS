---
id: ADR-017
title: Data Provider Candidate Adapters — Deferral Decision
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-003
  - INFRA-002
  - ARCH-001
  - ADR-009
related:
  - SPEC-001
  - SPEC-002
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-017: Data Provider Candidate Adapters — Deferral Decision

## Contexto

`RFC-003` registrou seis candidatos a Adapter da camada Infrastructure — `Replay Adapter`, `CSV Provider`/`CSV Adapter`, `Mock Provider`, `REST Adapter`, `FIX Adapter`, `WebSocket Adapter` — citados no brief de origem de `INFRA-002` como exemplos de extensibilidade do `Data Provider` (Port), mas nunca catalogados em `SPEC-001`.

Análise técnica realizada: nenhum dos seis possui consumidor comprovado hoje. A Definition of Ready/Done de `INFRA-002` já define `MT5 Adapter` como o único Adapter concreto necessário para a Release 1.0. `VALIDATION-001`/`BACKTEST-001` (Trilha de Validação, já aprovados) usam o Strategy Tester nativo do MT5 para o primeiro Backtest — nenhum depende de `Replay Adapter` ou `CSV Provider` como fonte de dados; o CSV citado em `BACKTEST-001` é artefato de saída, não de entrada. `AGENTS.md`/`ADR-004` já estabelecem que MQL5 não usa framework de testes unitários equivalente, reduzindo a necessidade de um `Mock Provider` formal. Nenhum documento de roadmap ou requisito (`REQ-001`) menciona integração REST, FIX ou WebSocket.

## Decisão

Nenhum dos seis candidatos é catalogado em `SPEC-001` nesta decisão. Nenhum é rejeitado definitivamente — o princípio de "Extensibilidade" de `INFRA-002` (múltiplas fontes de dados sem alterar consumidores) permanece válido como arquitetura-alvo.

- **Replay Adapter**: **Adiado**. Prioridade média-baixa para Release 2.0 (ligação com Trilha de Validação/Learning Domain).
- **CSV Provider/Adapter**: **Adiado**. Prioridade média-baixa, semelhante ao Replay Adapter.
- **Mock Provider**: **Adiado, com viés mais forte para rejeição futura**. Necessidade fraca — MQL5 não usa mocks para validação (`ADR-004`).
- **REST Adapter**: **Adiado**. Nenhuma necessidade identificada.
- **FIX Adapter**: **Adiado, com viés mais forte para rejeição futura**. Menor prioridade dos seis — nicho institucional, sem sinal de necessidade.
- **WebSocket Adapter**: **Adiado**. Nenhuma necessidade identificada.

## Critério de Reabertura

Conforme `ADR-009 §8`: esta decisão só poderá ser reaberta mediante evidência obtida durante a implementação — provavelmente originada da Trilha de Validação/Learning Domain na Release 2.0 — não por hipótese.

## Limites

Esta decisão **não** altera `SPEC-001`, `INFRA-002`, `ARCH-001`, `SPEC-002` ou qualquer arquivo de código (`.mq5`/`.mqh`). Não cria componente novo. Não fecha definitivamente a possibilidade de qualquer um dos seis existir no futuro — apenas posterga a decisão de catalogação até haver evidência concreta.

## Consequências

- `RFC-003` transita de `Open` para `Approved` — a decisão tomada é "adiar com critério de reabertura definido", não "aprovar componente" nem "rejeitar componente".
- `ROADMAP-006`: `ITEM-11` passa de `Awaiting RFC` para `Approved` (decisão de adiamento formalizada, sem propagação a `SPEC-001` por design).
- Nenhuma sprint da Release 1.0 é afetada — nenhum componente da sequência travada depende de qualquer um dos seis Adapters.

## Rastreabilidade

`RFC-003` · `INFRA-002` · `ARCH-001` · `SPEC-001` · `SPEC-002` · `ADR-009` · `ROADMAP-006`
