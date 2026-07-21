---
id: ADR-007
title: Architecture Baseline v1.0 Freeze
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - AUDIT-001
related:
  - DOMAIN-001
  - DOMAIN-002
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - SPEC-003
  - SPEC-004
  - SPEC-005
  - SPEC-006
last_updated: 2026-07-21
---

# ADR-007: Architecture Baseline v1.0 Freeze

## Status

Accepted

## Contexto

A auditoria arquitetural completa (`AUDIT-001`) identificou 14 inconsistências documentais no repositório. Os 2 achados Críticos e os 3 Altos foram fechados pelo RC-001 (ver `Docs/06-validation/AUDIT-001-CLOSURE.md`). Com o fechamento do RC-001, o repositório recebeu a tag `architecture-baseline-v1.0`, marcando o primeiro ponto de consistência plena entre Governança, Domínio, Arquitetura e Especificações.

Esta decisão já havia sido registrada como observação em `.project-rules/DOCUMENT_CONTROL.md` (v1.2.0). Este ADR a formaliza, conforme a Regra 1 do próprio `DOCUMENT_CONTROL` ("nenhuma decisão arquitetural poderá permanecer apenas na conversa; toda decisão deverá gerar um ADR").

## Decisão

Os documentos de Governança (`ENG-000`, `CONST-001`, `VISION-001`, `DOCUMENT_CONTROL`, `CLAUDE.md`, `AGENTS.md`), Domínio (`DOMAIN-001` a `DOMAIN-005`), Arquitetura (`ARCH-001`) e Especificações (`SPEC-001` a `SPEC-006`) pertencentes à Baseline v1.0 encontram-se congelados a partir desta tag.

Alterações a qualquer um desses documentos somente poderão ocorrer mediante:

- um novo ADR; ou
- uma RFC aprovada; ou
- correção documental sem impacto arquitetural.

`Requirements` (`REQ-001`) não está incluído neste congelamento — permanece livre para evoluir conforme novos requisitos forem identificados, sem exigir ADR/RFC prévia, desde que a mudança não altere o modelo de domínio ou a arquitetura já congelados.

Os próprios ADRs (registros históricos, conforme Regra 10 do `DOCUMENT_CONTROL` — "nenhum arquivo poderá ser apagado") não são alvo deste congelamento; são o mecanismo pelo qual o congelamento pode ser alterado.

## Consequências

- Qualquer sprint futura que exija alterar `DOMAIN-00X`, `ARCH-001` ou `SPEC-00X` deverá abrir um ADR ou uma RFC aprovada antes da alteração.
- `RFC-001` (Risk Profile Classification) e a decisão pendente sobre a categoria "Strategy" em `SPEC-001` (ver `AUDIT-001-CLOSURE`, Finding #4) permanecem como exemplos de itens que, quando resolvidos, deverão seguir este processo.
- Correções puramente documentais (sem impacto arquitetural — erro de digitação, link quebrado, formatação) continuam permitidas sem ADR/RFC.
- A Fase 2 (Infrastructure e MT5 Integration) parte deste ponto congelado como sua base arquitetural.
