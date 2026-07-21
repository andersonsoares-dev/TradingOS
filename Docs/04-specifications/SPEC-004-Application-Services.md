---
id: SPEC-004
title: Application Services
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - SPEC-003
related:
  - SPEC-005
last_updated: 2026-07-21
---

# Application Services

## Objetivo

Definir os serviços responsáveis por orquestrar o fluxo da aplicação.

Application Services coordenam o trabalho dos Domain Services.

Não implementam regras de negócio.

Não conhecem detalhes de infraestrutura.

Sua responsabilidade é coordenar casos de uso.

---

# Princípios

Application Services:

- não implementam regras de negócio;
- não calculam indicadores;
- não executam ordens;
- apenas coordenam componentes.

---

# Analyze Market Use Case

## Objetivo

Executar um ciclo completo de análise do mercado.

Fluxo:

Data Provider

↓

Evidence Builder

↓

Market Context Builder

↓

Opportunity Service

↓

Decision Service

↓

Decision

---

## Entrada

Asset

Timeframe

Configuration

---

## Saída

Decision

---

# Validate Context Use Case

## Objetivo

Construir e validar um Market Context.

Fluxo:

Evidence Builder

↓

Market Context Builder

↓

Context Validation Policy

↓

Market Context

---

# Evaluate Opportunity Use Case

## Objetivo

Avaliar uma Opportunity para um Market Context válido.

Fluxo:

Market Context

↓

Opportunity Service

↓

Opportunity

---

# Generate Decision Use Case

## Objetivo

Produzir uma Decision para uma Opportunity.

Fluxo:

Opportunity

↓

Confidence Service

↓

Risk Service

↓

Decision Service

↓

Decision

---

# Publish Signal Use Case

## Objetivo

Entregar uma Decision ao contexto de Execution.

Fluxo:

Decision

↓

Signal Builder

↓

Execution

Observação:

O Application Service encerra sua responsabilidade ao publicar a Decision para o contexto de Execution.

---

# Dependências Permitidas

Application Services podem depender de:

- Builders;
- Domain Services;
- Policies.

---

# Dependências Proibidas

Application Services não podem depender diretamente de:

- MT5 Adapter;
- Broker Adapter;
- Order Manager;
- Position Manager.

Esses componentes pertencem ao contexto de Execution.

---

# Responsabilidades

Application Services devem:

- coordenar componentes;
- controlar fluxo;
- garantir ordem de execução;
- propagar erros;
- registrar eventos para auditoria.

---

# Não Responsabilidades

Application Services não devem:

- tomar decisões de negócio;
- modificar Entities;
- acessar indicadores diretamente;
- executar ordens.

---

# Fluxo Oficial

Analyze Market

↓

Market Context

↓

Opportunity

↓

Decision

↓

Execution

---

# Legacy Baseline

Na versão atual, o Expert Advisor principal executa parte da orquestração de forma implícita.

A evolução arquitetural deverá mover essa responsabilidade para Application Services dedicados.

Não haverá refatoração retroativa.

---

# Rastreabilidade

ARCH-001

SPEC-001

SPEC-002

SPEC-003

DOMAIN-003

DOMAIN-004

DOMAIN-005
