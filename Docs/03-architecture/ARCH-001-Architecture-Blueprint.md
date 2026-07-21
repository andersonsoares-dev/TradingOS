---
id: ARCH-001
title: Architecture Blueprint
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - CONST-001
  - REQ-001
  - DOMAIN-001
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
related:
  - SPEC-001
last_updated: 2026-07-21
---

# Architecture Blueprint

## Objetivo

Definir a arquitetura oficial do TradingOS.

Este documento estabelece os limites do domínio, as responsabilidades de cada camada, os Bounded Contexts e as dependências permitidas.

Toda implementação futura deverá respeitar esta arquitetura.

---

# Canonical Architecture

ARCH-001 é a única fonte oficial para:

Camadas

Fluxos

Dependências

Bounded Contexts

Nenhum documento poderá alterar a arquitetura sem aprovação via ADR.

---

# Princípios

A arquitetura é orientada pelo domínio.

O domínio não depende de plataforma.

O domínio não depende de indicadores.

O domínio não depende de MT5.

O domínio não depende de infraestrutura.

Infraestrutura depende do domínio.

Nunca o contrário.

---

# Arquitetura Geral

External Data

↓

Infrastructure

↓

Evidence Providers

↓

Core Domain

↓

Execution

↓

Trading Platform

---

# Core Domain

O Core Domain contém exclusivamente regras de negócio.

Componentes:

- Evidence
- Market Context
- Opportunity
- Decision

Nenhum componente do Core Domain poderá acessar:

- MT5
- APIs
- Banco de Dados
- Arquivos
- Rede

---

# Infrastructure

Responsável por integração.

Exemplos:

- MT5 Adapter
- Indicator Adapter
- Data Provider
- Logger
- Configuration
- Persistence

Infraestrutura produz informações para o domínio.

Nunca decisões.

---

# Strategy

A camada de Strategy interpreta o domínio.

Responsabilidades:

- definir pesos;
- combinar evidências;
- parametrizar regras;
- configurar thresholds;
- selecionar modelos.

A Strategy nunca executa ordens.

---

# Execution

Responsável por transformar uma Decision em ações operacionais.

Componentes típicos:

- Signal Builder
- Position Manager
- Order Manager
- Broker Adapter
- MT5 Adapter

Execution depende do domínio.

O domínio não conhece Execution.

---

# Fluxo Oficial

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

↓

Order

---

# Dependências Permitidas

Infrastructure

↓

Strategy

↓

Core Domain

Execution

↓

Core Domain

Core Domain

↓

Nenhuma camada inferior

---

# Dependências Proibidas

Core Domain → MT5

Core Domain → Broker

Core Domain → Logger

Core Domain → File System

Core Domain → Indicators

Core Domain → APIs

Core Domain → Network

---

# Bounded Contexts

## Core Domain

Responsável pelas regras de negócio.

---

## Infrastructure

Integrações externas.

---

## Strategy

Interpretação do mercado.

---

## Execution

Conversão de Decision em ações operacionais.

---

# Legacy Baseline

A implementação atual distribui responsabilidades entre diversos serviços.

Exemplos:

- TrendService
- RSIService
- ATRService
- ADXService
- PivotService
- SessionService
- TradingSignal
- SignalBuilderService

Conforme ADR-001 e ADR-002:

Não haverá refatoração retroativa.

A arquitetura alvo será aplicada apenas em novas evoluções.

---

# Qualidades Arquiteturais

A arquitetura deve garantir:

- baixo acoplamento;
- alta coesão;
- testabilidade;
- explicabilidade;
- extensibilidade;
- portabilidade;
- independência de plataforma.

---

# Restrições

Nenhum componente poderá violar as dependências estabelecidas neste documento.

Qualquer exceção deverá ser aprovada por novo ADR.

---

# Rastreabilidade

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

DOMAIN-001

DOMAIN-003

DOMAIN-004

DOMAIN-005
