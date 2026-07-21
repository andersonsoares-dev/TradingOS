---
id: RFC-003
title: Data Provider Candidate Adapters
version: 1.0.0
status: Open
owner: Product Owner
depends_on:
  - SPEC-001
  - INFRA-002
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-003: Data Provider Candidate Adapters

## Classificação

Requires Architectural Decision

## Contexto

Durante a elaboração de `Docs/03-architecture/INFRA-002-Data-Provider.md` (Fase 2, Entrega 02), o brief de origem citou, como dependências e alvos de extensibilidade do `Data Provider`, os seguintes nomes:

- `Replay Adapter`
- `CSV Provider` / `CSV Adapter`
- `Mock Provider`
- `REST Adapter`
- `FIX Adapter`
- `WebSocket Adapter`

Nenhum desses nomes consta no Canonical Component Catalog (`SPEC-001`), que é a única fonte oficial de nomenclatura de componentes do projeto. `AGENTS.md` (regra "Canonical Naming") proíbe introduzir componentes novos fora do próprio `SPEC-001`, e `ADR-007` (Architecture Baseline v1.0 Freeze) proíbe alterar `SPEC-001` sem um ADR ou uma RFC aprovada.

Por esse motivo, nenhum desses nomes foi incorporado como dependência ou componente aprovado em `INFRA-002` — todos foram citados apenas como candidatos (dois deles, `Replay Adapter` e `CSV Provider`, já marcados como "(futuro)" no próprio brief de origem), com referência a esta RFC.

## Proposta em aberto

Esta RFC não propõe estrutura, interface ou contrato para nenhum desses adapters — isso seria antecipar uma decisão de catálogo fora do processo formal.

Esta RFC apenas registra que existe uma necessidade potencial, identificada no roadmap da Fase 2 (extensibilidade do `Data Provider` para múltiplas fontes de dados), de eventualmente formalizar:

- um adapter para reprodução histórica de dados (`Replay Adapter`);
- um adapter para arquivos CSV (`CSV Provider`/`CSV Adapter`);
- um provider de dados simulados para testes (`Mock Provider`);
- adapters para integrações via protocolo (`REST Adapter`, `FIX Adapter`, `WebSocket Adapter`).

## Encaminhamento

Caso aprovados, todos deverão ser adicionados formalmente à categoria "Infrastructure Providers" (ou categoria nova, a decidir) do `SPEC-001`, seguindo o Documentation Validation Pipeline (`AGENTS.md`), antes de aparecerem em qualquer especificação técnica futura ou implementação.

## Status

Open — aguardando decisão do Product Owner / Chief Architect.
