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
- SPEC-005 v1.0 redefinia o ciclo de vida da Opportunity de forma divergente de DOMAIN-001, incluindo estados (`Executed`/`Closed`/`Archived`) que pertenciam ao contexto de Execution — resolvido pelo ADR-006 (Opportunity Lifecycle Alignment): ciclo de vida simplificado para `Draft → Qualified → Approved → Completed`, com SPEC-005 revisado para ser exclusivamente um documento de orquestração.

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

## DOMAIN-001 — Opportunity (modelo-alvo, v1.1.0)

`Docs/02-domain/DOMAIN-001-Opportunity.md` define a entidade central do domínio-alvo (`Opportunity`, ciclo de vida, atributos, BR-001 a BR-006), rastreada contra REQ-005 a REQ-009. Nenhum código ainda implementa `Opportunity` — a V1 usa `MarketAssessment`/`TradingSignal` (ADR-002). Este documento é referência para implementações futuras, não descreve a Legacy Baseline.

Conforme **ADR-006 (Opportunity Lifecycle Alignment)**, o ciclo de vida foi simplificado de `Draft → Qualified → Approved → Executed → Closed → Archived` para `Draft → Qualified → Approved → Completed`. Os estados `Executed`, `Closed` e `Archived` foram removidos por representarem responsabilidade do contexto de Execution (ARCH-001), não da entidade Opportunity — ver seção "Architecture Stabilization (Opportunity Lifecycle Alignment)" abaixo.

## DOMAIN-002 — Ubiquitous Language (v1.3.0, vocabulário refinado pelo ADR-005; termo `Completed` adicionado pelo ADR-006)

`Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md` originalmente proibia os termos "Signal" e "Confirmation" em favor de "Evidence"/"Decision". O **ADR-005 (Ubiquitous Language Refinement)** revisou essa regra: "Signal" e "Confirmation" deixam de ser termos proibidos — passam a ser termos oficiais do contexto de execução/estratégia (não do Core Domain). "Trigger" continua fora do Core Domain. Com isso, `TradingSignal`, `SignalBuilderService`, `ENUM_TRADING_SIGNAL` e os campos `TrendConfirmed`/`ADXConfirmed`/`RSIConfirmed`/`SessionConfirmed` da Legacy Baseline deixam de representar uma violação de vocabulário.

O termo `Completed` foi adicionado ao vocabulário oficial (ADR-006), representando o estado final da Opportunity — não representa execução de ordem.

## DOMAIN-003 — Evidence (modelo-alvo)

`Docs/02-domain/DOMAIN-003-Evidence.md` define o objeto de domínio imutável `Evidence` (Category/Source/Value/Confidence/Weight/Timestamp/Metadata), rastreado contra REQ-003, REQ-004 e REQ-010. O próprio documento reconhece que, na Legacy Baseline, `TrendService`, `ATRService`, `RSIService`, `ADXService`, `SessionService` e `PivotService` já produzem informações equivalentes a `Evidence`, embora sem essa estrutura formal (sem `EvidenceId`, `Category`, `Weight` ou `Confidence` por evidência individual — a confiança hoje só existe agregada em `MarketAssessment.ConfidenceScore`). Nenhuma migração retroativa é exigida (ADR-001).

## DOMAIN-004 — Market Context (modelo-alvo, v1.1.0)

`Docs/02-domain/DOMAIN-004-Market-Context.md` define o Aggregate Root `Market Context` (ContextId/Asset/Timeframe/Timestamp/Evidence Collection/Summary/Confidence), imutável após construção (BR-005), rastreado contra REQ-002 a REQ-005 e REQ-010. **Atenção a colisão de nome**: a V1 já possui um `struct MarketContext` (`MQL5/Include/TradingOS/Models/MarketContext.mqh`) — mesmo nome, estrutura diferente (mutável, campos públicos escritos diretamente pelo `MarketService`, sem coleção formal de `Evidence`). O próprio DOMAIN-004 reconhece isso na seção "Legacy Baseline". Nenhuma migração retroativa é exigida (ADR-001).

Ciclo de vida próprio adicionado: `Building → Validated → Frozen → Obsolete` (movido de SPEC-005 v1.0 — ver seção SPEC-005 abaixo).

## DOMAIN-005 — Decision (modelo-alvo, v1.1.0)

`Docs/02-domain/DOMAIN-005-Decision.md` define o objeto de domínio imutável `Decision` (DecisionId/OpportunityId/ContextId/Decision Type/Confidence/Rationale/Timestamp), rastreado contra REQ-005 a REQ-010. O próprio documento reconhece que, na Legacy Baseline, `TradingSignal`, `SignalBuilderService` e `ENUM_TRADING_SIGNAL` desempenham parcialmente esse papel — sem `DecisionId`/`OpportunityId`/`ContextId` formais, e sem separação entre Decision (conclusão do domínio) e Signal (representação de execução), distinção que o ADR-005 já formalizou no vocabulário. Nenhuma migração retroativa é exigida (ADR-001/ADR-002).

Ciclo de vida próprio adicionado: `Draft → Generated → Published → Consumed → Archived` (movido de SPEC-005 v1.0 — ver seção SPEC-005 abaixo).

Com DOMAIN-005, a suíte de domínio-alvo está completa: `DOMAIN-001` (Opportunity) → `DOMAIN-003` (Evidence) → `DOMAIN-004` (Market Context) → `DOMAIN-005` (Decision), com `DOMAIN-002` (Ubiquitous Language) definindo o vocabulário comum a todos.

## ARCH-001 — Architecture Blueprint (arquitetura-alvo, v1.2.0)

`Docs/03-architecture/ARCH-001-Architecture-Blueprint.md` define os Bounded Contexts (Core Domain, Infrastructure, Strategy, Execution), as dependências permitidas/proibidas (Core Domain nunca acessa MT5/Broker/Logger/File System/Indicators/APIs/Network) e o fluxo oficial `Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order`, rastreado contra REQ-001 a REQ-010 e DOMAIN-001/003/004/005.

Conforme ADR-006, foi adicionada observação explícita de que Execution é um Bounded Context independente e que Opportunity nunca atravessa o limite entre Core Domain e Execution — a entidade compartilhada entre os contextos é a Decision publicada, materializada como Signal pelo contexto de Execution.

O próprio documento reconhece na seção "Legacy Baseline" que a V1 (`TrendService`, `RSIService`, `ATRService`, `ADXService`, `PivotService`, `SessionService`, `TradingSignal`, `SignalBuilderService`) viola diretamente a dependência proibida "Core Domain → Indicators" (esses serviços chamam `iMA`/`iRSI`/`iATR`/`iADX` diretamente, sem camada de Infrastructure/Adapter). Nenhuma refatoração retroativa é exigida (ADR-001/ADR-002) — a arquitetura-alvo se aplica só a novas evoluções.

`Docs/ARCHITECTURE.md` (a arquitetura informal da V1, referenciada na tabela "Estado atual" acima) e `ARCH-001` coexistem deliberadamente: o primeiro documenta o que existe, o segundo define o que será construído daqui em diante.

## SPEC-001 — Component Model (v1.4.0, Canonical Component Catalog)

`Docs/04-specifications/SPEC-001-Component-Model.md` é agora a **única fonte oficial de nomenclatura arquitetural** do projeto (Canonical Component Catalog), organizada em: Core Domain Builders (Evidence Builder, Market Context Builder), Core Domain Services (Opportunity Service, Decision Service, Confidence Service, Risk Service), Domain Policies (Context Validation Policy, Evidence Validation Policy), Application Services (5 Use Cases — ver SPEC-004), Infrastructure Providers (Data/Indicator/Configuration/Time/Persistence Provider, Logger) e Execution Components (Signal Builder, Order Manager, Position Manager, Broker Adapter, MT5 Adapter). Rastreado contra ARCH-001, SPEC-004, DOMAIN-003/004/005 e REQ-001 a REQ-010.

A tabela "Component Lifecycle" foi atualizada para usar esses nomes canônicos. Destaque: `MT5 Adapter` = Planned (acesso ao MT5 hoje disperso em cada serviço, sem adapter isolado — a mesma violação já apontada em ARCH-001).

**Observação (ainda aberta)**: a lista "Componentes Legacy" do SPEC-001 (TrendService, ATRService, ADXService, RSIService, SessionService, PivotService, TradingSignal, SignalBuilderService, Config, Logger) não menciona `MarketAssessmentService`, `Dashboard` nem `PivotRenderer` — todos já reconhecidos como Legacy Baseline em outros documentos (ver ADR-001 e seção "Legacy Components" abaixo). Divergência de escopo entre documentos, não bloqueante.

## SPEC-002 — Interface Contracts (v1.1.0, nomenclatura estabilizada)

`Docs/04-specifications/SPEC-002-Interface-Contracts.md` define os contratos entre componentes no pipeline `Data Provider → Indicator Provider → Evidence Builder → Market Context Builder → Opportunity Service → Decision Service → Signal Builder → Order Manager`, com pré/pós-condições e tratamento de erros. Rastreado contra ARCH-001, SPEC-001, DOMAIN-003/004/005.

Renomeado para usar os nomes canônicos do SPEC-001: `Evidence Factory` → `Evidence Builder`, `Opportunity Evaluator` → `Opportunity Service`, `Decision Engine` → `Decision Service` (`Market Context Builder` já estava correto).

## SPEC-003 — Domain Services (v1.1.0, escopo restrito)

`Docs/04-specifications/SPEC-003-Domain-Services.md` contém exclusivamente os 4 Domain Services oficiais do SPEC-001: Opportunity Service, Decision Service, Confidence Service, Risk Service (renomeado de "Risk Evaluation Service"). `Evidence Evaluation Service` e `Context Validation Service` foram removidos deste documento — os conceitos equivalentes (Evidence Builder, Evidence Validation Policy, Context Validation Policy) pertencem ao SPEC-001, não a Domain Services. Rastreado contra ARCH-001, SPEC-001, SPEC-002, DOMAIN-001/003/004/005.

## SPEC-004 — Application Services

`Docs/04-specifications/SPEC-004-Application-Services.md` define 5 Use Cases (Analyze Market, Validate Context, Evaluate Opportunity, Generate Decision, Publish Signal) que orquestram Builders, Domain Services e Policies — sem implementar regras de negócio, sem depender diretamente de MT5 Adapter/Broker Adapter/Order Manager/Position Manager. Rastreado contra ARCH-001, SPEC-001/002/003, DOMAIN-003/004/005.

O documento reconhece na seção "Legacy Baseline" que `TradingOS.mq5` (o EA principal) já executa parte dessa orquestração de forma implícita (`OnTimer()`: `Market.Update()` → `SignalBuilder.Build()` → `Dashboard.Update()`), sem um Application Service dedicado — todos os 5 Use Cases estão classificados como Planned no `SPEC-001` (Component Lifecycle). Nenhuma refatoração retroativa é exigida (ADR-001).

## SPEC-005 — Domain Lifecycle (v1.0.0, documento de orquestração)

`Docs/04-specifications/SPEC-005-Domain-Lifecycle.md` **não define estados** — os estados de Opportunity, Market Context e Decision pertencem exclusivamente a DOMAIN-001, DOMAIN-004 e DOMAIN-005, respectivamente. SPEC-005 mapeia, para cada transição já definida nesses documentos, qual Application Service (SPEC-004) orquestra, qual Domain Service (SPEC-001/003) executa a regra de negócio e qual Policy (SPEC-001) valida a transição — usando exclusivamente nomes do Canonical Component Catalog. Onde nenhum componente está definido hoje para uma transição, a célula é marcada `—` (nenhum componente foi inventado).

**Histórico**: a v1.0 original deste documento definia os três ciclos de vida diretamente dentro de SPEC-005, incluindo um ciclo de vida de Opportunity divergente do já existente em DOMAIN-001 (`Draft → Identified → Evaluated → Accepted → Rejected → Expired` vs. `Draft → Qualified → Approved → Executed → Closed → Archived`). Essa divergência foi identificada antes do commit e resolvida por dois movimentos: (1) os estados de Market Context e Decision foram movidos para DOMAIN-004 v1.1.0 e DOMAIN-005 v1.1.0; (2) o próprio ciclo de vida da Opportunity foi revisado pelo **ADR-006** — ver seção abaixo.

## Architecture Stabilization (Opportunity Lifecycle Alignment — ADR-006)

O ciclo de vida da Opportunity, conforme originalmente definido em DOMAIN-001, incluía os estados `Executed`, `Closed` e `Archived` após `Approved`. Esses estados descreviam responsabilidades do contexto de Execution (transformar uma Decision em ordens, posições e histórico), não da entidade Opportunity — que, conforme ARCH-001 e o fluxo oficial `Opportunity → Decision → Signal → Execution → Order`, nunca é executada diretamente.

**ADR-006 (Opportunity Lifecycle Alignment)** formalizou a correção:

- DOMAIN-001 (v1.1.0): ciclo de vida simplificado para `Draft → Qualified → Approved → Completed`. `Completed` representa que a Opportunity produziu uma Decision válida — não representa execução, ordem ou posição.
- DOMAIN-002 (v1.3.0): termo `Completed` adicionado ao vocabulário oficial.
- ARCH-001 (v1.2.0): observação adicionada — Execution é um Bounded Context independente; a entidade compartilhada entre Core Domain e Execution é a Decision publicada (materializada como Signal).
- SPEC-005 (v1.0.0): tabela de orquestração da Opportunity Lifecycle atualizada para `Draft → Qualified → Approved → Completed`, removendo qualquer referência a `Executed`/`Closed`/`Archived` para Opportunity.

Nenhum documento remanescente referencia `Opportunity Executed`, `Opportunity Closed` ou `Opportunity Archived` (validado antes do commit).

## SPEC-006 — Business Rules (v1.0.0)

`Docs/04-specifications/SPEC-006-Business-Rules.md` consolida as regras de negócio do domínio em numeração global própria: BR-1xx (Validação, Evidence/Market Context), BR-2xx (Contexto/Market Context), BR-3xx (Opportunity), BR-4xx (Decision), BR-5xx (Execution Boundary). Não define componentes, arquitetura ou algoritmos — apenas consolida a definição funcional já existente, distribuída hoje entre serviços do Expert Advisor (Legacy Baseline). Rastreado contra DOMAIN-001/003/004/005, ARCH-001, SPEC-003/004, ADR-006.

**Divergência aberta (não bloqueante)**: DOMAIN-001 e DOMAIN-005 já possuem suas próprias regras de negócio numeradas localmente (`BR-001` a `BR-006`, por entidade). SPEC-006 introduz uma numeração global paralela (`BR-1xx` a `BR-5xx`) sem declarar a correspondência entre as duas — por exemplo, não há indicação de qual `BR-00x` local (se algum) equivale a `BR-101`/`BR-301`/`BR-401`. Os dois esquemas não colidem tecnicamente (namespaces distintos), mas a ausência de mapeamento explícito é uma lacuna de rastreabilidade a ser resolvida em revisão futura.

## Architecture Stabilization (taxonomia)

Consolidação da nomenclatura arquitetural entre SPEC-001/002/003, eliminando 3 variações de nome para os mesmos papéis que existiam antes desta estabilização:

| Papel | Nome antes (por documento) | Nome canônico (SPEC-001) |
|---|---|---|
| Market Context → Opportunity | Strategy Engine (SPEC-001) / Opportunity Evaluator (SPEC-002) / Opportunity Service (SPEC-003) | **Opportunity Service** |
| Opportunity → Decision | — (SPEC-001) / Decision Engine (SPEC-002) / Decision Service (SPEC-003) | **Decision Service** |
| Dados técnicos → Evidence | — (SPEC-001) / Evidence Factory (SPEC-002) | **Evidence Builder** |
| Avaliação de risco | Risk Evaluator (SPEC-001) / Risk Evaluation Service (SPEC-003) | **Risk Service** |

`SPEC-001` passa a ser a fonte única de nomenclatura (ver regra "Canonical Naming" em `AGENTS.md`); `SPEC-002`/`SPEC-003` foram atualizados para reutilizar exatamente esses nomes.

## AUDIT-001 — Architecture Baseline Audit (v1.0.0)

`Docs/06-validation/AUDIT-001-Architecture-Baseline.md` audita os 36 documentos do repositório contra si mesmos (vocabulário, componentes, arquitetura, rastreabilidade), exclusivamente por leitura direta. Identificou 14 inconsistências reais (2 Críticas, 3 Altas, 5 Médias, 4 Baixas) — nenhuma delas invalida o modelo de domínio ou a arquitetura-alvo construídos ao longo deste changelog.

## RC-001 — Release Candidate (fechamento de achados Críticos e Altos do AUDIT-001)

RC-001 corrigiu exatamente os achados Críticos e Altos do AUDIT-001, sem criar novos conceitos de domínio, novos componentes, sem alterar arquitetura e sem modificar decisões de ADR:

- Finding #1 (Crítico — CLAUDE.md/AGENTS.md com ordem de precedência divergente): resolvido — hierarquia unificada (DOCUMENT_CONTROL → CONSTITUTION → ADR → DOMAIN → ARCH → SPEC → ENGINEERING → REFERENCE → VALIDATION → ROADMAP) replicada identicamente em `CLAUDE.md`, `AGENTS.md` e `.project-rules/DOCUMENT_CONTROL.md` (v1.1.0).
- Finding #2 (Crítico — DOCUMENT_CONTROL.md referenciando pastas inexistentes): resolvido — Regras 13/14/15 corrigidas para `knowledge/papers/`/`knowledge/articles/`, `05-decisions/`, `10-rfc/`; árvore oficial adicionada a `DOCUMENT_CONTROL.md`; `CLAUDE.md` (terceira variante divergente) corrigido para a mesma árvore de `AGENTS.md`/`DOCUMENT_INDEX.md`.
- Finding #3 (Alto — Risk Profile sem DOMAIN próprio): não resolvido arquiteturalmente (proibido criar DOMAIN novo nesta etapa) — tratado via triagem formal: `AUDIT-001` marcado com status "Architectural Gap"; `RFC-001` criado, classificado "Requires Architectural Decision".
- Finding #4 (Alto — Strategy Bounded Context sem componentes em SPEC-001): decisão registrada (Opção A — Strategy permanece, necessita futura especificação), baseada em REQ-011/ADR-003/ARCH-001/DOMAIN-002. `ARCH-001` não foi alterado (só a Opção B exigiria alteração). A categoria correspondente em SPEC-001 permanece como trabalho futuro, não bloqueante.
- Finding #5 (Alto — ADR-004 não referenciado em CLAUDE.md/AGENTS.md): resolvido — seções "Testes" de ambos os documentos agora referenciam explicitamente o pipeline de validação do ADR-004. ADR-004 permanece inalterado.

Achados Médios (#6-#10) e Baixos (#11-#14) do AUDIT-001 permanecem em aberto — fora do escopo do RC-001 por instrução explícita. Ver `Docs/06-validation/AUDIT-001-CLOSURE.md` para a matriz de severidade e estimativa de maturidade pós-RC-001.

## ADR-007 — Architecture Baseline v1.0 Freeze

`Docs/05-decisions/ADR-007-Architecture-Baseline-v1.0-Freeze.md` formaliza o congelamento da Baseline v1.0, já registrado como observação em `.project-rules/DOCUMENT_CONTROL.md` (v1.2.0). Escopo congelado: Governança (`ENG-000`, `CONST-001`, `VISION-001`, `DOCUMENT_CONTROL`, `CLAUDE.md`, `AGENTS.md`), Domínio (`DOMAIN-001` a `DOMAIN-005`), Arquitetura (`ARCH-001`) e Especificações (`SPEC-001` a `SPEC-006`). Alterações a esses documentos exigem, a partir de agora, um novo ADR, uma RFC aprovada, ou justificam-se apenas como correção documental sem impacto arquitetural.

`Requirements` (`REQ-001`) foi explicitamente excluído deste congelamento — permanece livre para evoluir sem ADR/RFC prévia, desde que a mudança não toque o domínio ou a arquitetura já congelados.

## INFRA-001 — Infrastructure Overview (Fase 2, Entrega 01)

`Docs/03-architecture/INFRA-001-Infrastructure-Overview.md` inaugura a Fase 2 (Platform Foundation), detalhando a camada Infrastructure já delimitada por `ARCH-001` (responsabilidades, limites, dependências permitidas/proibidas, matriz de dependências, princípios, diagrama). Rastreado contra `ARCH-001`, `SPEC-001` a `SPEC-006`, `ADR-001` a `ADR-006`, e respeita o congelamento de `ADR-007` — nenhum documento da Baseline foi alterado.

Componentes citados (Data Provider, Indicator Provider, Configuration Provider, Persistence Provider, Logger, Time Provider, Broker Adapter, MT5 Adapter) usam exclusivamente os nomes e categorias já registrados em `SPEC-001`. `Broker Adapter`/`MT5 Adapter` são catalogados em SPEC-001 como Execution Components — sua citação em INFRA-001 reflete uma ambiguidade já preexistente em `ARCH-001` (que cita ambos tanto na seção Infrastructure quanto na seção Execution), não uma reclassificação nova.

Dois itens do brief de origem — `Event Dispatcher` e `Scheduler` — não constam no Canonical Component Catalog (`SPEC-001`). Por não haver autorização para criar componentes novos fora do processo formal (`AGENTS.md` — Canonical Naming; `ADR-007` — Baseline Freeze), foram registrados em `RFC-002` (Infrastructure Candidate Components), classificados "Requires Architectural Decision", e não incorporados como componentes aprovados em INFRA-001.

**v1.1.0**: adicionada a seção "Princípio de Evolução", declarando que a camada Infrastructure deve permanecer compatível com futura integração de `Learning Engine`, `Knowledge Repository`, `Performance Analyzer` e `Recommendation Engine` via Ports & Adapters/Dependency Inversion, sem dependências diretas. Nenhum desses quatro nomes consta em SPEC-001; diferente de `Event Dispatcher`/`Scheduler`, não foram tratados como RFC nesta entrega, por não serem apresentados como componentes da camada — apenas como possíveis destinos de integração futura.

## INFRA-002 — Data Provider (Fase 2, Entrega 02)

`Docs/03-architecture/INFRA-002-Data-Provider.md` detalha o Port `Data Provider` (catalogado em `SPEC-001`, contratado em `SPEC-002`): responsabilidades, portas públicas (contratos, sem implementação), dependências permitidas/proibidas, extensibilidade, qualidade, diagrama, casos de uso, Definition of Ready/Done. Rastreado contra `ARCH-001`, `SPEC-001`, `SPEC-002`, `INFRA-001`. Respeita o congelamento de `ADR-007` — nenhum documento da Baseline foi alterado.

Correção de vocabulário aplicada diretamente (sem RFC, por ser conformidade com regra já existente, não uma nova decisão): a porta `GetMarketState()` do brief de origem foi renomeada para `GetMarketStatus()`, pois `DOMAIN-002` proíbe explicitamente o termo "Market State".

Seis nomes citados no brief de origem (`Replay Adapter`, `CSV Provider`/`CSV Adapter`, `Mock Provider`, `REST Adapter`, `FIX Adapter`, `WebSocket Adapter`) não constam no Canonical Component Catalog (`SPEC-001`). Registrados em `RFC-003` (Data Provider Candidate Adapters), classificados "Requires Architectural Decision", e não incorporados como dependências aprovadas em INFRA-002. `MT5 Adapter` foi referenciado usando a categorização já existente em SPEC-001 (Execution Component), mesma observação já feita em INFRA-001.

## INFRA-003 — Indicator Provider (Fase 2, Entrega 03)

`Docs/03-architecture/INFRA-003-Indicator-Provider.md` detalha o Port `Indicator Provider` (catalogado em `SPEC-001`, contratado em `SPEC-002`): responsabilidades, fonte de dados restrita ao `Data Provider`, modelo uniforme de resultado, portas públicas, dependências permitidas/proibidas, requisitos não funcionais, padronização, extensibilidade, diagrama, casos de uso, observabilidade, Definition of Ready/Done, critérios de teste. Rastreado contra `ARCH-001`, `SPEC-001`, `SPEC-002`, `SPEC-003`, `INFRA-001`, `INFRA-002`. Respeita o congelamento de `ADR-007` — nenhum documento da Baseline foi alterado.

Diferente de `INFRA-001`/`INFRA-002`, nenhum componente candidato novo foi solicitado nesta entrega — todos os itens do brief (ATR/RSI/ADX/EMA/SMA/MACD/Bollinger/VWAP) são valores produzidos pelo único componente já canônico `Indicator Provider`, não componentes separados.

A Validação Prévia (Document Validation Pipeline) identificou, no entanto, uma divergência preexistente entre dois documentos da própria Baseline: `SPEC-001` (Component Lifecycle) mapeia `TrendService`/`ATRService`/`RSIService`/`ADXService` para `Indicator Provider` (Infrastructure Providers); `SPEC-003` (Legacy Baseline) mapeia os mesmos quatro serviços para `Evidence Builder` (Core Domain Builders) — dois componentes de camadas arquiteturais diferentes. Nenhum dos dois documentos foi alterado (ambos congelados por `ADR-007`). Registrada em `RFC-004` (Legacy Indicator Mapping Ambiguity), classificada "Requires Architectural Decision". `INFRA-003` seguiu o mapeamento de `SPEC-001` por ser o Canonical Component Catalog, sem resolver a divergência com `SPEC-003`.

## ADR-008 — Roadmap Restructuring (Trilhas Paralelas, v1.1.0)

`Docs/05-decisions/ADR-008-Roadmap-Restructuring-Parallel-Tracks.md` reestrutura o roadmap em três trilhas: Platform (Infrastructure/Execution/MT5/Persistence/Logging/Configuration, sem pausa), Validation (inicia agora, em paralelo — Strategy Baseline/Backtest/Walk Forward/Forward Test/Performance Reports/Edge Validation, em `06-validation/`), Learning (após existir histórico real de operações — Knowledge/Learning Engine/Recommendation Engine/Optimization/Machine Learning, fora do escopo da Release 1.0). É explicitamente uma decisão de sequenciamento, não de arquitetura: `ARCH-001` e seus Bounded Contexts permanecem inalterados.

**v1.1.0** incorpora conteúdo de um segundo brief que originalmente pedia um novo `ADR-007-Parallel-Development-Strategy.md` — id já ocupado por `ADR-007` (Architecture Baseline v1.0 Freeze), e conteúdo central (3 trilhas) já registrado neste próprio ADR-008. Por decisão do usuário, o conteúdo inédito (Release 1.0 — Definition of Done: operar automaticamente, executar ordens, controlar risco, logs, Backtest, Forward Test, métricas; e a regra de governança "Milestone Scoping": toda funcionalidade nova deve responder se é necessária ao Milestone atual, senão vai para o backlog) foi incorporado a este documento em vez de gerar um ADR duplicado, preservando a Regra 19 do `DOCUMENT_CONTROL` (nunca duplicar conhecimento).

## VALIDATION-001 — Trading Strategy Validation Baseline (Trilha 2, v2.0.0)

`Docs/06-validation/VALIDATION-001-Trading-Strategy-Validation-Baseline.md` (renomeado de `Trading-Strategy-Baseline.md` via `git mv`, histórico preservado) define o protocolo oficial de validação da estratégia da Release 1.0. Estrutura em teste de hipótese formal: H1 ("a estratégia possui expectativa positiva") vs. H0, mais hipóteses secundárias de robustez (ativos/timeframes/períodos/regimes/sensibilidade a parâmetros).

Mantém da v1.0.0: a estratégia a validar é a própria Legacy Baseline V1 (`MarketService` → `MarketAssessmentService` → `SignalBuilderService`), já que nenhum componente do modelo-alvo está implementado; critérios de entrada referenciados sem alteração (BUY/SELL exige 4 confirmações + HIGH confidence; WAIT exige bias + ≥2 confirmações); mapeamento ao pipeline do `ADR-004` (Strategy Tester/Historical Simulation → `BACKTEST-001`; Walk Forward → `WALKFORWARD-001`; Demo Validation → `FORWARDTEST-001`).

Adicionado na v2.0.0: Universo de Teste consolidado (ativos, timeframes, sessões, período histórico, quantidade mínima de operações, fonte de dados, versão do histórico); Protocolo de Teste de 7 etapas fixas (versão do código → versão da estratégia → parâmetros → backtest → registro → validação de critérios → relatório); **Hipótese de Risco** — usa explicitamente a recomendação da `RFC-005` (Stop ATR + Stop Temporal + Percentual por Risco) como hipótese de teste, não decisão, até ADR próprio aprovar a gestão de risco definitiva; 10 Métricas Obrigatórias; Critérios de Aprovação/Reprovação (categorias, valores a parametrizar); Reprodutibilidade (hash do commit, versão, data, operador, ativo, timeframe, fonte, configuração); Evidências Obrigatórias (PDF, resultados brutos, logs, config, capturas do Strategy Tester); Modelo de Relatório de 8 seções; Dependências — com gap real registrado: `Risk Service`, `Order Manager`, `Position Manager` e `MT5 Adapter` (todos `SPEC-001`, status Planned/Future) ainda não implementados, então `BACKTEST-001` inicial deverá rodar sobre a Legacy Baseline via Strategy Tester nativo do MT5; Limitações; Definition of Done.

O termo "Execution Engine", citado no brief de origem, não foi incorporado por não constar no Canonical Component Catalog (`SPEC-001`) — referenciados em seu lugar os componentes já catalogados (`Order Manager`, `Position Manager`).

Gestão de risco definitiva e critérios de saída definitivos seguem fora do escopo de decisão deste documento — usados apenas como hipótese de teste, conforme `ADR-008`.

## RFC-005 — Trading Risk & Exit Strategy

`Docs/10-rfc/RFC-005-Trading-Risk-Exit-Strategy.md` (solicitado originalmente como `RFC-004`, renumerado por colisão de id) analisa — sem decidir — alternativas de saída de posição (Stop Fixo, Stop baseado em ATR, Stop por Estrutura de Mercado, Stop Temporal, Trailing Stop, Break-even) e de Position Sizing (Lote Fixo, Percentual de Capital, Percentual por Risco, Volatilidade/ATR), necessárias para que `VALIDATION-001` possa executar o primeiro `BACKTEST-001`.

Recomendação registrada (não uma decisão): Stop baseado em ATR + Stop Temporal como saída da Release 1.0, Percentual por Risco como position sizing — ambos reaproveitando componentes já especificados (`Indicator Provider`/`Time Provider`, `INFRA-002`/`INFRA-003`), sem exigir componente novo. `Stop por Estrutura de Mercado`, se um dia adotado, exigiria um Provider/Service novo, hoje não catalogado em `SPEC-001` — RFC própria seria necessária antes de qualquer implementação.

A recomendação depende de aprovação via ADR próprio antes de influenciar `DOMAIN`, `SPEC` ou `Risk Service` (`SPEC-001`, status `Planned`). Nenhum documento da Baseline foi alterado por esta RFC.

## BACKTEST-001 — Backtest Execution Protocol

`Docs/06-validation/BACKTEST-001-Backtest-Execution-Protocol.md` define exclusivamente o procedimento operacional de execução de Backtests — não registra resultados, não aprova estratégias, não altera regras de negócio. Rastreado contra `VALIDATION-001`: usa o mesmo Universo de Teste, a mesma Hipótese de Risco (via `RFC-005`) e é consistente com o Protocolo de Teste de 7 etapas de `VALIDATION-001` (aqui detalhado em 10 etapas operacionais específicas do MT5, sem contradição — nível de abstração diferente, mesmo processo). Define Entradas, Ambiente, Saídas Obrigatórias, Controle de Qualidade, Critérios de Invalidação, convenção de Armazenamento e Definition of Done. Nenhum documento `DOMAIN`/`ARCH`/`SPEC`/`ADR` foi alterado.

## DATA-001 — Validation Data & Evidence Repository Standard

`Docs/06-validation/DATA-001-Validation-Data-Repository-Standard.md` padroniza a organização física dos artefatos de validação (`validation-runs/Campaign-NNN/Test-NNN/{Config,Reports,Logs,Raw,Screenshots}`), convenção de nomes, metadados (reutiliza exatamente os campos já exigidos por `VALIDATION-001`/`BACKTEST-001`, sem redefini-los), retenção e rastreabilidade. Rastreado contra `VALIDATION-001`, `BACKTEST-001`.

A pasta raiz proposta no brief de origem (`Validation/`) foi renomeada para `validation-runs/` para evitar colisão de nome com `Docs/06-validation/` (documentos `.md` de protocolo) — mesma preocupação de nomenclatura já registrada em `ADR-008` ao decidir não criar um segundo diretório `validation/`.

Registrada recomendação (não decisão): `Raw/` e `Screenshots/` não deveriam ser versionados diretamente no Git principal, dado o precedente de binários no histórico já apontado em `Docs/TECH_DEBT.md` (item 8) — avaliar armazenamento externo ou Git LFS antes do primeiro backtest real.

## EXEC-001 — Order Manager (novo prefixo EXEC-00X)

`Docs/03-architecture/EXEC-001-Order-Manager.md` detalha o Execution Component `Order Manager` (já catalogado em `SPEC-001`, status `Future`). Solicitado originalmente como `SPEC-006` — colisão de id com `SPEC-006-Business-Rules.md` já existente, e, mais relevante, os documentos `SPEC-00X` sempre trataram categorias inteiras de componentes, não componentes isolados. Segue o padrão já estabelecido por `INFRA-00X` (`Data Provider`, `Indicator Provider`) para detalhamento de componente único, agora sob prefixo `EXEC-00X`, reservado para Execution Components (`SPEC-001`: Signal Builder, Order Manager, Position Manager, Broker Adapter, MT5 Adapter).

Especifica responsabilidades, entradas/saídas, máquina de estados com condições de transição explícitas, validações pré-envio, tratamento de erros, eventos, interface conceitual, dependências e casos de teste. Rastreado contra `ARCH-001`, `SPEC-001`, `SPEC-002`, `SPEC-003`, `INFRA-002`, `INFRA-003`.

Dependência registrada, não uma inconsistência: `Order Manager` consome `Risk Result`, cujo formato depende da classificação de `Risk Profile` — ainda `Open` em `RFC-001`. `EXEC-001` consome esse dado como entrada abstrata, sem antecipar sua estrutura; poderá exigir revisão de compatibilidade quando `RFC-001` for decidida.

## EXEC-002 — Position Manager

`Docs/03-architecture/EXEC-002-Position-Manager.md` detalha o Execution Component `Position Manager` (já catalogado em `SPEC-001`, status `Future`). Solicitado originalmente como `SPEC-007` — mesmo tratamento já aplicado a `EXEC-001`: componente único segue o prefixo `EXEC-00X`, não `SPEC-00X`.

Especifica responsabilidades, entradas (originadas em `EXEC-001` — Order Accepted/Filled/Modified/Closed), saídas, máquina de estados de 7 estágios com condições de transição explícitas, atributos mínimos da posição, validações, eventos, interface de consulta, dependências e casos de teste. Rastreado contra `ARCH-001`, `SPEC-001`, `EXEC-001`.

Mesma dependência não satisfeita já registrada em `EXEC-001`: consumo por `Risk Service` depende da classificação de `Risk Profile`, ainda `Open` em `RFC-001`.

## ADR-009 — Baseline Lock v1.1

`Docs/05-decisions/ADR-009-Baseline-Lock-v1.1.md` congela a estrutura documental do repositório a partir deste ponto: nenhuma nova reorganização, renumeração ou movimentação de documentos entre pastas; `DOCUMENT_INDEX.md` reafirmado como fonte de verdade obrigatória antes de qualquer criação/numeração/renomeação; famílias documentais fechadas (Governança, Arquitetura, Especificações, Validação, Roadmap); família `EXEC-*` confirmada oficialmente para Execution Components, retroativa a `EXEC-001`/`EXEC-002`; `ADR-007` reafirmado sem alteração; prioridade do projeto redirecionada para a Primeira Execução; sequência de entrega travada (`EXEC-001`→`EXEC-002`→`EXEC-003`→`EXEC-004`→`EXEC-005`→Sprint 1→Primeira Execução).

Duas observações registradas no próprio ADR (não bloqueantes, não exigem ação agora): "Signal Engine" do brief de origem corrigido para o nome canônico `Signal Builder` (`SPEC-001`) em `EXEC-004`; `Risk Service` (`EXEC-003`) é Core Domain Service em `SPEC-001`, não Execution Component — `EXEC-003` é apenas rótulo de posição na sequência de entrega, não reclassificação de Bounded Context. A futura especificação detalhada de `Risk Service` deverá deixar essa distinção explícita.

Por instrução explícita do Product Owner, este ADR não será revisitado até a conclusão da Primeira Execução.

## EXEC-003 — Risk Service (Pre-Order Risk Gate) e RFC-006

`Docs/03-architecture/EXEC-003-Risk-Service.md` detalha um gate operacional de risco pré-envio de ordem, terceiro item da sequência travada em `ADR-009`. Especifica responsabilidades, entradas/saídas, Risk Evaluation Result, validações (todas parametrizáveis), máquina de estados, eventos, interface conceitual, dependências e casos de teste.

**Divergência arquitetural real, identificada na Validação Prévia (não introduzida por este documento)**: `SPEC-003` (Domain Services, congelado) já define `Risk Service` com um contrato incompatível — Core Domain Service, Entrada `Opportunity`/`Market Context`, Saída `Risk Profile`. `EXEC-003` descreve um componente operacional diferente — gate pré-envio, Entrada `Signal Result`/`Account Information`/`Current Exposure`, Saída `Risk Approved`/`Rejected` + `Risk Evaluation Result`. Os dois contratos não descrevem o mesmo componente. Nenhum dos dois documentos (`SPEC-003`, congelado; `EXEC-003`, recém-criado) foi alterado para forçar compatibilidade — a divergência foi registrada em `RFC-006` (Risk Service Contract Divergence), com 3 alternativas de reconciliação apresentadas sem decisão (componentes distintos com nomes próprios; mesmo componente com dois modos, exigindo atualização de SPEC-003; ou o gate pertence na verdade a `Order Manager`).

Adicionalmente, `Account Provider` (dependência citada em `EXEC-003`) não consta no Canonical Component Catalog (`SPEC-001`) — registrado na mesma `RFC-006`, pendente de catalogação formal antes de ser tratado como dependência aprovada por qualquer outro documento.

## EXEC-004 — Signal Builder e RFC-007 (divergência séria)

`Docs/03-architecture/EXEC-004-Signal-Builder.md` (renomeado de "Signal Engine" no brief de origem, mesma correção de ADR-009) detalha o quarto item da sequência travada em `ADR-009`. Especifica um mecanismo de geração de sinal a partir de indicadores e regras de negócio: entradas, SignalResult, decisões permitidas (BUY/SELL/NO_SIGNAL), pipeline de 6 estágios, filtros, tratamento de conflitos, eventos, interface conceitual, dependências e casos de teste.

**Divergência arquitetural séria, identificada na Validação Prévia (não introduzida por este documento)**: `ARCH-001` define o fluxo oficial `Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order`; `SPEC-002` (congelado) já define `Signal Builder` como Entrada `Decision` → Saída `Signal` → Consumidor `Order Manager`. O pipeline descrito em `EXEC-004` consome `Market Context`/`Indicator Snapshot` **diretamente** e entrega a `Risk Service` (`EXEC-003`) — contornando inteiramente as etapas `Opportunity` (`DOMAIN-001`) e `Decision` (`DOMAIN-005`) do Core Domain. `EXEC-003` e `EXEC-004`, juntos, descrevem um pipeline operacional coerente entre si, mas paralelo ao fluxo oficial da Baseline — não uma variação de nome, um desvio estrutural do uso de `Opportunity`/`Decision`.

Nenhum documento (`ARCH-001`, `SPEC-002`, congelados; `EXEC-004`, recém-criado) foi alterado para forçar compatibilidade. Registrada em `RFC-007` (Signal Builder Pipeline Divergence), severidade alta, com 3 alternativas de reconciliação apresentadas sem decisão: (1) `EXEC-003`/`EXEC-004` são um MVP operacional intencional, mais curto que o fluxo de Core Domain, a ser explicitado como tal; (2) mal-entendido de terminologia — `EXEC-004` deveria consumir `Decision`, não `Market Context` diretamente; (3) o Core Domain é considerado redundante para a Release 1.0, o que revisitaria `ADR-002` e o investimento em `DOMAIN-001`/`DOMAIN-005`/`SPEC-003`. Recomendado resolver via ADR antes de qualquer implementação de `EXEC-003`/`EXEC-004`.

## EXEC-005 — MT5 Adapter (fim da sequência travada, ADR-009)

`Docs/03-architecture/EXEC-005-MT5-Adapter.md` detalha o quinto e último Execution Component da sequência travada em `ADR-009`. Especifica isolamento total da API MT5 (nenhum outro componente pode conhecer tipos da API MT5), 8 operações conceituais, tratamento de erro, eventos e dependências (exclusivamente a API MT5 — nenhuma dependência de negócio). Rastreado contra `ARCH-001`, `SPEC-001`, `EXEC-001`, `EXEC-002`.

Nenhuma divergência arquitetural nova foi encontrada — primeira entrega da série `EXEC-00X` sem RFC associada. Registrada apenas uma observação de rastreabilidade (não uma inconsistência): `GetAccount()`/`Account Snapshot`, aqui definidos, podem ser a origem real do dado que `EXEC-003` (Risk Service) esperava de um "Account Provider" não catalogado (`RFC-006`) — relevante para quando essa RFC for resolvida, sem decidir nada agora.

Com `EXEC-005`, a sequência travada `EXEC-001 → EXEC-002 → EXEC-003 → EXEC-004 → EXEC-005` (`ADR-009`) está completa. O próximo item da sequência é Sprint 1, que — por instrução do Product Owner — permanece condicionado à revisão pendente de `RFC-006` e `RFC-007` antes de avançar.

## Post-Execution Architecture Review — RFC-007 e RFC-006 resolvidas

Após a conclusão de `EXEC-001` a `EXEC-005` (`ADR-009`), as duas divergências identificadas durante sua elaboração foram formalmente resolvidas.

**`RFC-007` (v2.0.0, Approved)** — comparou Alternativa A (`Indicators → Opportunity → Risk Service → Decision → Order Manager`, o fluxo de `ARCH-001`/`DOMAIN-001`/`DOMAIN-005`/`SPEC-003`) contra Alternativa B (`Indicators → Decision → Risk Service → Order Manager`, o que `EXEC-003`/`EXEC-004` já especificavam). **Decisão: Alternativa B é o pipeline normativo da Release 1.0** — justificada pela prioridade de Primeira Execução (`ADR-009`): a Alternativa A exigiria implementar `Opportunity Service`, `Decision Service`, `Market Context Builder` e `Evidence Builder` do zero (0% implementados hoje), enquanto a Alternativa B reaproveita a Legacy Baseline já implementada/compilando mais a camada `EXEC-00X` já inteiramente especificada.

Esta decisão é de **escopo de implementação da Release 1.0**, não uma alteração arquitetural: `ARCH-001`, `DOMAIN-001`, `DOMAIN-005` e `SPEC-003` permanecem congelados e válidos como arquitetura-alvo de longo prazo, conforme já estabelecido por `ADR-001`/`ADR-002` (Legacy Baseline convive com o modelo-alvo; migração só ocorre com benefício real).

**`RFC-006` (v2.0.0, Approved)**, resolvida em alinhamento com `RFC-007` — pergunta: `Risk Service` é Domain Service ou Gate Operacional? **Decisão: Gate Operacional**, exatamente como já especificado em `EXEC-003`, para a Release 1.0. O contrato de Domain Service em `SPEC-003` (Entrada Opportunity/Market Context, Saída Risk Profile) não é revogado — permanece válido para quando o Core Domain for implementado. Recomendação registrada para Release 2.0 (não aplicada agora): nomear os dois papéis separadamente no Canonical Component Catalog (ex.: `Risk Service` para o Domain Service, `Pre-Order Risk Gate` para o operacional), e formalizar a conexão entre `Account Provider` (gap de `RFC-006`) e `MT5 Adapter.GetAccount()`/`Account Snapshot` (observação de `EXEC-005`).

**Nenhuma alteração foi feita em `EXEC-001` a `EXEC-005`** — ambas as decisões confirmam que os cinco documentos já estavam corretamente especificados segundo a Alternativa B. Com estas duas resoluções, a fase de arquitetura da Release 1.0 é considerada encerrada por instrução do Product Owner; o próximo trabalho é exclusivamente implementação, rumo à Primeira Execução.

`ADR-009` atualizado para v1.1.0 com o critério formal de reabertura: após a aprovação de `RFC-006`/`RFC-007`, qualquer discussão arquitetural só pode ser reaberta mediante evidência obtida durante implementação, testes ou Primeira Execução — nunca por hipótese ou preferência conceitual. Toda ideia levantada a partir de agora sem essa evidência vai automaticamente para o backlog da Release 2.0, sem pausar a implementação em curso.

## ROADMAP-001 — Sprint 1 (Foundation)

`Docs/09-roadmap/ROADMAP-001-Sprint-1-Foundation.md` inaugura a família `ROADMAP-*` (congelada em `ADR-009`, até então sem uso). Solicitado originalmente como `IMPLEMENTATION-001` em uma pasta `Docs/07-implementation/` inexistente na árvore oficial travada (a posição `07` pertence a `07-testing/`) — corrigido para a família já prevista, sem exigir reorganização nova nem violar `ADR-009`.

Define o plano executivo da Sprint 1: objetivos (compilar/inicializar/config/logging/versão/Event Bus/estado Idle, sem estratégia ou execução), escopo restrito a infraestrutura comum, fora de escopo explícito (`EXEC-001` a `EXEC-005` permanecem apenas contrato nesta sprint), checklist de implementação e critérios de aceitação objetivos (Build OK, zero erros/warnings). Rastreado contra `ADR-009`, `RFC-006`, `RFC-007`, `EXEC-001` a `EXEC-005`, `ADR-004`.

Nenhuma arquitetura, contrato ou componente foi alterado por este documento.

## ROADMAP-002 — Sprint 2 (Market Data & Indicators)

`Docs/09-roadmap/ROADMAP-002-Sprint-2-Market-Data-Indicators.md` — mesma correção de família/pasta já aplicada em `ROADMAP-001` (era `IMPLEMENTATION-002` em `Docs/07-implementation/`). Define o plano executivo da Sprint 2: implementação de `Data Provider`/`Indicator Provider` usando exatamente os contratos já definidos em `INFRA-002`/`INFRA-003`, sem alterá-los; Market Snapshot/Indicator Snapshot; cache; atualização por Tick/Candle. Fora de escopo: `Signal Builder`, `Risk Service`, `Order Manager`, `Position Manager`, execução. Rastreado contra `ADR-009`, `ROADMAP-001`, `INFRA-002`, `INFRA-003`, `ADR-004`.

Nenhuma arquitetura, contrato ou componente foi alterado por este documento.

## ROADMAP-003 — Sprint 3 (Signal Evaluation & Risk Validation)

`Docs/09-roadmap/ROADMAP-003-Sprint-3-Signal-Risk.md` define o plano executivo da Sprint 3: implementação de `EXEC-004` (Signal Builder) e `EXEC-003` (Risk Service), exatamente conforme já especificados.

**Divergência real identificada e corrigida na Validação Prévia (não introduzida por este documento, e não tratada como nova RFC)**: o brief de origem descrevia o pipeline como `Signal Engine → Opportunity → Risk Service → Decision`. Isso contradiz diretamente a Alternativa B já decidida em `RFC-007` (`Indicators → Decision → Risk Service → Order Manager`, sem estágio `Opportunity`, com `Risk Service` produzindo aprovação/rejeição, não uma `Decision`) e os contratos textuais já existentes de `EXEC-004` (saída `SignalResult`) e `EXEC-003` (saída `Risk Approved`/`Risk Rejected`/`Risk Evaluation Result`). `Opportunity` e `Decision` pertencem ao Core Domain (`DOMAIN-001`/`DOMAIN-005`, congeladas) — nomeá-los como saída de componentes de Execution reintroduziria o cruzamento de camada que `RFC-007` decidiu evitar, sem nenhuma evidência de implementação/teste, que `ADR-009` §8 exige para reabrir essa decisão. `ROADMAP-003` foi escrito usando os nomes já aprovados (`Signal Result`, `Risk Approved`/`Risk Rejected`); nenhuma RFC nova foi aberta, pois `RFC-007` já resolveu esta exata questão.

Rastreado contra `ADR-009`, `RFC-006`, `RFC-007`, `ROADMAP-001`, `ROADMAP-002`, `EXEC-003`, `EXEC-004`, `INFRA-002`, `INFRA-003`. Fora de escopo: `EXEC-001`, `EXEC-002`, `EXEC-005`, envio de ordens, integração MT5.

## ROADMAP-004 — Sprint 4 (Order Execution Integration)

`Docs/09-roadmap/ROADMAP-004-Sprint-4-Order-Execution.md` define o plano executivo da Sprint 4: implementação de `EXEC-001` (Order Manager), `EXEC-002` (Position Manager) e `EXEC-005` (MT5 Adapter), exatamente conforme já especificados.

Ajuste de terminologia aplicado (cosmético — diferente da divergência de pipeline corrigida em `ROADMAP-003`): o brief usava "Decision" como gatilho de `Order Manager` e "Execution Result" como saída de `MT5 Adapter`. `EXEC-001` já especifica suas entradas como `Signal Result`/`Risk Result`/`Symbol Information`/`Configuration`; `EXEC-005` já especifica sua saída como `Order Response`. `ROADMAP-004` usa os termos exatos já aprovados.

Rastreado contra `ADR-009`, `RFC-006`, `RFC-007`, `ROADMAP-001` a `ROADMAP-003`, `EXEC-001`, `EXEC-002`, `EXEC-005`. Fora de escopo: novas estratégias, novos indicadores, gestão de portfólio, multiativo, otimizações.

## ROADMAP-005 — Sprint 5 (First Execution & End-to-End Validation)

`Docs/09-roadmap/ROADMAP-005-First-Execution.md` define a validação ponta a ponta do pipeline completo, sem implementar componente novo — exercita `INFRA-002`/`INFRA-003`/`EXEC-001` a `EXEC-005` já implementados nas sprints anteriores.

A mesma divergência de pipeline identificada em `ROADMAP-003` (`Opportunity`/`Decision` como estágios, incompatíveis com a Alternativa B de `RFC-007`) reapareceu no brief de origem deste documento, junto com "Execution Result" (deveria ser `Order Response`, per `EXEC-005`). Corrigida da mesma forma, sem abrir nova RFC — `RFC-007` já resolveu esta questão e não há evidência de implementação/teste (`ADR-009` §8) que justifique reabri-la.

Rastreado contra `ADR-009`, `RFC-006`, `RFC-007`, `ROADMAP-001` a `ROADMAP-004`, `INFRA-002`, `INFRA-003`, `EXEC-001` a `EXEC-005`, `DATA-001` (convenção de evidências reaproveitada). Marca o encerramento formal da Release 1.0 após sua conclusão.

## ADR-010 — Learning Domain (novo Bounded Context)

`Docs/05-decisions/ADR-010-Learning-Domain-Bounded-Context.md` (v1.1.0, Accepted) cria o quinto Bounded Context do TradingOS: `Learning Domain`. Decisão: Core Domain permanece inalterado (`Evidence`/`Market Context`/`Opportunity`/`Decision`, `ARCH-001`); `Knowledge` não é incorporado ao Core Domain; `Learning Domain` consolida evidências da Validation (Trilha 2, `ADR-008`) e gera conhecimento reutilizável; não participa da execução operacional da Release 1.0; não depende de/não é dependido por `EXEC-001` a `EXEC-005`; `DOMAIN-006` será seu primeiro documento formal.

Um brief paralelo solicitava formalizar a mesma decisão como `RFC-008` — recusado por decisão do usuário, para evitar duas fontes normativas do mesmo assunto (Regra 19, `DOCUMENT_CONTROL`). O conteúdo adicional solicitado (Não Responsabilidades/"Não introduzir IA", relações com Platform/Validation/Core Domain, Compatibilidade com ADR-009, Critérios de Aceite) foi incorporado ao próprio `ADR-010` em vez disso.

**Correção registrada**: a v1.0.0 do `ADR-010` atribuiu incorretamente ao `ADR-009` a frase "sem posição definida em nenhum Bounded Context..." — a fonte real é `ADR-008` ("Escopo desta decisão"). Corrigido na v1.1.0.

## Propagação do ADR-010 (relatório "ALIGN-001", sem nova família documental)

Um brief solicitava um documento `ALIGN-001` para propagar o `ADR-010` aos documentos normativos — `ALIGN-*` não é família congelada por `ADR-009`, e a própria tarefa se descreve como relatório (não decisão nova), então o registro ficou aqui e em `CHANGELOG.md`, sem novo arquivo/família.

**Arquivos revisados e alterações**:

| Documento | Alteração | Justificativa |
|---|---|---|
| `ADR-008` | v1.1.0 → v1.2.0. Frase "sem posição definida..." substituída por nota referenciando `ADR-010` | A lacuna que essa frase registrava foi resolvida; o restante do ADR-008 (sequenciamento de trilhas) permanece válido e intocado |
| `ARCH-001` | v1.2.0 → v1.3.0. Adicionada `## Learning Domain` em "Bounded Contexts" | Aditivo apenas, conforme o próprio `ADR-010` já previa ("Impacto em ARCH-001") — nenhuma seção de Core Domain/Infrastructure/Strategy/Execution tocada |
| `SPEC-001` | Nenhuma alteração | O brief pedia incluir componentes do Learning Domain — contradiz o próprio `ADR-010` ("nenhum componente nesta decisão") e a Restrição do brief ("não criar novos componentes"); nenhum componente concreto existe ainda para catalogar |
| `ADR-009` | Nenhuma alteração | Verificado: `ADR-009` nunca conteve a frase-gatilho nem qualquer menção a `Knowledge`/Learning Engine; a condição do brief não se aplicou |

**Impacto na rastreabilidade**: `ADR-010` passa a ser referenciado em `related` de `ARCH-001` e `ADR-008`. Nenhuma referência cruzada quebrada foi introduzida.

**Confirmação**: nenhuma nova decisão arquitetural foi introduzida por esta propagação — `ADR-010` é a única fonte normativa para o Learning Domain; `ARCH-001` e `SPEC-001` estão consistentes com ele (o segundo, por não precisar de alteração); `ADR-009` não continha decisão pendente sobre este tema; nenhuma duplicação de conhecimento foi criada (nem a `RFC-008` recusada, nem um novo arquivo `ALIGN-001`).

## DOMAIN-006 — Knowledge Model (primeiro documento do Learning Domain)

`Docs/02-domain/DOMAIN-006-Knowledge-Model.md` define formalmente `Knowledge` dentro do Learning Domain criado por `ADR-010`. Nenhuma decisão arquitetural nova — o documento assume o Bounded Context e as fronteiras já aprovadas, seguindo a validação prévia exigida (compatibilidade confirmada com `ADR-010`, `ARCH-001`, `SPEC-001`, `ADR-009`, `DOMAIN-004`, sem conflitos).

Conteúdo: definição de `Knowledge` (conhecimento consolidado a partir de resultados observados e validados), 7 princípios obrigatórios, ciclo de vida de 4 estados (`Proposed → Validated → Published → Superseded`, nunca apagado), fontes de criação (exclusivamente `Outcome`, produzido pela Validation), e relações explícitas com `Validation` (única fonte de entrada), `Evidence` (`DOMAIN-003` — relação indireta, mediada por `Outcome`, sem dependência direta do Core Domain), `Outcome` (matéria-prima do Knowledge), `Learning` (consumidor do Knowledge, ainda não implementado) e `Platform` (nenhuma relação direta).

Preserva integralmente a regra de `ADR-010` "Relação com Core Domain: Nenhuma" — `Knowledge` nunca depende de `Evidence`/`Market Context`/`Opportunity`/`Decision` diretamente. Nenhum componente novo foi registrado em `SPEC-001`. A Release 1.0 (`ROADMAP-001` a `005`, `EXEC-001` a `EXEC-005`) permanece integralmente não afetada.

## ROADMAP-006 — Architecture Decision Backlog

`Docs/09-roadmap/ROADMAP-006-Architecture-Decision-Backlog.md` (solicitado originalmente como `ADB-001`, família não congelada por `ADR-009` — reprefixado para `ROADMAP-*`, continuando a numeração existente) formaliza o backlog oficial de decisões arquiteturais pendentes. Registra 7 itens, todos originados da análise técnica de evolução do `DOMAIN-003` (Evidence) desta sessão, classificados em 5 categorias (Correção documental / Evolução compatível / Evolução arquitetural / Novo conceito / Conceito em avaliação) e rastreados por 8 estados (`Proposed` → ... → `Archived`).

Itens atuais: `ITEM-01` (renomear Structure→Market Structure, Cat. 1, Proposed), `ITEM-02` (categorias Price Action/Custom, Cat. 2, Proposed), `ITEM-03` (categoria Risk, Cat. 3, Awaiting RFC, dependente de `RFC-001`), `ITEM-04` (categoria Execution, Cat. 3, Awaiting ADR), `ITEM-05` (ciclo de vida de Evidence, Cat. 3, Awaiting ADR), `ITEM-06` (atributos Estado/Validade, Cat. 3, dependente de ITEM-05, Awaiting ADR), `ITEM-07` (conceito Observation, Cat. 5, **Rejected** — avaliado nesta sessão: não é conceito de domínio novo, já coberto por `Data Provider`/`Indicator Provider`/`Evidence Builder`; não bloqueia mais `ITEM-05`/`ITEM-06`).

Nenhuma decisão arquitetural foi tomada por este documento; `DOMAIN-003` e todos os demais documentos permanecem inalterados. Este backlog passa a ser a referência para as próximas revisões arquiteturais do projeto.

## ADR-011 — Evidence Lifecycle (ITEM-05/ITEM-06 implementados)

`Docs/05-decisions/ADR-011-Evidence-Lifecycle.md` formaliza o ciclo de vida de `Evidence` (`DOMAIN-003`): `Candidate → Confirmed → Weak → Rejected → Expired`, com significado de cada estado (`Candidate` recém-produzida; `Confirmed`/`Weak` compõem `Market Context` com peso pleno/reduzido; `Rejected` nunca compõe; `Expired` ultrapassou a `Validade`, preservada para auditoria). Adiciona `BR-006` a `BR-008` e os atributos `Estado`/`Validade`.

`DOMAIN-003` atualizado para v2.0.0 propagando integralmente esta decisão. `ROADMAP-006`: `ITEM-05`/`ITEM-06` (que motivaram este ADR) transitam de `Awaiting ADR` para `Implemented`. `ITEM-07` (Observation), que bloqueava ambos, foi avaliado nesta sessão e **rejeitado** como conceito de domínio novo — sua responsabilidade já está coberta por `Data Provider`/`Indicator Provider`/`Evidence Builder`, sem necessidade de uma entidade formal adicional.

Nenhum impacto na Release 1.0: `Evidence` é Core Domain, fora do pipeline de Execução decidido pela `RFC-007` (Alternativa B) para a Release 1.0. `Evidence Validation Policy` (`SPEC-001`, ainda `Planned`) ganha responsabilidade implícita de decidir entre `Confirmed`/`Weak`/`Rejected`, a detalhar quando especificada — não antecipada por este ADR.

Restam em `ROADMAP-006`: `ITEM-01`/`ITEM-02` (Categoria 1/2, prontos para aplicação direta, ainda não aplicados) e `ITEM-03`/`ITEM-04` (Categoria 3, ainda bloqueados — `ITEM-03` por `RFC-001`, `ITEM-04` aguardando ADR próprio).

## AUDIT-002 — Baseline Architecture Certification

`Docs/06-validation/AUDIT-002-Baseline-Architecture-Certification.md` (solicitado originalmente como `ACR-002`, família não congelada por `ADR-009` — reprefixado para `AUDIT-*`, continuando a numeração de `AUDIT-001`) recertifica a Architecture Baseline após a consolidação de `ADR-010` (Learning Domain), `ADR-011` (Evidence Lifecycle) e `ROADMAP-006` (Architecture Decision Backlog).

**Pontos conformes**: Core Domain (`Opportunity`/`Market Context`/`Decision`) inalterado desde o freeze (`ADR-007`); `Evidence` (`DOMAIN-003`) evoluiu unicamente por processo formal (`ADR-011`), não em violação do freeze; `Learning Domain` corretamente isolado, sem dependência de Core Domain/Platform (`ADR-010`/`DOMAIN-006`); nenhum documento órfão entre os 46 arquivos governados sob `Docs/0X-*/`; nenhuma duplicação ativa (`RFC-008` corretamente descartada em favor de `ADR-010`); nenhuma regressão terminológica residual (instâncias de "Opportunity/Decision" como estágios de pipeline, encontradas em `ROADMAP-003`/`ROADMAP-005`, já corrigidas); sequência `EXEC-001` a `EXEC-005` completa e íntegra.

**Não conformidades (nenhuma bloqueante)**:
- `ROADMAP-006` não referencia `RFC-001` a `RFC-005` (todas `Open`), contrariando seu próprio objetivo de concentrar toda pendência arquitetural em um único backlog.
- Gap de componentes do Bounded Context `Strategy` em `SPEC-001` — identificado desde `AUDIT-001` (Finding #4), nunca registrado como item rastreável em `ROADMAP-006`.
- Dependência "Account Provider" (`EXEC-003`/`EXEC-005`/`RFC-006`) rastreada apenas narrativamente neste documento, sem item formal em `ROADMAP-006`.
- `RFC-005` (Trading Risk & Exit Strategy) recebeu recomendação técnica mas nunca foi formalizada como ADR nem registrada no backlog.

**Architecture Readiness Score**: 88%. **Decisão**: **GO** para início de trabalho de SPEC — nenhum achado compromete Core Domain, Learning Domain ou a sequência de entrega travada por `ADR-009`. Relatório de auditoria apenas — nenhum documento normativo alterado por esta entrega.

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
