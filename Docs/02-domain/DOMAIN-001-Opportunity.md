---
id: DOMAIN-001
title: Opportunity
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - REQ-001
  - ADR-002
related:
  - DOMAIN-002
  - DOMAIN-003
  - ARCH-001
last_updated: 2026-07-21
---

# Opportunity

## Objetivo

Definir a entidade central do domínio TradingOS.

Uma Opportunity representa uma oportunidade de mercado identificada pelo sistema após a consolidação das evidências disponíveis.

Ela não representa uma ordem nem uma posição.

A execução permanece responsabilidade de componentes externos.

---

# Definição

Uma Opportunity é uma hipótese operacional gerada pelo domínio.

Ela possui:

- contexto
- evidências
- direção
- risco
- confiança
- justificativa

---

# Responsabilidades

A Opportunity deve:

- representar uma oportunidade válida;
- possuir identidade própria;
- consolidar evidências;
- armazenar explicações;
- permitir avaliação posterior.

---

# Não Responsabilidades

A Opportunity NÃO deverá:

- enviar ordens;
- acessar MT5;
- acessar APIs;
- consultar indicadores;
- executar cálculos técnicos.

Essas responsabilidades pertencem a Services ou Adapters.

---

# Ciclo de Vida

Draft

↓

Qualified

↓

Approved

↓

Executed

↓

Closed

↓

Archived

Nem todos os estados precisam existir na implementação inicial.

---

# Atributos

## Identity

OpportunityId

---

## Market

- Symbol
- Timeframe
- Strategy

---

## Context

Referência para o MarketContext.

---

## Direction

BUY

SELL

WAIT

NO_TRADE

---

## Confidence

Valor normalizado.

Faixa:

0.0 → 1.0

---

## Risk

Objeto de domínio próprio.

---

## Evidence Set

Coleção de evidências utilizadas.

---

## Explanation

Coleção estruturada de justificativas.

---

## Timestamp

Momento da criação.

---

# Regras de Negócio

## BR-001

Toda Opportunity deve possuir Context.

---

## BR-002

Toda Opportunity deve possuir pelo menos uma Evidence.

---

## BR-003

Toda Opportunity deve possuir Confidence.

---

## BR-004

Toda Opportunity deve possuir Explanation.

---

## BR-005

A Direction somente poderá ser definida após avaliação completa.

---

## BR-006

Opportunity é imutável após aprovação.

---

# Invariantes

Nunca poderá existir Opportunity sem:

- contexto;
- confiança;
- direção;
- justificativa.

---

# Relacionamentos

Opportunity

↓

MarketContext

↓

EvidenceSet

↓

RiskProfile

↓

Decision

---

# Evolução da V1

Conforme ADR-002:

V1

MarketAssessment

↓

TradingSignal

Evolui conceitualmente para:

MarketContext

↓

Opportunity

↓

Decision

Não existe migração obrigatória.

A coexistência entre ambos os modelos é permitida.

---

# Rastreabilidade

REQ-005

REQ-006

REQ-007

REQ-008

REQ-009

---

# Alterações

Mudanças estruturais nesta entidade exigem atualização do modelo de domínio e registro em ADR quando alterarem regras fundamentais.
