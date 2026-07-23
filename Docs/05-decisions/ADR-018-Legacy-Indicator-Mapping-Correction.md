---
id: ADR-018
title: Legacy Indicator Mapping Correction (Indicator Provider, not Evidence Builder)
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-004
  - SPEC-003
  - SPEC-001
  - ADR-009
related:
  - INFRA-003
  - DOMAIN-003
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-018: Legacy Indicator Mapping Correction

## Contexto

`RFC-004` registrou uma divergência entre dois documentos da Baseline congelada quanto ao papel-alvo de `TrendService`, `ATRService`, `RSIService` e `ADXService` na arquitetura-alvo: `SPEC-001` os classifica como `Indicator Provider` (Infrastructure); `SPEC-003` os classifica como `Evidence Builder` (Core Domain).

Leitura direta do código (`MQL5/Include/TradingOS/Indicators/*.mqh`) mostra que os quatro serviços são wrappers finos sobre funções nativas do MT5 (`iATR`/`iRSI`/`iADX`/`iMA`), retornando valor técnico bruto (ou, no `TrendService`, uma comparação simples de 3 EMAs). Nenhum produz `EvidenceId`, `Category`, `Confidence`, `Weight` ou os demais atributos obrigatórios de `Evidence` (`DOMAIN-003`). Nenhum constrói qualquer estrutura de domínio.

## Decisão

A Legacy Baseline (`TrendService`, `ATRService`, `RSIService`, `ADXService`) mapeia **exclusivamente** para `Indicator Provider` (Infrastructure Providers, `SPEC-001`) — classificação já correta e mantida inalterada.

`SPEC-003` é corrigido: a linha da seção "Legacy Baseline" que afirma *"TrendService, RSIService, ATRService e ADXService correspondem a Evidence Builder"* é removida. `Evidence Builder` permanece um componente Core Domain, catalogado em `SPEC-001`, sem nenhuma contraparte implementada na Legacy Baseline hoje — é trabalho futuro (Categoria "Planned"), não uma reclassificação de código existente.

## Limites

Esta decisão **não** altera `SPEC-001` (já correto), `INFRA-001`/`INFRA-003`, `ARCH-001`, `DOMAIN-003` ou qualquer arquivo de código (`.mq5`/`.mqh`). Não cria componente novo. Não implementa `Evidence Builder`.

## Consequências

- `SPEC-003`: seção "Legacy Baseline" corrigida — remove a correspondência incorreta com `Evidence Builder`.
- `RFC-004` transita de `Open` para `Approved` — resolução factual, fundamentada em leitura direta do código, não uma escolha de design em aberto.
- `ROADMAP-006`: `ITEM-12` passa de `Awaiting ADR` para `Implemented`.
- Nenhuma sprint da Release 1.0 é afetada.

## Rastreabilidade

`RFC-004` · `SPEC-001` · `SPEC-003` · `INFRA-003` · `DOMAIN-003` · `ADR-009` · `ROADMAP-006`
