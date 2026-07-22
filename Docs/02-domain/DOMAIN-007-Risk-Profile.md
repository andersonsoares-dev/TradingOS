---
id: DOMAIN-007
title: Risk Profile
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-001
  - DOMAIN-002
  - ADR-007
  - ADR-015
related:
  - SPEC-003
  - ROADMAP-006
last_updated: 2026-07-22
---

# Risk Profile

## Objetivo

Definir o conceito de Risk Profile no domínio do TradingOS.

Risk Profile representa a avaliação de risco de uma Opportunity em um dado Market Context.

Ela nunca toma decisões.

---

# Classificação

**Value Object.** Sem identidade própria. Igualdade por valor. Imutável após criado.

Formaliza o atributo `Risk` já declarado em `DOMAIN-001` (`ADR-015`).

---

# Definição

Risk Profile é um objeto de domínio imutável, produzido exclusivamente pelo `Risk Service` (`SPEC-003`, Domain Service) a partir de uma `Opportunity` e um `Market Context`.

---

# Responsabilidades

Um Risk Profile deve:

- representar a avaliação de risco de uma única Opportunity;
- possuir grau de risco mensurável;
- possuir justificativa;
- ser imutável.

---

# Não Responsabilidades

Risk Profile NÃO deverá:

- tomar decisões;
- controlar risco operacional (responsabilidade do Pre-Order Risk Gate, `EXEC-003`, conceito distinto — ver `RFC-006`/`ADR-014`);
- persistir com identidade própria;
- acessar infraestrutura.

---

# Estrutura

## Risk Score

Faixa: 0.0 → 1.0.

## Risk Level

Categórico: Low / Medium / High. Derivado do Risk Score.

## Rationale

Lista estruturada de justificativas, mesmo padrão de `Decision.Rationale` (`DOMAIN-005`).

## Timestamp

Momento da avaliação.

---

# Regras de Negócio

## BR-001

Todo Risk Profile deve possuir Risk Score.

## BR-002

Todo Risk Profile deve possuir Rationale.

## BR-003

Risk Profile é imutável após criado.

## BR-004

Risk Profile não pode existir sem uma Opportunity associada.

---

# Invariantes

Nunca poderá existir um Risk Profile sem:

- Risk Score;
- Rationale;
- Timestamp.

---

# Relacionamentos

Opportunity + Market Context

↓

Risk Service (SPEC-003)

↓

Risk Profile

↓

embutido em Opportunity.Risk

---

# Dependências

Depende apenas de `Opportunity`/`Market Context` (leitura). Produzido por `Risk Service` (`SPEC-003`). Nenhuma dependência de infraestrutura ou Execution.

---

# Rastreabilidade

`RFC-001` · `ADR-015` · `DOMAIN-001` · `SPEC-003` · `ROADMAP-006`

---

# Alterações

**v1.0.0**: criação, formalizando `ADR-015` (resolução de `RFC-001`, `ITEM-03`/`ITEM-09` de `ROADMAP-006`).
