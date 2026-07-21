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

- CONST-001 declara a missão como Swing Trade; a configuração atual do sistema é intradiária (day trade) — resolvido pelo ADR-003 (Product Scope): intraday é uma especialização válida da missão, não uma violação.
- CONST-001 declara "Oportunidade" como objeto central do domínio; o código atual usa `MarketAssessment`/`TradingSignal`, não um agregado `Opportunity` — resolvido pelo ADR-002 (Domain Evolution): convivência aceita, migração só ocorre com benefício real.

## REQ-001 — Mapeamento contra a Legacy Baseline

Avaliação de cada requisito funcional de `Docs/01-requirements/REQ-001-Requirements-Specification.md` frente à V1 (Legacy Baseline, ver ADR-001).

| Requisito | Descrição | Status na V1 | Observação |
|---|---|---|---|
| REQ-001 | Adquirir dados de mercado | ✔ Atendido | `MarketService` via `iHigh`/`iLow`/`iClose`/`iMA`/`iRSI`/`iATR`/`iADX` |
| REQ-002 | Contexto de mercado independente da plataforma | ✘ Não atendido | `MarketContext` acoplado diretamente ao MT5 — aceito como Legacy Baseline (ADR-001) |
| REQ-003 | Evidências técnicas (tendência/volatilidade/momentum/força/contexto temporal) | ✔ Atendido | Trend, ATR, RSI, ADX, Session |
| REQ-004 | Consolidar evidências em contexto único | ✔ Atendido | `MarketContext` + `MarketAssessmentService` |
| REQ-005 | Identificar oportunidades de mercado | ✔ Atendido (nomenclatura divergente) | `TradingSignal`, não `Opportunity` — coberto pelo ADR-002 |
| REQ-006 | Nível de confiança da oportunidade | ✔ Atendido | `MarketAssessment.ConfidenceScore`/`ConfidenceLevel` |
| REQ-007 | Justificativa explicável | ✔ Atendido | `TradingSignal.Reason` + bloco WHY do Dashboard |
| REQ-008 | Decisão operacional (BUY/SELL/WAIT/NO_TRADE) | ✔ Atendido | `ENUM_TRADING_SIGNAL` |
| REQ-009 | Avaliar risco antes da decisão | ✘ Não atendido | Risk Manager ainda não implementado (roadmap futuro, ver Docs/BACKLOG.md) |
| REQ-010 | Substituir indicadores sem alterar o domínio | ~ Parcial | Cada indicador é uma classe de serviço isolada (baixo acoplamento), mas sem Port/Interface formal |
| REQ-011 | Suportar múltiplas estratégias (Swing/Position/Intraday/Scalping) | ✘ Não atendido | Apenas configuração intraday existe — aceito como especialização válida (ADR-003) |
| REQ-012 | Independência de MT5/brokers/APIs | ✘ Não atendido | Dependência direta de MT5 em todos os serviços — aceito como Legacy Baseline (ADR-001) |

Requisitos não atendidos (REQ-002, REQ-009, REQ-011, REQ-012) não são tratados como pendências bloqueantes — refletem decisões já formalizadas em ADR-001/ADR-003, ou trabalho futuro já previsto no roadmap.

## Legacy Components

Conforme ADR-001 (Legacy Baseline), os componentes abaixo pertencem à Legacy Baseline (V1) e ainda não possuem rastreabilidade formal (REQ/DOMAIN/SPEC):

- TrendService
- ATRService
- ADXService
- RSIService
- SessionService
- PivotService
- MarketAssessment
- SignalBuilder
- Dashboard

Esses componentes só serão rastreados formalmente quando sofrerem evolução arquitetural — não retroativamente, e não apenas por conformidade documental.
