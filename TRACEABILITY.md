# Traceability Matrix

Matriz de rastreabilidade oficial, conforme .project-rules/DOCUMENT_CONTROL.md (Regra 9) e CONST-001 (Princípio 6).

Pipeline oficial: REQ → DOMAIN → ARCH → SPEC → SOURCE → TEST → VALIDATION

# Validation Checklist

Todo documento deverá validar obrigatoriamente:

Vocabulary

↓

Components

↓

Architecture

↓

Traceability

↓

References

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
- DOMAIN-002 proibia os termos "Signal" e "Confirmation", usados pela Legacy Baseline — resolvido pelo ADR-005 (Ubiquitous Language Refinement): ambos passam a ser termos oficiais no contexto de execução/estratégia, não mais proibidos.

## REQ-001 — Mapeamento contra a Legacy Baseline

Avaliação de cada requisito funcional de `Docs/01-requirements/REQ-001-Requirements-Specification.md` frente à V1 (Legacy Baseline, ver ADR-001).

| Requisito | Descrição | Status na V1 | Observação |
|---|---|---|---|
| REQ-001 | Adquirir dados de mercado | ✔ Atendido | `MarketService` via `iHigh`/`iLow`/`iClose`/`iMA`/`iRSI`/`iATR`/`iADX` |
| REQ-002 | Contexto de mercado independente da plataforma | ✘ Não atendido | `MarketContext` acoplado diretamente ao MT5 — aceito como Legacy Baseline (ADR-001) |
| REQ-003 | Evidências técnicas (tendência/volatilidade/momentum/força/contexto temporal) | ✔ Atendido | Trend, ATR, RSI, ADX, Session |
| REQ-004 | Consolidar evidências em contexto único | ✔ Atendido | `MarketContext` + `MarketAssessmentService` |
| REQ-005 | Identificar oportunidades de mercado | ✔ Atendido (nomenclatura divergente) | `TradingSignal`, não `Opportunity` (ver DOMAIN-001) — coberto pelo ADR-002 |
| REQ-006 | Nível de confiança da oportunidade | ✔ Atendido | `MarketAssessment.ConfidenceScore`/`ConfidenceLevel` |
| REQ-007 | Justificativa explicável | ✔ Atendido | `TradingSignal.Reason` + bloco WHY do Dashboard |
| REQ-008 | Decisão operacional (BUY/SELL/WAIT/NO_TRADE) | ✔ Atendido | `ENUM_TRADING_SIGNAL` |
| REQ-009 | Avaliar risco antes da decisão | ✘ Não atendido | Risk Manager ainda não implementado (roadmap futuro, ver Docs/BACKLOG.md) |
| REQ-010 | Substituir indicadores sem alterar o domínio | ~ Parcial | Cada indicador é uma classe de serviço isolada (baixo acoplamento), mas sem Port/Interface formal |
| REQ-011 | Suportar múltiplas estratégias (Swing/Position/Intraday/Scalping) | ✘ Não atendido | Apenas configuração intraday existe — aceito como especialização válida (ADR-003) |
| REQ-012 | Independência de MT5/brokers/APIs | ✘ Não atendido | Dependência direta de MT5 em todos os serviços — aceito como Legacy Baseline (ADR-001) |

Requisitos não atendidos (REQ-002, REQ-009, REQ-011, REQ-012) não são tratados como pendências bloqueantes — refletem decisões já formalizadas em ADR-001/ADR-003, ou trabalho futuro já previsto no roadmap.

## DOMAIN-001 — Opportunity (modelo-alvo)

`Docs/02-domain/DOMAIN-001-Opportunity.md` define a entidade central do domínio-alvo (`Opportunity`, ciclo de vida, atributos, BR-001 a BR-006), rastreada contra REQ-005 a REQ-009. Nenhum código ainda implementa `Opportunity` — a V1 usa `MarketAssessment`/`TradingSignal` (ADR-002). Este documento é referência para implementações futuras, não descreve a Legacy Baseline.

## DOMAIN-002 — Ubiquitous Language (vocabulário refinado pelo ADR-005)

`Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md` originalmente proibia os termos "Signal" e "Confirmation" em favor de "Evidence"/"Decision". O **ADR-005 (Ubiquitous Language Refinement)** revisou essa regra: "Signal" e "Confirmation" deixam de ser termos proibidos — passam a ser termos oficiais do contexto de execução/estratégia (não do Core Domain). "Trigger" continua fora do Core Domain. Com isso, `TradingSignal`, `SignalBuilderService`, `ENUM_TRADING_SIGNAL` e os campos `TrendConfirmed`/`ADXConfirmed`/`RSIConfirmed`/`SessionConfirmed` da Legacy Baseline deixam de representar uma violação de vocabulário.

## DOMAIN-003 — Evidence (modelo-alvo)

`Docs/02-domain/DOMAIN-003-Evidence.md` define o objeto de domínio imutável `Evidence` (Category/Source/Value/Confidence/Weight/Timestamp/Metadata), rastreado contra REQ-003, REQ-004 e REQ-010. O próprio documento reconhece que, na Legacy Baseline, `TrendService`, `ATRService`, `RSIService`, `ADXService`, `SessionService` e `PivotService` já produzem informações equivalentes a `Evidence`, embora sem essa estrutura formal (sem `EvidenceId`, `Category`, `Weight` ou `Confidence` por evidência individual — a confiança hoje só existe agregada em `MarketAssessment.ConfidenceScore`). Nenhuma migração retroativa é exigida (ADR-001).

## DOMAIN-004 — Market Context (modelo-alvo)

`Docs/02-domain/DOMAIN-004-Market-Context.md` define o Aggregate Root `Market Context` (ContextId/Asset/Timeframe/Timestamp/Evidence Collection/Summary/Confidence), imutável após construção (BR-005), rastreado contra REQ-002 a REQ-005 e REQ-010. **Atenção a colisão de nome**: a V1 já possui um `struct MarketContext` (`MQL5/Include/TradingOS/Models/MarketContext.mqh`) — mesmo nome, estrutura diferente (mutável, campos públicos escritos diretamente pelo `MarketService`, sem coleção formal de `Evidence`). O próprio DOMAIN-004 reconhece isso na seção "Legacy Baseline". Nenhuma migração retroativa é exigida (ADR-001).

## DOMAIN-005 — Decision (modelo-alvo)

`Docs/02-domain/DOMAIN-005-Decision.md` define o objeto de domínio imutável `Decision` (DecisionId/OpportunityId/ContextId/Decision Type/Confidence/Rationale/Timestamp), rastreado contra REQ-005 a REQ-010. O próprio documento reconhece que, na Legacy Baseline, `TradingSignal`, `SignalBuilderService` e `ENUM_TRADING_SIGNAL` desempenham parcialmente esse papel — sem `DecisionId`/`OpportunityId`/`ContextId` formais, e sem separação entre Decision (conclusão do domínio) e Signal (representação de execução), distinção que o ADR-005 já formalizou no vocabulário. Nenhuma migração retroativa é exigida (ADR-001/ADR-002).

Com DOMAIN-005, a suíte de domínio-alvo está completa: `DOMAIN-001` (Opportunity) → `DOMAIN-003` (Evidence) → `DOMAIN-004` (Market Context) → `DOMAIN-005` (Decision), com `DOMAIN-002` (Ubiquitous Language) definindo o vocabulário comum a todos.

## ARCH-001 — Architecture Blueprint (arquitetura-alvo)

`Docs/03-architecture/ARCH-001-Architecture-Blueprint.md` define os Bounded Contexts (Core Domain, Infrastructure, Strategy, Execution), as dependências permitidas/proibidas (Core Domain nunca acessa MT5/Broker/Logger/File System/Indicators/APIs/Network) e o fluxo oficial `Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order`, rastreado contra REQ-001 a REQ-010 e DOMAIN-001/003/004/005.

O próprio documento reconhece na seção "Legacy Baseline" que a V1 (`TrendService`, `RSIService`, `ATRService`, `ADXService`, `PivotService`, `SessionService`, `TradingSignal`, `SignalBuilderService`) viola diretamente a dependência proibida "Core Domain → Indicators" (esses serviços chamam `iMA`/`iRSI`/`iATR`/`iADX` diretamente, sem camada de Infrastructure/Adapter). Nenhuma refatoração retroativa é exigida (ADR-001/ADR-002) — a arquitetura-alvo se aplica só a novas evoluções.

`Docs/ARCHITECTURE.md` (a arquitetura informal da V1, referenciada na tabela "Estado atual" acima) e `ARCH-001` coexistem deliberadamente: o primeiro documenta o que existe, o segundo define o que será construído daqui em diante.

## SPEC-001 — Component Model (v1.2.0, Canonical Component Catalog)

`Docs/04-specifications/SPEC-001-Component-Model.md` é agora a **única fonte oficial de nomenclatura arquitetural** do projeto (Canonical Component Catalog), organizada em: Core Domain Builders (Evidence Builder, Market Context Builder), Core Domain Services (Opportunity Service, Decision Service, Confidence Service, Risk Service), Domain Policies (Context Validation Policy, Evidence Validation Policy), Infrastructure Providers (Data/Indicator/Configuration/Time/Persistence Provider, Logger) e Execution Components (Signal Builder, Order Manager, Position Manager, Broker Adapter, MT5 Adapter). Rastreado contra ARCH-001, DOMAIN-003/004/005 e REQ-001 a REQ-010.

A tabela "Component Lifecycle" foi atualizada para usar esses nomes canônicos. Destaque: `MT5 Adapter` = Planned (acesso ao MT5 hoje disperso em cada serviço, sem adapter isolado — a mesma violação já apontada em ARCH-001).

**Observação (ainda aberta)**: a lista "Componentes Legacy" do SPEC-001 (TrendService, ATRService, ADXService, RSIService, SessionService, PivotService, TradingSignal, SignalBuilderService, Config, Logger) não menciona `MarketAssessmentService`, `Dashboard` nem `PivotRenderer` — todos já reconhecidos como Legacy Baseline em outros documentos (ver ADR-001 e seção "Legacy Components" abaixo). Divergência de escopo entre documentos, não bloqueante.

## SPEC-002 — Interface Contracts (v1.1.0, nomenclatura estabilizada)

`Docs/04-specifications/SPEC-002-Interface-Contracts.md` define os contratos entre componentes no pipeline `Data Provider → Indicator Provider → Evidence Builder → Market Context Builder → Opportunity Service → Decision Service → Signal Builder → Order Manager`, com pré/pós-condições e tratamento de erros. Rastreado contra ARCH-001, SPEC-001, DOMAIN-003/004/005.

Renomeado para usar os nomes canônicos do SPEC-001: `Evidence Factory` → `Evidence Builder`, `Opportunity Evaluator` → `Opportunity Service`, `Decision Engine` → `Decision Service` (`Market Context Builder` já estava correto).

## SPEC-003 — Domain Services (v1.1.0, escopo restrito)

`Docs/04-specifications/SPEC-003-Domain-Services.md` contém exclusivamente os 4 Domain Services oficiais do SPEC-001: Opportunity Service, Decision Service, Confidence Service, Risk Service (renomeado de "Risk Evaluation Service"). `Evidence Evaluation Service` e `Context Validation Service` foram removidos deste documento — os conceitos equivalentes (Evidence Builder, Evidence Validation Policy, Context Validation Policy) pertencem ao SPEC-001, não a Domain Services. Rastreado contra ARCH-001, SPEC-001, SPEC-002, DOMAIN-001/003/004/005.

## Architecture Stabilization (taxonomia)

Consolidação da nomenclatura arquitetural entre SPEC-001/002/003, eliminando 3 variações de nome para os mesmos papéis que existiam antes desta estabilização:

| Papel | Nome antes (por documento) | Nome canônico (SPEC-001) |
|---|---|---|
| Market Context → Opportunity | Strategy Engine (SPEC-001) / Opportunity Evaluator (SPEC-002) / Opportunity Service (SPEC-003) | **Opportunity Service** |
| Opportunity → Decision | — (SPEC-001) / Decision Engine (SPEC-002) / Decision Service (SPEC-003) | **Decision Service** |
| Dados técnicos → Evidence | — (SPEC-001) / Evidence Factory (SPEC-002) | **Evidence Builder** |
| Avaliação de risco | Risk Evaluator (SPEC-001) / Risk Evaluation Service (SPEC-003) | **Risk Service** |

`SPEC-001` passa a ser a fonte única de nomenclatura (ver regra "Canonical Naming" em `AGENTS.md`); `SPEC-002`/`SPEC-003` foram atualizados para reutilizar exatamente esses nomes.

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
