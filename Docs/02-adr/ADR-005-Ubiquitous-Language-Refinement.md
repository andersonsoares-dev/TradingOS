---
id: ADR-005
title: Ubiquitous Language Refinement
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - ADR-002
related:
  - DOMAIN-002
last_updated: 2026-07-21
---

# Contexto

Durante a consolidação do Ubiquitous Language foi identificado que alguns termos utilizados pela Legacy Baseline foram classificados como proibidos.

A análise mostrou que parte desses termos representa conceitos legítimos do domínio, porém pertencentes a outro Bounded Context.

Não existe necessidade de eliminá-los.

Existe apenas necessidade de posicioná-los corretamente.

# Decisão

Signal deixa de ser um termo proibido.

Confirmation deixa de ser um termo proibido.

Trigger continua não fazendo parte do Core Domain.

Order continua pertencendo exclusivamente ao contexto de execução.

Trade continua não sendo uma entidade do domínio.

# Modelo Oficial

Indicators

↓

Evidence

↓

Market Context

↓

Opportunity

↓

Decision

↓

Signal

↓

Execution

# Consequências

A Legacy Baseline permanece consistente.

Não existe necessidade de renomeação retroativa.

Os novos componentes utilizarão este fluxo como referência arquitetural.

Status: Accepted
