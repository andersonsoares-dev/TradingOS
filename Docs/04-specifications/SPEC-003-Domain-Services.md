---
id: SPEC-003
title: Domain Services
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - SPEC-002
related:
  - SPEC-004
last_updated: 2026-07-21
---

# Domain Services

## Objetivo

Definir todos os Domain Services oficiais do TradingOS.

Os serviços de domínio encapsulam regras de negócio que não pertencem a uma única entidade ou Value Object.

Todos os serviços devem ser stateless.

Não podem depender de infraestrutura.

---

# Princípios

Todo Domain Service deve:

- possuir responsabilidade única;
- ser determinístico;
- ser independente de plataforma;
- operar apenas sobre objetos do domínio;
- produzir resultados imutáveis.

---

# Opportunity Service

## Responsabilidade

Avaliar um Market Context e identificar possíveis Opportunity.

## Entrada

Market Context

## Saída

Opportunity

## Dependências

Nenhuma.

---

# Decision Service

## Responsabilidade

Avaliar uma Opportunity e produzir uma Decision.

## Entrada

Opportunity

## Saída

Decision

## Dependências

Nenhuma.

---

# Confidence Service

## Responsabilidade

Calcular o grau de confiança de uma Opportunity.

## Entrada

Evidence Collection

Market Context

## Saída

Confidence

---

# Risk Service

## Responsabilidade

Avaliar o risco da Opportunity.

## Entrada

Opportunity

Market Context

## Saída

Risk Profile

---

# Observação

Este documento contém exclusivamente Domain Services (Opportunity Service, Decision Service, Confidence Service, Risk Service).

Builders, Providers e Policies não pertencem a este documento.

As definições oficiais dos componentes encontram-se em SPEC-001.

---

# Regras Gerais

Os serviços:

não armazenam estado;

não persistem dados;

não executam ordens;

não acessam APIs;

não acessam MT5;

não calculam indicadores.

---

# Dependências Permitidas

Domain Services podem depender apenas de:

Entities

Value Objects

Domain Policies

Domain Rules

---

# Dependências Proibidas

Infrastructure

Execution

Broker

Database

Logger

Network

Indicators

Adapters

---

# Legacy Baseline

Correspondências aproximadas (apenas para os Domain Services listados neste documento):

SignalBuilderService

↓

Decision Service + Execution

MarketAssessment

↓

Opportunity Service + Confidence Service

Essas correspondências servem apenas como referência para migração incremental.

Não representam equivalência direta.

TrendService, RSIService, ATRService e ADXService correspondem a Evidence Builder — ver SPEC-001, não Domain Service.

---

# Evolução

Novos Domain Services poderão ser adicionados desde que:

- possuam responsabilidade única;
- respeitem o ARCH-001;
- sejam registrados neste documento.

---

# Rastreabilidade

ARCH-001

SPEC-001

SPEC-002

DOMAIN-001

DOMAIN-003

DOMAIN-004

DOMAIN-005

REQ-001

REQ-002

REQ-003

REQ-004

REQ-005

REQ-006

REQ-007

REQ-008

REQ-009

REQ-010
