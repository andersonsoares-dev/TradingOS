# TradingOS — Repository Inventory

Snapshot consolidado do repositório: estrutura completa, todos os documentos versionados, relações de dependência e estado atual do projeto. Gerado por leitura direta do repositório (frontmatter de cada documento em `Docs/`), sem alteração de nenhum arquivo existente.

Este documento é um **snapshot pontual** — a fonte viva e continuamente atualizada de cada seção permanece nos documentos de origem: `DOCUMENT_INDEX.md` (índice), `TRACEABILITY.md` (rastreabilidade narrativa), `CHANGELOG.md` (histórico cronológico), `Docs/09-roadmap/ROADMAP-006-Architecture-Decision-Backlog.md` (pendências).

**Gerado em**: 2026-07-22
**Baseline vigente**: v2.0 (`ADR-012`), tag git `architecture-baseline-v2`

---

## 1. Estrutura do Repositório

```
TradingOS/
├── .project-rules/
│   └── DOCUMENT_CONTROL.md          Protocolo de gestão documental (v1.2.0)
├── CLAUDE.md                        Protocolo de desenvolvimento (agentes Claude)
├── AGENTS.md                        Protocolo universal (qualquer agente de IA)
├── DOCUMENT_INDEX.md                Índice oficial de documentos (fonte de verdade de ids)
├── TRACEABILITY.md                  Matriz de rastreabilidade narrativa
├── CHANGELOG.md                     Histórico cronológico de mudanças
├── INVENTORY.md                     Este documento
├── README.md
│
├── Docs/
│   ├── 00-governance/               Governança e princípios (ENG-000, CONST-001, VISION-001)
│   ├── 01-requirements/             Requisitos oficiais (REQ-001)
│   ├── 02-domain/                   Modelo de domínio (DOMAIN-001 a 006)
│   ├── 03-architecture/             Arquitetura (ARCH-001, INFRA-*, EXEC-*, LEARN-*)
│   ├── 04-specifications/           Especificações técnicas (SPEC-001 a 006)
│   ├── 05-decisions/                Architecture Decision Records (ADR-001 a 014)
│   ├── 06-validation/               Validação (AUDIT-*, VALIDATION-*, BACKTEST-*, DATA-*)
│   ├── 07-testing/                  (vazio — sem documentos ainda)
│   ├── 08-reference/                (vazio — sem documentos ainda)
│   ├── 09-roadmap/                  Roadmap (ROADMAP-001 a 006)
│   ├── 10-rfc/                      Propostas em discussão (RFC-001 a 007)
│   ├── CHANGELOG.md / ROADMAP.md / VERSION.md   (duplicatas vazias — ver Docs/TECH_DEBT.md #7)
│   ├── ARCHITECTURE.md              Arquitetura V1 congelada (Legacy Baseline)
│   ├── BACKLOG.md                   Backlog e ordem de sprints (Legacy)
│   └── TECH_DEBT.md                 Dívida técnica (código V1/Legacy Baseline)
│
├── MQL5/                            Código-fonte MetaTrader 5 (Legacy Baseline, V1)
│   ├── Experts/TradingOS/           2 arquivos (EA principal)
│   ├── Include/TradingOS/           20 arquivos — Analysis/ Core/ Indicators/ Interfaces/
│   │                                Models/ Services/ UI/ Utils/
│   ├── Indicators/, Scripts/, Services/, Libraries/   (vazios)
│   ├── Profiles/, logs/             Artefatos do MetaTrader (gerados, ignorados pelo git)
│
├── knowledge/                       Trilha de Conhecimento (Learning Domain, ainda sem conteúdo)
│   ├── meeting-notes/ brainstorm/ experiments/ benchmarks/ lessons-learned/ papers/ articles/
│
└── Releases/                        Artefatos de release compilados
```

---

## 2. Inventário de Documentos

### 2.1 Governança

| ID | Título | Versão | Status |
|---|---|---|---|
| — | Document Control Protocol (`.project-rules/DOCUMENT_CONTROL.md`) | 1.2.0 | Approved |
| — | Claude AI Development Protocol (`CLAUDE.md`) | — | Approved |
| — | Universal AI Protocol (`AGENTS.md`) | — | Approved |
| ENG-000 | Engineering Handbook | 1.0.0 | Approved |
| CONST-001 | TradingOS Constitution | 1.0.0 | Approved |
| VISION-001 | Product Vision | 1.0.0 | Approved |

### 2.2 Requisitos

| ID | Título | Versão | Status |
|---|---|---|---|
| REQ-001 | Requirements Specification | 1.0.0 | Approved |

### 2.3 Domínio (Core Domain + Learning Domain)

| ID | Título | Versão | Status |
|---|---|---|---|
| DOMAIN-001 | Opportunity | 1.1.0 | Approved |
| DOMAIN-002 | Ubiquitous Language | 1.3.0 | Approved |
| DOMAIN-003 | Evidence | 2.1.0 | Approved |
| DOMAIN-004 | Market Context | 1.1.0 | Approved |
| DOMAIN-005 | Decision | 1.1.0 | Approved |
| DOMAIN-006 | Knowledge Model (Learning Domain) | 1.0.0 | Approved |

### 2.4 Arquitetura

| ID | Título | Versão | Status |
|---|---|---|---|
| ARCH-001 | Architecture Blueprint | 1.3.0 | Approved |
| INFRA-001 | Infrastructure Overview | 1.1.0 | Approved |
| INFRA-002 | Data Provider | 1.0.0 | Approved |
| INFRA-003 | Indicator Provider | 1.0.0 | Approved |
| EXEC-001 | Order Manager | 1.0.0 | Approved |
| EXEC-002 | Position Manager | 1.0.0 | Approved |
| EXEC-003 | Risk Service (Pre-Order Risk Gate) | 1.0.0 | Approved |
| EXEC-004 | Signal Builder | 1.0.0 | Approved |
| EXEC-005 | MT5 Adapter | 1.0.0 | Approved |
| LEARN-001 | Knowledge Service | 1.0.0 | Approved |
| LEARN-002 | Learning Service | 1.0.0 | Approved |

### 2.5 Especificações

| ID | Título | Versão | Status |
|---|---|---|---|
| SPEC-001 | Component Model (Canonical Component Catalog) | 1.7.0 | Approved |
| SPEC-002 | Interface Contracts | 1.1.0 | Approved |
| SPEC-003 | Domain Services | 1.1.0 | Approved |
| SPEC-004 | Application Services | 1.0.0 | Approved |
| SPEC-005 | Domain Lifecycle | 1.0.0 | Approved |
| SPEC-006 | Business Rules | 1.0.0 | Approved |

### 2.6 Decisões Arquiteturais (ADR)

| ID | Título | Versão | Status |
|---|---|---|---|
| ADR-001 | Legacy Baseline | 1.0.0 | Accepted |
| ADR-002 | Domain Evolution | 1.0.0 | Accepted |
| ADR-003 | Product Scope | 1.0.0 | Accepted |
| ADR-004 | Validation Strategy | 1.0.0 | Accepted |
| ADR-005 | Ubiquitous Language Refinement | 1.0.0 | Accepted |
| ADR-006 | Opportunity Lifecycle Alignment | 1.0.0 | Accepted |
| ADR-007 | Architecture Baseline v1.0 Freeze | 1.0.0 | Accepted |
| ADR-008 | Roadmap Restructuring — Parallel Tracks | 1.2.0 | Accepted |
| ADR-009 | Baseline Lock v1.1 | 1.1.0 | Accepted |
| ADR-010 | Learning Domain — New Bounded Context | 1.1.0 | Accepted |
| ADR-011 | Evidence Lifecycle | 1.0.0 | Accepted |
| ADR-012 | Architecture Baseline v2.0 Freeze | 1.0.0 | Accepted |
| ADR-013 | Trading Risk & Exit Strategy — Release 1.0 | 1.0.0 | Accepted |
| ADR-014 | Account Data Source for Risk Service — Release 1.0 | 1.0.0 | Accepted |

### 2.7 Validação

| ID | Título | Versão | Status |
|---|---|---|---|
| AUDIT-001 | Architecture Baseline Audit | 1.0.0 | Approved |
| AUDIT-001-CLOSURE | Closure Report (RC-001) | 1.0.0 | Approved |
| AUDIT-002 | Baseline Architecture Certification | 1.0.0 | Approved |
| VALIDATION-001 | Trading Strategy Validation Baseline | 2.0.0 | Approved |
| BACKTEST-001 | Backtest Execution Protocol | 1.0.0 | Approved |
| DATA-001 | Validation Data & Evidence Repository Standard | 1.0.0 | Approved |

### 2.8 RFCs

| ID | Título | Versão | Status |
|---|---|---|---|
| RFC-001 | Risk Profile Classification | 1.0.0 | **Open** |
| RFC-002 | Infrastructure Candidate Components | 1.0.0 | **Open** |
| RFC-003 | Data Provider Candidate Adapters | 1.0.0 | **Open** |
| RFC-004 | Legacy Indicator Mapping Ambiguity | 1.0.0 | **Open** |
| RFC-005 | Trading Risk & Exit Strategy | 1.0.0 | Approved (`ADR-013`) |
| RFC-006 | Risk Service Contract Divergence | 2.0.0 | Approved |
| RFC-007 | Signal Builder Pipeline Divergence | 2.0.0 | Approved |

### 2.9 Roadmap

| ID | Título | Versão | Status |
|---|---|---|---|
| ROADMAP-001 | Sprint 1 — Foundation | 1.0.0 | Approved |
| ROADMAP-002 | Sprint 2 — Market Data & Indicators | 1.0.0 | Approved |
| ROADMAP-003 | Sprint 3 — Signal Evaluation & Risk Validation | 1.0.0 | Approved |
| ROADMAP-004 | Sprint 4 — Order Execution Integration | 1.0.0 | Approved |
| ROADMAP-005 | Sprint 5 — First Execution & End-to-End Validation | 1.0.0 | Approved |
| ROADMAP-006 | Architecture Decision Backlog | 1.6.0 | Approved |

**Total**: 51 documentos governados (contando `DOCUMENT_CONTROL.md`/`CLAUDE.md`/`AGENTS.md`).

---

## 3. Relações de Dependência

### 3.1 Precedência Documental (`.project-rules/DOCUMENT_CONTROL.md`)

```
DOCUMENT_CONTROL → CONSTITUTION → ADR → DOMAIN → ARCH → SPEC → ENGINEERING → REFERENCE → VALIDATION → ROADMAP
```

### 3.2 Fluxo Oficial do Domínio (`ARCH-001`)

```
Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order
```

### 3.3 Pipeline Normativo da Release 1.0 (`RFC-007`, Alternativa B — substitui o fluxo de domínio completo nesta release)

```
Data Provider (INFRA-002) → Indicator Provider (INFRA-003) → Signal Builder (EXEC-004)
→ Risk Service (EXEC-003) → Order Manager (EXEC-001) → MT5 Adapter (EXEC-005) → Position Manager (EXEC-002)
```

### 3.4 Bounded Contexts (`ARCH-001` v1.3.0, `ADR-010`)

| Bounded Context | Componentes | Origem |
|---|---|---|
| Core Domain | Evidence, Market Context, Opportunity, Decision | `ARCH-001` (congelado, `ADR-007`) |
| Infrastructure | Data Provider, Indicator Provider, Configuration Provider, Time Provider, Persistence Provider, Logger | `INFRA-001` a `003` |
| Strategy | (sem componentes catalogados — ver §4.3) | `RC-001` (Decisão A: permanece ativo) |
| Execution | Signal Builder, Order Manager, Position Manager, Broker Adapter, MT5 Adapter, Risk Service (gate operacional) | `EXEC-001` a `005` |
| Learning Domain | Knowledge Service, Learning Service | `ADR-010`, `DOMAIN-006`, `LEARN-001`/`002` |

### 3.5 Cadeia de Congelamento da Baseline

```
ADR-007 (Baseline v1.0 Freeze)
  ↓
ADR-009 (Baseline Lock v1.1 — famílias documentais + sequência de entrega)
  ↓
ADR-010 (Learning Domain) + ADR-011 (Evidence Lifecycle) + ROADMAP-006
  ↓
AUDIT-002 (recertificação, GO, 88%)
  ↓
ADR-012 (Baseline v2.0 Freeze) ← estado atual
```

### 3.6 RFCs Resolvidas → ADRs

| RFC | Resolvida por | Decisão |
|---|---|---|
| RFC-006 | (auto-resolvida, v2.0.0) | Risk Service = Gate Operacional (`EXEC-003`) para R1; `SPEC-003` preservado para o futuro |
| RFC-007 | (auto-resolvida, v2.0.0) | Pipeline Alternativa B (sem estágio Opportunity) normativo para R1 |
| RFC-005 | `ADR-013` | Stop ATR + Stop Temporal / Percentual por Risco |

### 3.7 Dependências entre Componentes de Execução

```
EXEC-001 (Order Manager) ← EXEC-004 (Signal Result) + EXEC-003 (Risk Approved)
EXEC-002 (Position Manager) ← EXEC-001 (Order Accepted) + EXEC-005 (Broker Updates)
EXEC-003 (Risk Service) ← EXEC-004 (Signal Result) + EXEC-002 (Current Exposure) + EXEC-005 (Account Snapshot, ADR-014)
EXEC-005 (MT5 Adapter) ← EXEC-001 (Order Request)
```

---

## 4. Estado Atual do Projeto

### 4.1 Baseline

**v2.0**, congelada por `ADR-012` (tag `architecture-baseline-v2`). Core Domain intacto desde `ADR-007`. Última recertificação: `AUDIT-002` (Architecture Readiness Score 88%, decisão **GO**).

### 4.2 Release 1.0

Sequência de entrega travada (`ADR-009`) **completa**: `EXEC-001 → EXEC-002 → EXEC-003 → EXEC-004 → EXEC-005`. Sprints de implementação (`ROADMAP-001` a `005`) documentalmente definidos, aguardando execução de código (nenhum componente do modelo-alvo implementado ainda — Release 1.0 roda hoje sobre a Legacy Baseline via Strategy Tester nativo do MT5).

### 4.3 Pendências Abertas

**RFCs `Open`** (nenhuma resolvida nesta sessão): `RFC-001` (Risk Profile Classification — análise entregue, aguardando aprovação do Product Owner para gerar ADR/`DOMAIN-007`), `RFC-002` (Event Dispatcher/Scheduler), `RFC-003` (Data Provider adapters candidatos), `RFC-004` (mapeamento Legacy Indicator ambíguo).

**`ROADMAP-006` (Architecture Decision Backlog, v1.6.0)** — 14 itens: 3 `Implemented` (`ITEM-05`/`06`/`08`), 1 `Rejected` (`ITEM-07`), 2 prontos para aplicação direta (`ITEM-01`/`02`), 6 bloqueados (`ITEM-03`/`04`/`09`/`10`/`11`/`12`), 1 aguardando ADR (`ITEM-14` — Account Provider, análise entregue via `ADR-014`), 1 aguardando decisão do Product Owner (`ITEM-13` — componentes de Strategy, análise entregue).

**Gaps de catalogação**: Bounded Context `Strategy` sem componentes em `SPEC-001` (recorrente desde `AUDIT-001`, Finding #4; análise de `Strategy Engine`/`Policy`/`Configuration`/`Evaluator` já entregue, aguardando aprovação).

### 4.4 Decisões Recentes (`ADR-011` a `ADR-014`)

- `ADR-011`: Ciclo de vida de `Evidence` (`Candidate → Confirmed → Weak → Rejected → Expired`).
- `ADR-012`: Congelamento da Baseline v2.0.
- `ADR-013`: Regra de saída/sizing da Release 1.0 (Stop ATR + Stop Temporal / Percentual por Risco).
- `ADR-014`: `Risk Service` consome `Account Snapshot` diretamente de `MT5 Adapter` — nenhum `Account Provider` novo criado.

### 4.5 Learning Domain

5º Bounded Context (`ADR-010`), isolado do Core Domain/Platform. Dois componentes concretos catalogados: `Knowledge Service` (`LEARN-001`) e `Learning Service` (`LEARN-002`), ambos status `Planned` (não implementados). `knowledge/` (raiz do repositório) ainda sem conteúdo.

### 4.6 Dívida Técnica (Legacy Baseline, `Docs/TECH_DEBT.md`)

9 itens rastreados (3 Alto impacto, 3 Médio, 2 Baixo) — incluem duas cópias do repositório em disco, `PriceService.mqh` vazio, cluster órfão `IAnalyzer`/`TrendAnalyzer` (congelado, não integrado), documentação duplicada vazia (`Docs/CHANGELOG.md`/`ROADMAP.md`/`VERSION.md`).

---

## 5. Fontes Vivas (não duplicar manualmente — consultar diretamente)

| Necessidade | Documento |
|---|---|
| Índice oficial de ids/versões | `DOCUMENT_INDEX.md` |
| Rastreabilidade narrativa completa | `TRACEABILITY.md` |
| Histórico cronológico de mudanças | `CHANGELOG.md` |
| Backlog de decisões arquiteturais pendentes | `Docs/09-roadmap/ROADMAP-006-Architecture-Decision-Backlog.md` |
| Dívida técnica do código Legacy | `Docs/TECH_DEBT.md` |
