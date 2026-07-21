---
id: DOMAIN-004
title: Market Context
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-003
related:
  - DOMAIN-001
  - DOMAIN-005
  - ARCH-001
last_updated: 2026-07-21
---

# Market Context

## Objetivo

Definir o Aggregate Root responsável por representar o estado atual do mercado.

O Market Context consolida todas as Evidence disponíveis em um determinado instante e fornece uma visão consistente para que o domínio possa identificar uma Opportunity.

O Market Context não toma decisões operacionais.

Sua responsabilidade é representar o mercado.

---

# Definição

Market Context é um Aggregate Root composto por um conjunto de Evidence relacionadas ao mesmo ativo, timeframe e instante temporal.

Representa uma fotografia lógica do mercado.

---

# Responsabilidades

O Market Context deve:

- consolidar Evidence;
- garantir consistência entre as informações;
- representar o estado atual do mercado;
- servir de entrada para identificação de Opportunity;
- permitir reutilização por diferentes estratégias.

---

# Não Responsabilidades

O Market Context NÃO deverá:

- executar ordens;
- acessar APIs;
- acessar MT5;
- calcular indicadores;
- definir entradas;
- gerar sinais operacionais.

---

# Estrutura

Cada Market Context deverá possuir:

## ContextId

Identificador único.

---

## Asset

Ativo analisado.

Exemplo:

EURUSD

XAUUSD

GBPUSD

---

## Timeframe

Período analisado.

Exemplos:

M15

H1

H4

D1

---

## Timestamp

Momento representado.

---

## Evidence Collection

Coleção de Evidence pertencentes ao contexto.

---

## Summary

Resumo derivado das evidências.

Exemplos:

- Bullish
- Bearish
- Neutral
- High Volatility
- Low Liquidity

---

## Confidence

Nível geral de confiança do contexto.

Faixa:

0.0 → 1.0

---

# Regras de Negócio

## BR-001

Toda Evidence deve pertencer ao mesmo ativo.

---

## BR-002

Toda Evidence deve pertencer ao mesmo timeframe.

---

## BR-003

Toda Evidence deve representar aproximadamente o mesmo instante temporal.

---

## BR-004

O Contexto não poderá conter Evidence inválidas.

---

## BR-005

O Contexto deverá permanecer imutável após sua construção.

---

# Invariantes

Nunca poderá existir um Market Context sem:

- ativo;
- timeframe;
- timestamp;
- pelo menos uma Evidence.

---

# Relacionamentos

Evidence

↓

Market Context

↓

Opportunity

↓

Decision

---

# Legacy Baseline

Na versão atual, informações equivalentes ao Market Context encontram-se distribuídas entre diversos serviços e estruturas auxiliares.

Exemplos:

MarketAssessment

MarketContext struct

TrendService

ATRService

RSIService

ADXService

SessionService

A arquitetura futura concentrará essas informações em um único Aggregate Root.

Conforme ADR-001, nenhuma migração retroativa será realizada.

---

# Evolução

Novas categorias de Evidence poderão ser adicionadas ao Market Context sem alterar sua estrutura.

---

# Rastreabilidade

REQ-002

REQ-003

REQ-004

REQ-005

REQ-010
