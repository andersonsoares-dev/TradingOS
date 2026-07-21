---
id: RFC-001
title: Risk Profile Classification
version: 1.0.0
status: Open
owner: Product Owner
depends_on:
  - DOMAIN-001
  - DOMAIN-002
  - SPEC-001
  - SPEC-003
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-001: Risk Profile Classification

## Classificação

Requires Architectural Decision

## Contexto

"Risk Profile" é citado como conceito de domínio em DOMAIN-001 (atributo `Risk` da Opportunity: "Objeto de domínio próprio"), DOMAIN-002 (vocabulário: "Representação do risco associado à Opportunity"), SPEC-001 e SPEC-003 (saída declarada do Risk Service) — mas nunca recebeu um documento DOMAIN-00X próprio (atributos, regras de negócio, invariantes), diferente de todo outro conceito de domínio citado nesses mesmos documentos (Evidence → DOMAIN-003, Market Context → DOMAIN-004, Decision → DOMAIN-005).

Identificado em `Docs/06-validation/AUDIT-001-Architecture-Baseline.md`, Finding #3 (severidade Alta).

## Proposta em aberto

Esta RFC não propõe uma solução, nem antecipa atributos, estrutura ou regras de negócio para Risk Profile — isso constituiria criar um novo conceito de domínio fora do processo formal de validação documental (AGENTS.md — Documentation Validation Pipeline).

Esta RFC apenas registra que uma decisão arquitetural é necessária antes de o Risk Service (hoje `Planned` em SPEC-001, associado a REQ-009 "não atendido") avançar para especificação detalhada ou implementação.

## Encaminhamento

Quando esta decisão for tomada, ela deverá seguir o Documentation Validation Pipeline (AGENTS.md: DOMAIN-002 → SPEC-001 → ARCH-001 → TRACEABILITY) e resultar em um documento DOMAIN-00X formal (classificando Risk Profile como Entity, Value Object ou parte de outro Aggregate) — não nesta RFC.

## Status

Open — aguardando decisão do Product Owner / Chief Architect.
