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
