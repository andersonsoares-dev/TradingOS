# Document Index

Índice oficial de todos os documentos versionados do TradingOS, conforme .project-rules/DOCUMENT_CONTROL.md (Regra 12).

| ID | Título | Caminho | Versão | Status |
|---|---|---|---|---|
| — | Document Control Protocol | .project-rules/DOCUMENT_CONTROL.md | 1.2.0 | Approved |
| — | Claude AI Development Protocol | CLAUDE.md | — | Approved |
| — | Universal AI Protocol | AGENTS.md | — | Approved |
| ENG-000 | Engineering Handbook | Docs/00-governance/ENG-000-Engineering-Handbook.md | 1.0.0 | Approved |
| CONST-001 | TradingOS Constitution | Docs/00-governance/CONST-001-Constitution.md | 1.0.0 | Approved |
| VISION-001 | Product Vision | Docs/00-governance/VISION-001-Product-Vision.md | 1.0.0 | Approved |
| REQ-001 | Requirements Specification | Docs/01-requirements/REQ-001-Requirements-Specification.md | 1.0.0 | Approved |
| DOMAIN-001 | Opportunity | Docs/02-domain/DOMAIN-001-Opportunity.md | 1.1.0 | Approved |
| DOMAIN-002 | Ubiquitous Language | Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md | 1.3.0 | Approved |
| DOMAIN-003 | Evidence | Docs/02-domain/DOMAIN-003-Evidence.md | 1.0.0 | Approved |
| DOMAIN-004 | Market Context | Docs/02-domain/DOMAIN-004-Market-Context.md | 1.1.0 | Approved |
| DOMAIN-005 | Decision | Docs/02-domain/DOMAIN-005-Decision.md | 1.1.0 | Approved |
| ARCH-001 | Architecture Blueprint | Docs/03-architecture/ARCH-001-Architecture-Blueprint.md | 1.2.0 | Approved |
| INFRA-001 | Infrastructure Overview | Docs/03-architecture/INFRA-001-Infrastructure-Overview.md | 1.1.0 | Approved |
| INFRA-002 | Data Provider | Docs/03-architecture/INFRA-002-Data-Provider.md | 1.0.0 | Approved |
| INFRA-003 | Indicator Provider | Docs/03-architecture/INFRA-003-Indicator-Provider.md | 1.0.0 | Approved |
| SPEC-001 | Component Model | Docs/04-specifications/SPEC-001-Component-Model.md | 1.4.0 | Approved |
| SPEC-002 | Interface Contracts | Docs/04-specifications/SPEC-002-Interface-Contracts.md | 1.1.0 | Approved |
| SPEC-003 | Domain Services | Docs/04-specifications/SPEC-003-Domain-Services.md | 1.1.0 | Approved |
| SPEC-004 | Application Services | Docs/04-specifications/SPEC-004-Application-Services.md | 1.0.0 | Approved |
| SPEC-005 | Domain Lifecycle | Docs/04-specifications/SPEC-005-Domain-Lifecycle.md | 1.0.0 | Approved |
| SPEC-006 | Business Rules | Docs/04-specifications/SPEC-006-Business-Rules.md | 1.0.0 | Approved |
| ADR-001 | Legacy Baseline | Docs/05-decisions/ADR-001-Legacy-Baseline.md | 1.0.0 | Accepted |
| ADR-002 | Domain Evolution | Docs/05-decisions/ADR-002-Domain-Evolution.md | 1.0.0 | Accepted |
| ADR-003 | Product Scope | Docs/05-decisions/ADR-003-Product-Scope.md | 1.0.0 | Accepted |
| ADR-004 | Validation Strategy | Docs/05-decisions/ADR-004-Validation-Strategy.md | 1.0.0 | Accepted |
| ADR-005 | Ubiquitous Language Refinement | Docs/05-decisions/ADR-005-Ubiquitous-Language-Refinement.md | 1.0.0 | Accepted |
| ADR-006 | Opportunity Lifecycle Alignment | Docs/05-decisions/ADR-006-Opportunity-Lifecycle-Alignment.md | 1.0.0 | Accepted |
| ADR-007 | Architecture Baseline v1.0 Freeze | Docs/05-decisions/ADR-007-Architecture-Baseline-v1.0-Freeze.md | 1.0.0 | Accepted |
| ADR-008 | Roadmap Restructuring — Parallel Tracks | Docs/05-decisions/ADR-008-Roadmap-Restructuring-Parallel-Tracks.md | 1.1.0 | Accepted |
| AUDIT-001 | Architecture Baseline Audit | Docs/06-validation/AUDIT-001-Architecture-Baseline.md | 1.0.0 | Approved |
| AUDIT-001-CLOSURE | Architecture Baseline Audit — Closure Report (RC-001) | Docs/06-validation/AUDIT-001-CLOSURE.md | 1.0.0 | Approved |
| VALIDATION-001 | Trading Strategy Validation Baseline | Docs/06-validation/VALIDATION-001-Trading-Strategy-Validation-Baseline.md | 2.0.0 | Approved |
| BACKTEST-001 | Backtest Execution Protocol | Docs/06-validation/BACKTEST-001-Backtest-Execution-Protocol.md | 1.0.0 | Approved |
| RFC-001 | Risk Profile Classification | Docs/10-rfc/RFC-001-Risk-Profile-Classification.md | 1.0.0 | Open |
| RFC-002 | Infrastructure Candidate Components | Docs/10-rfc/RFC-002-Infrastructure-Candidate-Components.md | 1.0.0 | Open |
| RFC-003 | Data Provider Candidate Adapters | Docs/10-rfc/RFC-003-Data-Provider-Candidate-Adapters.md | 1.0.0 | Open |
| RFC-004 | Legacy Indicator Mapping Ambiguity | Docs/10-rfc/RFC-004-Legacy-Indicator-Mapping-Ambiguity.md | 1.0.0 | Open |
| RFC-005 | Trading Risk & Exit Strategy | Docs/10-rfc/RFC-005-Trading-Risk-Exit-Strategy.md | 1.0.0 | Open |
| — | Architecture (V1 congelada) | Docs/ARCHITECTURE.md | — | Approved |
| — | Backlog e Ordem de Sprints | Docs/BACKLOG.md | — | Living document |
| — | Technical Debt | Docs/TECH_DEBT.md | — | Living document |
| — | Changelog | CHANGELOG.md | — | Living document |
| — | Traceability Matrix | TRACEABILITY.md | — | Living document |
| — | README | README.md | — | Living document |

## Document Structure

Estrutura oficial e definitiva (ver AGENTS.md), sem colisões de numeração:

```
docs/
├── 00-governance/       Governança e princípios fundamentais
├── 01-requirements/      Requisitos oficiais
├── 02-domain/            Modelo de domínio
├── 03-architecture/      Arquitetura
├── 04-specifications/    Especificações técnicas
├── 05-decisions/         Architecture Decision Records (ADR)
├── 06-validation/        Validação
├── 07-testing/           Testes
├── 08-reference/         Referências técnicas
├── 09-roadmap/           Roadmap
└── 10-rfc/               Propostas em discussão

knowledge/
├── meeting-notes/
├── brainstorm/
├── experiments/
├── benchmarks/
├── lessons-learned/
├── papers/
└── articles/
```

## Pendências conhecidas

- Suíte de domínio (DOMAIN-001 a DOMAIN-005), arquitetura (ARCH-001) e seis especificações técnicas (SPEC-001 a SPEC-006) completas.
- `SPEC-007` (referenciado como `related` em SPEC-006) ainda não existe.
- Ciclo de vida da Opportunity realinhado com os Bounded Contexts via ADR-006: Execution deixou de fazer parte do ciclo de vida da Opportunity (ver Docs/CHANGELOG.md — Architecture Stabilization / ADR-006).
- Auditoria arquitetural completa realizada em `AUDIT-001` (Docs/06-validation), fechada por `RC-001` (ver `AUDIT-001-CLOSURE.md`): os 2 achados Críticos e os 3 Altos foram tratados; Risk Profile permanece como Architectural Gap rastreado em `RFC-001` (decisão pendente); Strategy Bounded Context confirmado como ativo (decisão A), categoria correspondente em SPEC-001 permanece como trabalho futuro.
- Architecture Baseline v1.0 congelada por `ADR-007`. Fase 2 (Platform Foundation) iniciada com `INFRA-001-Infrastructure-Overview.md`. `Event Dispatcher` e `Scheduler` (citados no brief da Entrega 01) não constam no Canonical Component Catalog (SPEC-001) — registrados em `RFC-002`, pendentes de decisão arquitetural.
- `INFRA-002-Data-Provider.md` (Entrega 02) detalha o Port Data Provider. `Replay Adapter`, `CSV Provider`/`CSV Adapter`, `Mock Provider`, `REST Adapter`, `FIX Adapter` e `WebSocket Adapter` não constam no Canonical Component Catalog (SPEC-001) — registrados em `RFC-003`, pendentes de decisão arquitetural.
- `INFRA-003-Indicator-Provider.md` (Entrega 03) detalha o Port Indicator Provider — nenhum componente candidato novo desta vez. Identificada divergência preexistente entre SPEC-001 (mapeia TrendService/ATRService/RSIService/ADXService para Indicator Provider) e SPEC-003 (mapeia os mesmos para Evidence Builder) — registrada em `RFC-004`, pendente de decisão arquitetural.
- Roadmap reestruturado em três trilhas paralelas por `ADR-008` (Platform / Validation / Learning). `VALIDATION-001` inaugura a Trilha 2 em `06-validation/`, com escopo limitado a estratégia de validação e critérios de aceitação — gestão de risco e critérios de saída ficam fora de escopo, pendentes de RFC/ADR próprios.
- `RFC-005-Trading-Risk-Exit-Strategy.md` analisa (sem decidir) alternativas de stop/saída e position sizing para viabilizar o primeiro Backtest — solicitado originalmente como `RFC-004`, renumerado por colisão de id com o `RFC-004` já existente (Legacy Indicator Mapping Ambiguity).
- `VALIDATION-001` reescrito/expandido para v2.0.0 e renomeado para `Trading-Strategy-Validation-Baseline.md` (histórico preservado via `git mv`) — protocolo completo com hipóteses H1/H0, universo de teste, protocolo de 7 etapas, métricas obrigatórias, critérios de aprovação/reprovação, reprodutibilidade, evidências obrigatórias e modelo de relatório. Usa a recomendação da `RFC-005` como hipótese de teste, não decisão.
- `BACKTEST-001-Backtest-Execution-Protocol.md` define o procedimento operacional de execução de Backtests (10 etapas), alinhado a `VALIDATION-001` — não registra resultados nem aprova estratégias.
- Nomenclatura arquitetural estabilizada (ver AGENTS.md — Canonical Naming, e Docs/CHANGELOG.md — Architecture Stabilization): SPEC-001 é a única fonte oficial; SPEC-002/SPEC-003 foram atualizados para reutilizar os mesmos nomes.
- `Docs/03-architecture/`, `04-specifications/`, `06-validation/`, `07-testing/`, `08-reference/`, `09-roadmap/`, `10-rfc/` e todas as subpastas de `knowledge/` existem mas estão vazias (git não rastreia diretórios vazios).
- `Docs/CHANGELOG.md`, `Docs/ROADMAP.md`, `Docs/VERSION.md` existem mas continuam vazios — duplicidade com `CHANGELOG.md` (raiz), já registrada em `Docs/TECH_DEBT.md`.
