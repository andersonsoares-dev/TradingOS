# Changelog

Todas as mudanças relevantes do projeto TradingOS são documentadas aqui, conforme .project-rules/DOCUMENT_CONTROL.md (Regra 12).

O histórico anterior a 2026-07-21 está disponível integralmente via `git log` (estrutura inicial, indicadores Trend/ATR/RSI/ADX, SessionService, PivotService, MarketAssessmentService, SignalBuilderService, Dashboard V2, PivotRenderer). Este changelog passa a registrar formalmente as mudanças a partir da adoção do protocolo de governança.

## [Unreleased]

### 2026-07-21 — Governança

- Adicionado `.project-rules/DOCUMENT_CONTROL.md` — protocolo de gestão documental.
- Adicionado `CLAUDE.md` — protocolo de desenvolvimento para agentes Claude.
- Adicionado `AGENTS.md` — protocolo universal para qualquer agente de IA.
- Adicionado `Docs/00-governance/ENG-000-Engineering-Handbook.md`.
- Adicionado `Docs/00-governance/CONST-001-Constitution.md`.
- Adicionado `Docs/00-governance/VISION-001-Product-Vision.md`.
- Adicionado `DOCUMENT_INDEX.md` e `TRACEABILITY.md`.

### 2026-07-21 — Governance Stabilization

- Legacy Baseline formalizada (ADR-001).
- Evolução do domínio documentada (ADR-002).
- Escopo estratégico alinhado (ADR-003).
- Estratégia oficial de validação definida (ADR-004).
- ADR-005 aprovado.
- Vocabulário do domínio refinado.
- Signal e Confirmation passam a ser termos oficiais em seus respectivos contextos.

### 2026-07-21 — Requirements

- Adicionado `Docs/01-requirements/REQ-001-Requirements-Specification.md` — 12 requisitos funcionais (REQ-001 a REQ-012) e 8 requisitos não funcionais (NFR-001 a NFR-008).
- `TRACEABILITY.md` atualizado com mapeamento de cada requisito contra a Legacy Baseline (V1).

### 2026-07-21 — Domain

- Adicionado `Docs/02-domain/DOMAIN-001-Opportunity.md` — entidade central do domínio-alvo (Opportunity), com ciclo de vida, atributos, regras de negócio (BR-001 a BR-006) e mapeamento de evolução a partir de `MarketAssessment`/`TradingSignal` (ADR-002).
- `TRACEABILITY.md` atualizado com referência a DOMAIN-001.
- Adicionado `Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md` — vocabulário oficial do domínio (Opportunity, Market Context, Evidence, Decision, Confidence, Risk Profile, Strategy, Signal, Indicator, Adapter, Domain Service, Infrastructure Service) e regras de linguagem proibindo sinônimos.
- `TRACEABILITY.md` atualizado com nota sobre divergência de vocabulário entre DOMAIN-002 e a Legacy Baseline (coberta por ADR-001/ADR-002).

### 2026-07-21 — Repository Structure Stabilization

- Estrutura documental reorganizada.
- ADRs movidos para `docs/05-decisions`.
- Numeração de diretórios padronizada.
- Estrutura oficial consolidada.
- Adicionada regra em `AGENTS.md`: documentos devem ser referenciados por `id` (nunca por caminho físico), desacoplando identidade lógica de localização — reduz o custo de futuras reorganizações de diretório.

### 2026-07-21 — Domain (Evidence)

- Adicionado `Docs/02-domain/DOMAIN-003-Evidence.md` — conceito de Evidence (observação imutável do mercado), estrutura (Category/Source/Value/Confidence/Weight/Timestamp/Metadata), classificação (Primary/Derived/Composite) e regras de negócio (BR-001 a BR-005).
- `TRACEABILITY.md` atualizado com referência a DOMAIN-003 e seu mapeamento contra a Legacy Baseline.

### 2026-07-21 — Domain (Market Context)

- Adicionado `Docs/02-domain/DOMAIN-004-Market-Context.md` — Aggregate Root que consolida Evidence em um instante (Asset/Timeframe/Timestamp/Evidence Collection/Summary/Confidence), imutável após construção (BR-005), regras de negócio (BR-001 a BR-005).
- `TRACEABILITY.md` atualizado com referência a DOMAIN-004 e nota sobre a coincidência de nome com o `struct MarketContext` da Legacy Baseline.

### 2026-07-21 — Domain (Decision)

- Adicionado `Docs/02-domain/DOMAIN-005-Decision.md` — objeto de domínio imutável que formaliza a conclusão do Core Domain (DecisionId/OpportunityId/ContextId/Decision Type/Confidence/Rationale/Timestamp), regras de negócio (BR-001 a BR-006).
- Suíte de domínio-alvo completa: `DOMAIN-001` (Opportunity) a `DOMAIN-005` (Decision).
- `TRACEABILITY.md` atualizado com referência a DOMAIN-005 e seu mapeamento contra a Legacy Baseline (`TradingSignal`/`SignalBuilderService`).

### 2026-07-21 — Architecture

- Adicionado `Docs/03-architecture/ARCH-001-Architecture-Blueprint.md` — arquitetura oficial (Core Domain, Infrastructure, Strategy, Execution), dependências permitidas/proibidas, Bounded Contexts, fluxo oficial (Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order).
- `TRACEABILITY.md` atualizado com referência a ARCH-001 e seu mapeamento contra a Legacy Baseline.

### 2026-07-21 — Specifications

- Adicionado `Docs/04-specifications/SPEC-001-Component-Model.md` — modelo de componentes oficiais (Core Domain, Strategy, Infrastructure, Execution), contratos, dependências permitidas e lista de componentes Legacy que permanecem válidos.
- `TRACEABILITY.md` atualizado com referência a SPEC-001.
- `Docs/04-specifications/SPEC-001-Component-Model.md` atualizado para v1.1.0 — adicionada seção "Component Lifecycle", classificando cada componente como Implemented/Planned/Deprecated/Future frente à Legacy Baseline.
- Adicionado `Docs/04-specifications/SPEC-002-Interface-Contracts.md` — contratos públicos entre componentes (Data Provider → Indicator Provider → Evidence Factory → Market Context Builder → Opportunity Evaluator → Decision Engine → Signal Builder → Order Manager), pré/pós-condições, tratamento de erros.
- `TRACEABILITY.md` atualizado com referência a SPEC-002 e nota sobre nomes de componente não reconciliados com SPEC-001.
- Adicionado `Docs/04-specifications/SPEC-003-Domain-Services.md` — Domain Services oficiais (Opportunity Service, Decision Service, Confidence Service, Risk Evaluation Service, Evidence Evaluation Service, Context Validation Service), dependências permitidas/proibidas, mapeamento aproximado contra a Legacy Baseline.
- `TRACEABILITY.md` atualizado com nota sobre nomenclaturas divergentes entre SPEC-001, SPEC-002 e SPEC-003 para papéis equivalentes.

### 2026-07-21 — Architecture Stabilization

- Taxonomia arquitetural consolidada.
- SPEC-001 passa a ser a única fonte oficial de nomenclatura.
- Builders, Services, Policies e Providers padronizados.

### 2026-07-21 — Documentation Governance Stabilization

- Criação do processo oficial de validação documental.

### 2026-07-21 — Specifications (Application Services)

- Adicionado `Docs/04-specifications/SPEC-004-Application-Services.md` — 5 Use Cases (Analyze Market, Validate Context, Evaluate Opportunity, Generate Decision, Publish Signal) que orquestram Builders/Domain Services/Policies, sem implementar regras de negócio.
- `Docs/04-specifications/SPEC-001-Component-Model.md` atualizado para v1.4.0 — "Application Services" adicionada como 6ª categoria do Canonical Component Catalog, com os 5 Use Cases registrados na tabela "Component Lifecycle" (todos Planned — hoje `TradingOS.mq5` orquestra parte desse fluxo de forma implícita).
- `TRACEABILITY.md` atualizado com referência a SPEC-004.

### 2026-07-21 — Domain Lifecycle (Ciclo de Vida por Entidade)

- `Docs/02-domain/DOMAIN-004-Market-Context.md` atualizado para v1.1.0 — adicionada seção "Ciclo de Vida" (Building → Validated → Frozen → Obsolete).
- `Docs/02-domain/DOMAIN-005-Decision.md` atualizado para v1.1.0 — adicionada seção "Ciclo de Vida" (Draft → Generated → Published → Consumed → Archived).
- Adicionado `Docs/04-specifications/SPEC-005-Domain-Lifecycle.md` — documento de orquestração de transições de estado, mapeando cada transição contra Application Service/Domain Service/Policy do Canonical Component Catalog (SPEC-001).
- Identificada e sinalizada divergência entre o ciclo de vida da Opportunity já definido em DOMAIN-001 (Draft → Qualified → Approved → Executed → Closed → Archived) e o ciclo de vida redefinido em SPEC-005 v1.0 (Draft → Identified → Evaluated → Accepted → Rejected → Expired). Resolução tratada na seção "Architecture Stabilization" abaixo (ADR-006).

### 2026-07-21 — Architecture Stabilization (Opportunity Lifecycle Alignment)

- Adicionado `Docs/05-decisions/ADR-006-Opportunity-Lifecycle-Alignment.md` — decisão de remover os estados `Executed`, `Closed` e `Archived` do ciclo de vida da Opportunity, por representarem responsabilidade do contexto de Execution e não do Core Domain.
- `Docs/02-domain/DOMAIN-001-Opportunity.md` atualizado para v1.1.0 — ciclo de vida simplificado para Draft → Qualified → Approved → Completed. `Completed` representa que a Opportunity produziu uma Decision válida; não representa execução, ordem ou posição.
- `Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md` atualizado para v1.3.0 — adicionado o termo `Completed` ao vocabulário oficial.
- `Docs/03-architecture/ARCH-001-Architecture-Blueprint.md` atualizado para v1.2.0 — adicionada observação de que Execution é um Bounded Context independente; Opportunity nunca atravessa o limite entre Core Domain e Execution; a entidade compartilhada entre os contextos é a Decision publicada, materializada como Signal pelo contexto de Execution.
- `Docs/04-specifications/SPEC-005-Domain-Lifecycle.md` reescrito como documento exclusivamente de orquestração — não define mais estados; tabela do ciclo de vida da Opportunity atualizada para refletir Draft → Qualified → Approved → Completed.
- Separação definitiva entre Core Domain e Execution no ciclo de vida da Opportunity.
- `TRACEABILITY.md` e `DOCUMENT_INDEX.md` atualizados com ADR-006 e as novas versões de DOMAIN-001, DOMAIN-002, DOMAIN-004, DOMAIN-005, ARCH-001 e SPEC-005.

### 2026-07-21 — Specifications (Business Rules)

- Adicionado `Docs/04-specifications/SPEC-006-Business-Rules.md` — consolidação de todas as regras de negócio do domínio (BR-1xx Validação, BR-2xx Contexto, BR-3xx Opportunity, BR-4xx Decision, BR-5xx Execution Boundary), sem definir componentes, arquitetura ou algoritmos.
- `TRACEABILITY.md` atualizado com referência a SPEC-006 e nota sobre a numeração BR global (SPEC-006) coexistir, sem correspondência formal ainda mapeada, com as numerações BR locais já existentes em DOMAIN-001 e DOMAIN-005.
- `DOCUMENT_INDEX.md` atualizado — `SPEC-007` (referenciado em `related`) ainda não existe.

### 2026-07-21 — Architecture Baseline Audit (AUDIT-001)

- Adicionado `Docs/06-validation/AUDIT-001-Architecture-Baseline.md` — auditoria arquitetural completa dos 36 documentos do repositório, exclusivamente por leitura direta (nenhum conhecimento externo). 14 inconsistências identificadas (2 Críticas, 3 Altas, 5 Médias, 4 Baixas). Recomendação inicial: Aprovar com ressalvas.
- Nenhum documento existente foi alterado durante a auditoria; nenhum ADR criado; nenhuma inconsistência corrigida nesta etapa — apenas diagnóstico.

### 2026-07-21 — RC-001 (Release Candidate — fechamento de achados Críticos e Altos)

- **Finding #1 (Crítico) resolvido**: `CLAUDE.md`, `AGENTS.md` e `.project-rules/DOCUMENT_CONTROL.md` (v1.1.0) passam a compartilhar exatamente a mesma ordem de precedência documental: DOCUMENT_CONTROL → CONSTITUTION → ADR → DOMAIN → ARCH → SPEC → ENGINEERING → REFERENCE → VALIDATION → ROADMAP.
- **Finding #2 (Crítico) resolvido**: `.project-rules/DOCUMENT_CONTROL.md` (Regras 13/14/15) atualizado para referenciar apenas diretórios reais (`knowledge/papers/`, `knowledge/articles/`, `05-decisions/`, `10-rfc/`); árvore oficial do repositório adicionada a `DOCUMENT_CONTROL.md`; seção "Estrutura oficial" de `CLAUDE.md` (obsoleta desde a Repository Structure Stabilization) corrigida para refletir a mesma árvore já vigente em `AGENTS.md`/`DOCUMENT_INDEX.md`.
- **Finding #5 (Alto) resolvido**: seções "Testes" de `CLAUDE.md` e `AGENTS.md` atualizadas para referenciar explicitamente o pipeline de validação do ADR-004, eliminando a exigência literal de "Testes Unitários"/"Testes de Integração" obrigatórios. ADR-004 não foi alterado.
- **Finding #3 (Alto) tratado via triagem formal**: `AUDIT-001` atualizado com status "Architectural Gap" para Risk Profile. Adicionado `Docs/10-rfc/RFC-001-Risk-Profile-Classification.md`, classificado "Requires Architectural Decision" — nenhum DOMAIN ou SPEC novo foi criado.
- **Finding #4 (Alto) tratado via decisão documentada**: Strategy Bounded Context confirmado como ativo (Opção A — "permanece, necessita futura especificação"), com base em REQ-011, ADR-003, ARCH-001 e DOMAIN-002. Nenhum componente novo foi criado; `ARCH-001` não foi alterado (a Opção A não exige alteração).
- Adicionado `Docs/06-validation/AUDIT-001-CLOSURE.md` — relatório de fechamento com nova matriz de severidade e nova estimativa de maturidade.
- Achados Médios e Baixos do AUDIT-001 permanecem inalterados — fora do escopo do RC-001.

### 2026-07-21 — Architecture Baseline v1.0 Freeze (ADR-007)

- Adicionada observação em `.project-rules/DOCUMENT_CONTROL.md` (v1.2.0): documentos de Governança, Domínio, Arquitetura e Especificações pertencentes à Baseline v1.0 encontram-se congelados; alterações somente via ADR, RFC aprovada, ou correção documental sem impacto arquitetural.
- Adicionado `Docs/05-decisions/ADR-007-Architecture-Baseline-v1.0-Freeze.md` — formaliza o congelamento, delimita o escopo exato (Governança: ENG-000/CONST-001/VISION-001/DOCUMENT_CONTROL/CLAUDE.md/AGENTS.md; Domínio: DOMAIN-001 a 005; Arquitetura: ARCH-001; Especificações: SPEC-001 a 006) e esclarece que Requirements (REQ-001) não está incluído no congelamento.
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com ADR-007.

### 2026-07-21 — Fase 2: Platform Foundation — INFRA-001 (Infrastructure Overview)

- Adicionado `Docs/03-architecture/INFRA-001-Infrastructure-Overview.md` — primeira entrega da Fase 2, inaugurando a documentação da camada Infrastructure (responsabilidades, limites, dependências permitidas/proibidas, visão geral de componentes, matriz de dependências, princípios obrigatórios, diagrama Mermaid). Nenhum documento da Baseline v1.0 (DOMAIN/ARCH/SPEC/ADR) foi alterado, conforme ADR-007.
- Dois itens do brief de origem (`Event Dispatcher`, `Scheduler`) não constam no Canonical Component Catalog (`SPEC-001`) — não foram incorporados como componentes aprovados. Adicionado `Docs/10-rfc/RFC-002-Infrastructure-Candidate-Components.md`, classificado "Requires Architectural Decision".
- `Broker Adapter`/`MT5 Adapter` (catalogados em SPEC-001 como Execution Components, não Infrastructure Providers) e `Logger` (citado no brief como "Logger Provider", nome não-canônico) foram referenciados em INFRA-001 usando os nomes e categorias já estabelecidos em SPEC-001, com observação explícita da divergência de nomenclatura do brief.
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com INFRA-001 e RFC-002.

### 2026-07-21 — INFRA-001 v1.1.0 (Princípio de Evolução)

- `Docs/03-architecture/INFRA-001-Infrastructure-Overview.md` atualizado para v1.1.0 — adicionada a seção "Princípio de Evolução": a camada Infrastructure deve permitir futura integração com Learning Engine, Knowledge Repository, Performance Analyzer e Recommendation Engine, sem dependências diretas, via Ports & Adapters e Dependency Inversion. Nenhum desses componentes foi criado nesta entrega.
- Nenhum dos quatro nomes consta no Canonical Component Catalog (SPEC-001); diferente de `Event Dispatcher`/`Scheduler` (RFC-002), eles não foram incluídos na tabela de Componentes nem tratados como RFC nesta entrega — são citados apenas como alvos de integração futura, garantindo que a arquitetura de Ports & Adapters permaneça compatível.
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com a nova versão de INFRA-001.

### 2026-07-21 — Fase 2: Platform Foundation — INFRA-002 (Data Provider)

- Adicionado `Docs/03-architecture/INFRA-002-Data-Provider.md` — segunda entrega da Fase 2, detalhando o Port `Data Provider` (já catalogado em SPEC-001, já contratado em SPEC-002): responsabilidades, não-responsabilidades, tabela de Portas (GetBars/GetCurrentTick/GetSpread/GetSymbol/GetTime/GetSession/GetMarketStatus), dependências permitidas/proibidas, extensibilidade, qualidade, diagrama Mermaid, casos de uso, Definition of Ready/Done. Nenhum documento da Baseline v1.0 foi alterado.
- Porta `GetMarketState()` (brief de origem) renomeada para `GetMarketStatus()` — "Market State" é termo explicitamente banido por DOMAIN-002 em favor de "Market Context"; correção de vocabulário sem impacto arquitetural, não uma decisão de RFC.
- Seis nomes citados no brief (`Replay Adapter`, `CSV Provider`/`CSV Adapter`, `Mock Provider`, `REST Adapter`, `FIX Adapter`, `WebSocket Adapter`) não constam no Canonical Component Catalog (SPEC-001) — não incorporados como componentes/dependências aprovados. Adicionado `Docs/10-rfc/RFC-003-Data-Provider-Candidate-Adapters.md`, classificado "Requires Architectural Decision".
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com INFRA-002 e RFC-003.

### 2026-07-21 — Fase 2: Platform Foundation — INFRA-003 (Indicator Provider)

- Adicionado `Docs/03-architecture/INFRA-003-Indicator-Provider.md` — terceira entrega da Fase 2, detalhando o Port `Indicator Provider` (já catalogado em SPEC-001, já contratado em SPEC-002): responsabilidades (ATR/RSI/ADX/EMA/SMA/MACD/Bollinger/VWAP), não-responsabilidades, fonte de dados restrita ao Data Provider, modelo uniforme de resultado, portas (GetATR/GetRSI/GetADX/GetEMA/GetSMA/GetMACD/Health/Capabilities), dependências, requisitos não funcionais, padronização (NaN/lookback/arredondamento), extensibilidade, diagrama Mermaid, casos de uso, observabilidade, Definition of Ready/Done, critérios de teste. Nenhum documento da Baseline v1.0 foi alterado. Nenhum componente candidato novo foi necessário nesta entrega (diferente de INFRA-001/002).
- Validação Prévia identificou uma divergência preexistente entre SPEC-001 e SPEC-003: SPEC-001 mapeia `TrendService`/`ATRService`/`RSIService`/`ADXService` (Legacy Baseline) para `Indicator Provider`; SPEC-003 mapeia os mesmos quatro serviços para `Evidence Builder`. Ambos são documentos da Baseline congelada e não foram alterados. Adicionado `Docs/10-rfc/RFC-004-Legacy-Indicator-Mapping-Ambiguity.md`, classificado "Requires Architectural Decision".
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com INFRA-003 e RFC-004.

### 2026-07-21 — ADR-008: Roadmap Restructuring (Trilhas Paralelas)

- Adicionado `Docs/05-decisions/ADR-008-Roadmap-Restructuring-Parallel-Tracks.md` — reestrutura o roadmap em três trilhas: Platform (continua sem pausa: Infrastructure/Execution/MT5), Validation (inicia agora, em paralelo: estratégia base, backtests, walk-forward, forward test, edge reports — `Docs/06-validation/`), Learning (inicia somente após existir histórico real de operações: Learning Engine, Knowledge Repository, Recommendation Engine). Decisão de sequenciamento de roadmap, não de arquitetura — `ARCH-001` não foi alterado.
- Adicionado `Docs/06-validation/VALIDATION-001-Trading-Strategy-Baseline.md` — primeiro documento da Trilha 2, definindo a estratégia a validar (a própria Legacy Baseline V1: MarketService → MarketAssessmentService → SignalBuilderService), critérios de entrada já existentes (referência ao código, sem nova regra), parâmetros de validação propostos (ativos, período, timeframe, expectativa mínima, drawdown máximo como critério de aceite), e mapeamento direto ao pipeline já definido em ADR-004 (Strategy Tester/Historical Simulation → BACKTEST-001, Walk Forward → WALKFORWARD-001, Demo Validation → FORWARDTEST-001).
- Gestão de risco e critérios de saída (stop loss, take profit, position sizing) explicitamente fora do escopo de VALIDATION-001 — associados a Risk Service (SPEC-001, Planned) e REQ-009 (não atendido), a serem tratados por RFC/ADR próprios.
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com ADR-008 e VALIDATION-001.

### 2026-07-21 — ADR-008 v1.1.0 (Release 1.0 Definition of Done + Milestone Scoping)

- Um brief de origem solicitava criar `Docs/05-decisions/ADR-007-Parallel-Development-Strategy.md` — identificado conflito: `ADR-007` já existe (`Architecture Baseline v1.0 Freeze`) e o conteúdo central (3 trilhas) já estava registrado em `ADR-008`. Confirmado com o usuário: conteúdo novo incorporado ao `ADR-008` (v1.1.0) em vez de criar um ADR duplicado, evitando colisão de id e violação da Regra 19 do `DOCUMENT_CONTROL` (nunca duplicar conhecimento).
- `ADR-008` atualizado com: descrição expandida das 3 trilhas (Trilha 1 agora cita explicitamente Persistence/Logging/Configuration; Trilha 3 cita Knowledge/Optimization/Machine Learning); nova seção "Release 1.0 — Definition of Done" (operar automaticamente, executar ordens, controlar risco, logs, Backtest, Forward Test, métricas de desempenho); nova seção "Nova Regra de Governança — Milestone Scoping" (toda funcionalidade nova deve responder se é necessária para o Milestone atual; se não, vai para o backlog sem alterar o escopo da Release); nova seção "Impactos" (benefícios, riscos mitigados, trade-offs).
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com a nova versão de ADR-008.

### 2026-07-21 — RFC-005: Trading Risk & Exit Strategy

- Um brief de origem solicitava criar `Docs/10-rfc/RFC-004-Trading-Risk-Exit-Strategy.md` — identificado conflito puro de numeração: `RFC-004` já existe (`Legacy Indicator Mapping Ambiguity`, sem sobreposição de conteúdo). Renumerado para `RFC-005` e sinalizado ao usuário.
- Adicionado `Docs/10-rfc/RFC-005-Trading-Risk-Exit-Strategy.md` — análise (sem decisão) de alternativas de saída (Stop Fixo, Stop ATR, Stop por Estrutura, Stop Temporal, Trailing Stop, Break-even) e de Position Sizing (Lote Fixo, % de Capital, % por Risco, Volatilidade/ATR), cada uma com vantagens/desvantagens/complexidade/impacto em Backtest/impacto arquitetural. Recomendação para a Release 1.0 (MVP): Stop baseado em ATR + Stop Temporal como saída, Percentual por Risco como position sizing — explicitamente marcada como recomendação pendente de aprovação via ADR próprio, não uma decisão.
- Nenhum documento `DOMAIN`/`ARCH`/`SPEC`/`ADR` foi alterado.
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com RFC-005.

### 2026-07-21 — VALIDATION-001 v2.0.0 (Trading Strategy Validation Baseline)

- Um brief de origem solicitava criar `Docs/06-validation/VALIDATION-001-Trading-Strategy-Validation-Baseline.md` — identificado que `VALIDATION-001` já existia (v1.0.0, `Trading Strategy Baseline`) e que o novo conteúdo era uma expansão substancial do mesmo documento, não um tema separado. Tratado como reescrita: arquivo renomeado via `git mv` (histórico preservado), versão incrementada para 2.0.0.
- Adicionado: Hipótese Principal (H1/H0) e Hipóteses Secundárias (robustez entre ativos/timeframes/períodos/regimes, sensibilidade a parâmetros); Escopo explícito (Backtest/Walk Forward/Forward Test; exclui ML/Auto Optimization/Multi Strategy/Multi Broker); Universo de Teste consolidado (ativos/timeframes/sessões/período/quantidade mínima de operações/fonte de dados/versão do histórico); Protocolo de Teste de 7 etapas fixas; Hipótese de Risco (referencia RFC-005 explicitamente como hipótese, não decisão); Métricas Obrigatórias (10 métricas); Critérios de Aprovação/Reprovação; Reprodutibilidade; Evidências Obrigatórias; Modelo de Relatório (8 seções); Dependências (com gap real registrado: Risk Service/Order Manager/Position Manager/MT5 Adapter ainda não implementados); Limitações; Definition of Done.
- Termo "Execution Engine" do brief de origem não incorporado por não constar no Canonical Component Catalog (SPEC-001) — referenciados os componentes já catalogados (Order Manager, Position Manager).
- `DOCUMENT_INDEX.md` e `TRACEABILITY.md` atualizados com o novo caminho e versão de VALIDATION-001.
