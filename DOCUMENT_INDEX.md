# Document Index

Índice oficial de todos os documentos versionados do TradingOS, conforme .project-rules/DOCUMENT_CONTROL.md (Regra 12).

| ID | Título | Caminho | Versão | Status |
|---|---|---|---|---|
| — | Document Control Protocol | .project-rules/DOCUMENT_CONTROL.md | 1.0.0 | Approved |
| — | Claude AI Development Protocol | CLAUDE.md | — | Approved |
| — | Universal AI Protocol | AGENTS.md | — | Approved |
| ENG-000 | Engineering Handbook | Docs/00-governance/ENG-000-Engineering-Handbook.md | 1.0.0 | Approved |
| CONST-001 | TradingOS Constitution | Docs/00-governance/CONST-001-Constitution.md | 1.0.0 | Approved |
| VISION-001 | Product Vision | Docs/00-governance/VISION-001-Product-Vision.md | 1.0.0 | Approved |
| REQ-001 | Requirements Specification | Docs/01-requirements/REQ-001-Requirements-Specification.md | 1.0.0 | Approved |
| DOMAIN-001 | Opportunity | Docs/02-domain/DOMAIN-001-Opportunity.md | 1.0.0 | Approved |
| DOMAIN-002 | Ubiquitous Language | Docs/02-domain/DOMAIN-002-Ubiquitous-Language.md | 1.0.0 | Approved |
| DOMAIN-003 | Evidence | Docs/02-domain/DOMAIN-003-Evidence.md | 1.0.0 | Approved |
| ADR-001 | Legacy Baseline | Docs/05-decisions/ADR-001-Legacy-Baseline.md | 1.0.0 | Accepted |
| ADR-002 | Domain Evolution | Docs/05-decisions/ADR-002-Domain-Evolution.md | 1.0.0 | Accepted |
| ADR-003 | Product Scope | Docs/05-decisions/ADR-003-Product-Scope.md | 1.0.0 | Accepted |
| ADR-004 | Validation Strategy | Docs/05-decisions/ADR-004-Validation-Strategy.md | 1.0.0 | Accepted |
| ADR-005 | Ubiquitous Language Refinement | Docs/05-decisions/ADR-005-Ubiquitous-Language-Refinement.md | 1.0.0 | Accepted |
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

- `DOMAIN-004`, `DOMAIN-005` e `ARCH-001` (referenciados como `related` em VISION-001, REQ-001, DOMAIN-001, DOMAIN-002 e DOMAIN-003) ainda não existem.
- `Docs/03-architecture/`, `04-specifications/`, `06-validation/`, `07-testing/`, `08-reference/`, `09-roadmap/`, `10-rfc/` e todas as subpastas de `knowledge/` existem mas estão vazias (git não rastreia diretórios vazios).
- `Docs/CHANGELOG.md`, `Docs/ROADMAP.md`, `Docs/VERSION.md` existem mas continuam vazios — duplicidade com `CHANGELOG.md` (raiz), já registrada em `Docs/TECH_DEBT.md`.
