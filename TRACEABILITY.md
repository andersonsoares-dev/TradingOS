# Traceability Matrix

Matriz de rastreabilidade oficial, conforme .project-rules/DOCUMENT_CONTROL.md (Regra 9) e CONST-001 (Princípio 6).

Pipeline oficial: REQ → DOMAIN → ARCH → SPEC → SOURCE → TEST → VALIDATION

## Estado atual (V1 — arquitetura congelada, anterior ao protocolo de governança)

Os componentes abaixo foram implementados **antes** da adoção deste protocolo (2026-07-21). Por decisão registrada, o protocolo vale a partir de agora, sem migração retroativa — portanto não existe rastreabilidade formal completa (REQ/DOMAIN/SPEC) para eles.

| Componente | REQ | DOMAIN | ARCH | SPEC | SOURCE | TEST | VALIDATION |
|---|---|---|---|---|---|---|---|
| TrendService | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Indicators/TrendService.mqh | — | Manual (MetaEditor CLI) |
| ATR / RSI / ADX Service | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Indicators/ | — | Manual (MetaEditor CLI) |
| SessionService | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Services/SessionService.mqh | — | Manual (MetaEditor CLI) |
| PivotService | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Services/PivotService.mqh | — | Manual (MetaEditor CLI) |
| MarketAssessmentService | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Services/MarketAssessmentService.mqh | — | Manual (MetaEditor CLI) |
| SignalBuilderService | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/Services/SignalBuilderService.mqh | — | Manual (MetaEditor CLI) |
| Dashboard / PivotRenderer | — | — | Docs/ARCHITECTURE.md | — | MQL5/Include/TradingOS/UI/ | — | Validação visual manual no MetaTrader 5 |

## A partir de 2026-07-21

Toda nova funcionalidade deverá preencher esta matriz integralmente (REQ → DOMAIN → ARCH → SPEC → SOURCE → TEST → VALIDATION) antes da implementação, conforme CONST-001 e ENG-000.

## Divergências conhecidas (ver Docs/BACKLOG.md e Docs/TECH_DEBT.md)

- CONST-001 declara a missão como Swing Trade; a configuração atual do sistema é intradiária (day trade) — migração deliberadamente adiada.
- CONST-001 declara "Oportunidade" como objeto central do domínio; o código atual usa `MarketAssessment`/`TradingSignal`, não um agregado `Opportunity`.
