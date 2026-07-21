---
id: ADR-004
title: Validation Strategy
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - ENG-000
related:
  - TRACEABILITY.md
last_updated: 2026-07-21
---

# ADR-004: Validation Strategy

## Status

Accepted

## Contexto

`ENG-000` exige testes unitários/integração como parte do Definition of Done. MQL5 não possui um framework de testes unitários unificado e amplamente adotado equivalente ao de outras linguagens, tornando o requisito de "testes unitários obrigatórios" inviável na prática atual do projeto.

## Decisão

O projeto adota um pipeline de validação compatível com MQL5, substituindo o conceito tradicional de testes unitários obrigatórios por níveis de validação:

1. Static Analysis
2. Compilation
3. Strategy Tester
4. Historical Simulation
5. Walk Forward
6. Demo Validation
7. Production Validation

Quando tecnicamente viável, testes automatizados poderão ser incorporados como camada adicional, não substituta.

## Consequências

- `ENG-000` (Definition of Done) deve ser lido em conjunto com este ADR: "testes atualizados" passa a significar "nível de validação apropriado atingido", não necessariamente teste unitário automatizado.
- `TRACEABILITY.md` deve registrar, por componente, qual nível deste pipeline foi efetivamente alcançado.
