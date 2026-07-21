---
id: DOMAIN-005
title: Decision
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-001
  - DOMAIN-003
  - DOMAIN-004
related:
  - ARCH-001
  - SPEC-001
last_updated: 2026-07-21
---

# Decision

## Objetivo

Definir o objeto de domínio que representa o resultado final do processo de análise do TradingOS.

A Decision é produzida pelo domínio após avaliar uma Opportunity dentro de um determinado Market Context.

Ela representa exclusivamente uma conclusão lógica.

Não representa uma ordem de mercado.

Não representa uma execução.

---

# Definição

Decision é um objeto de domínio imutável que formaliza a conclusão produzida pelo Core Domain.

Ela constitui a única saída oficial do processo de decisão.

---

# Responsabilidades

A Decision deve:

- representar uma conclusão do domínio;
- possuir justificativa completa;
- ser totalmente explicável;
- ser independente da plataforma de execução;
- servir de entrada para componentes externos.

---

# Não Responsabilidades

A Decision NÃO deverá:

- abrir posições;
- enviar ordens;
- acessar corretoras;
- acessar MT5;
- controlar risco operacional;
- executar estratégias.

Essas responsabilidades pertencem ao contexto de Execution.

---

# Estrutura

Cada Decision deverá possuir:

## DecisionId

Identificador único.

---

## OpportunityId

Referência à Opportunity que originou a decisão.

---

## ContextId

Referência ao Market Context utilizado.

---

## Decision Type

Valores possíveis:

- Long
- Short
- Hold
- Ignore

---

## Confidence

Faixa:

0.0 → 1.0

Representa o grau de confiança do domínio.

---

## Rationale

Lista estruturada contendo as principais justificativas.

Exemplos:

- Trend Alignment
- Momentum Confirmation
- Volatility Acceptable
- Liquidity Adequate
- Risk Acceptable

---

## Timestamp

Momento da decisão.

---

## Metadata

Informações adicionais para auditoria.

---

# Regras de Negócio

## BR-001

Toda Decision deve estar associada a exatamente uma Opportunity.

---

## BR-002

Toda Decision deve possuir um Market Context válido.

---

## BR-003

Toda Decision deve possuir Confidence.

---

## BR-004

Toda Decision deve possuir justificativas rastreáveis.

---

## BR-005

Decision não poderá depender de APIs externas.

---

## BR-006

Decision não poderá conter lógica específica de MT5.

---

# Invariantes

Nunca poderá existir uma Decision sem:

- Opportunity;
- Market Context;
- Confidence;
- Timestamp;
- Tipo de decisão.

---

# Relacionamentos

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

---

# Integração com Execution

Após produzida pelo domínio, a Decision poderá ser convertida em um Signal pelo contexto de Execution.

Essa transformação não pertence ao Core Domain.

O domínio permanece completamente desacoplado da plataforma de execução.

---

# Legacy Baseline

Na versão atual, componentes como:

- TradingSignal
- SignalBuilderService
- ENUM_TRADING_SIGNAL

desempenham parcialmente esse papel.

Conforme ADR-001 e ADR-002, esses componentes permanecem válidos até futura evolução arquitetural.

Não haverá renomeação retroativa.

---

# Evolução

Novos tipos de Decision poderão ser adicionados sem alterar a estrutura fundamental do domínio.

---

# Rastreabilidade

REQ-005

REQ-006

REQ-007

REQ-008

REQ-009

REQ-010
