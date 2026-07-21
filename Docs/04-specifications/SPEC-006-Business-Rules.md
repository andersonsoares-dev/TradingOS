---
id: SPEC-006
title: Business Rules
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-001
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
  - SPEC-003
  - SPEC-004
related:
  - SPEC-007
last_updated: 2026-07-21
---

# Business Rules

## Objetivo

Consolidar todas as regras de negócio do TradingOS em um único documento.

Este documento não define componentes, arquitetura ou interfaces.

Seu objetivo é documentar as regras que governam as decisões do domínio.

---

# Escopo

Inclui:

- regras de validação;
- regras de consistência;
- regras de decisão;
- regras de rastreabilidade.

Não inclui:

- detalhes de implementação;
- algoritmos específicos;
- código.

---

# Classificação

As regras são classificadas em:

## BR-1xx

Validação

## BR-2xx

Contexto

## BR-3xx

Opportunity

## BR-4xx

Decision

## BR-5xx

Execution Boundary

---

# BR-101

Uma Evidence deve possuir origem identificável.

---

# BR-102

Toda Evidence deve possuir timestamp.

---

# BR-103

Evidence inválidas não podem compor um Market Context.

---

# BR-201

Todo Market Context deve ser validado antes de ser utilizado.

---

# BR-202

Market Context congelado (Frozen) não pode ser modificado.

---

# BR-301

Uma Opportunity somente pode ser criada a partir de um Market Context válido.

---

# BR-302

Uma Opportunity somente pode produzir uma Decision.

---

# BR-303

Uma Opportunity concluída não pode retornar a estados anteriores.

---

# BR-401

Toda Decision deve possuir justificativa rastreável.

---

# BR-402

Toda Decision deve possuir nível de confiança.

---

# BR-403

Decision publicada torna-se imutável.

---

# BR-501

Execution nunca modifica objetos do Core Domain.

---

# BR-502

Execution consome apenas Decision publicada.

---

# BR-503

Execution não altera Opportunity.

---

# Invariantes

Os seguintes princípios devem ser preservados:

- imutabilidade após publicação;
- rastreabilidade completa;
- separação entre Core Domain e Execution;
- consistência temporal;
- unicidade da Decision.

---

# Rastreabilidade

Cada regra deverá ser implementada por um ou mais Domain Services, Policies ou Application Services.

A implementação será documentada futuramente.

---

# Legacy Baseline

A implementação atual do Expert Advisor contém parte destas regras distribuídas entre serviços.

Este documento consolida a definição funcional sem alterar o comportamento existente.

---

# Referências

DOMAIN-001

DOMAIN-003

DOMAIN-004

DOMAIN-005

ARCH-001

SPEC-003

SPEC-004

ADR-006
