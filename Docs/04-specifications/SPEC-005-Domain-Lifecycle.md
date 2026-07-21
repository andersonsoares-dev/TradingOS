---
id: SPEC-005
title: Domain Lifecycle
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-001
  - DOMAIN-004
  - DOMAIN-005
  - SPEC-001
  - SPEC-003
  - SPEC-004
related:
  - SPEC-006
last_updated: 2026-07-21
---

# Domain Lifecycle

Os ciclos de vida das entidades pertencem aos documentos DOMAIN.

Este documento apenas especifica como cada transição é orquestrada.

## Objetivo

Definir a orquestração oficial das transições de estado dos principais objetos do domínio.

Este documento não define estados. Os estados de cada entidade pertencem exclusivamente ao seu respectivo documento de domínio (DOMAIN-001, DOMAIN-004, DOMAIN-005).

Este documento especifica, para cada transição já definida no domínio, qual Application Service orquestra a transição, qual Domain Service executa a regra de negócio envolvida e qual Policy valida a transição.

---

# Scope

O ciclo de vida das entidades pertence ao domínio.

DOMAIN-001 define o ciclo de vida de Opportunity.

DOMAIN-004 define o ciclo de vida de Market Context.

DOMAIN-005 define o ciclo de vida de Decision.

Este documento (SPEC-005) não redefine, não duplica e não substitui esses estados. Sua única responsabilidade é mapear a orquestração de cada transição já definida, utilizando exclusivamente os componentes registrados no Canonical Component Catalog (SPEC-001).

Onde não existir, hoje, um Application Service, Domain Service ou Policy definido para uma transição, a célula correspondente é marcada como "—". Nenhum componente é inventado neste documento.

---

# Lifecycle Orchestration

## Opportunity Lifecycle

Estados definidos em DOMAIN-001.

| Transição | Orquestrador | Domain Service | Policy |
|---|---|---|---|
| Draft → Qualified | Analyze Market Use Case | Opportunity Service | Context Validation Policy |
| Qualified → Approved | Evaluate Opportunity Use Case | Decision Service | Evidence Validation Policy |
| Approved → Completed | Generate Decision Use Case | Decision Service | — |

---

## Decision Lifecycle

Estados definidos em DOMAIN-005.

| Transição | Orquestrador | Domain Service | Policy |
|---|---|---|---|
| Draft → Generated | Generate Decision Use Case | Decision Service | — |
| Generated → Published | Publish Signal Use Case | — | — |
| Published → Consumed | — | — | — |
| Consumed → Archived | — | — | — |

---

## Market Context Lifecycle

Estados definidos em DOMAIN-004.

| Transição | Orquestrador | Domain Service | Policy |
|---|---|---|---|
| Building → Validated | Validate Context Use Case | — | Context Validation Policy |
| Validated → Frozen | Analyze Market Use Case | — | — |
| Frozen → Obsolete | — | — | — |

---

# Regras Gerais

Nenhum objeto pode retornar para um estado anterior.

Toda transição deve preservar rastreabilidade.

Estados finais:

Completed (Opportunity, conforme DOMAIN-001)

Archived (Decision, conforme DOMAIN-005)

Obsolete (Market Context, conforme DOMAIN-004)

---

# Responsabilidades

Builders:

criam objetos.

Policies:

validam transições.

Application Services:

orquestram o ciclo.

Domain Services:

executam regras de negócio.

Execution:

consome apenas Decision publicada.

---

# Legacy Baseline

Na versão atual esses estados encontram-se implícitos na sequência de execução do Expert Advisor.

Nenhum dos Application Services, Domain Services ou Policies listados acima está implementado hoje — todos são componentes `Planned`, conforme SPEC-001 (Component Lifecycle).

Este documento formaliza a orquestração esperada sem exigir alterações retroativas.

---

# Rastreabilidade

DOMAIN-001

DOMAIN-004

DOMAIN-005

SPEC-001

SPEC-003

SPEC-004

ARCH-001
