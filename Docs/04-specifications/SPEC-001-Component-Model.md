---
id: SPEC-001
title: Component Model
version: 1.4.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
related:
  - SPEC-002
  - SPEC-003
  - SPEC-004
last_updated: 2026-07-21
---

# Component Model

## Objetivo

Definir os componentes oficiais do TradingOS, suas responsabilidades, contratos e dependências.

Este documento representa a transição entre arquitetura e implementação.

Nenhum componente poderá ser criado fora deste modelo sem aprovação através de ADR.

---

# Canonical Component Catalog

Este documento é a fonte oficial de nomenclatura arquitetural do TradingOS.

Todos os documentos futuros deverão reutilizar exatamente os nomes definidos aqui.

Nenhum novo componente poderá ser criado em outros documentos sem atualização prévia deste catálogo.

Este documento define:

- componentes;
- builders;
- providers;
- services;
- policies;
- adapters.

---

# Canonical Repository

SPEC-001 é a única fonte oficial para:

Componentes

Builders

Services

Policies

Providers

Adapters

Nenhum outro documento poderá definir novos componentes.

---

# Organização

O sistema é dividido nos seguintes grupos (Canonical Component Catalog):

- Core Domain Builders
- Core Domain Services
- Domain Policies
- Application Services
- Infrastructure Providers
- Execution Components

---

# Core Domain Builders

## Evidence Builder

Responsabilidade:

Construir objetos Evidence a partir de dados provenientes da infraestrutura.

---

## Market Context Builder

Responsabilidade:

Construir o Aggregate Root Market Context.

---

# Core Domain Services

## Opportunity Service

Responsabilidade:

Avaliar um Market Context e produzir uma Opportunity.

---

## Decision Service

Responsabilidade:

Avaliar uma Opportunity e produzir uma Decision.

---

## Confidence Service

Responsabilidade:

Calcular o grau de confiança do domínio.

---

## Risk Service

Responsabilidade:

Avaliar o risco da Opportunity.

---

# Domain Policies

## Context Validation Policy

Responsabilidade:

Validar invariantes do Market Context.

---

## Evidence Validation Policy

Responsabilidade:

Validar consistência das Evidence.

---

# Application Services

Orquestram o fluxo da aplicação, coordenando Builders, Domain Services e Policies. Não implementam regras de negócio, não calculam indicadores, não executam ordens. Definidos em detalhe no SPEC-004.

## Analyze Market Use Case

Responsabilidade:

Executar um ciclo completo de análise do mercado (Data Provider → Evidence Builder → Market Context Builder → Opportunity Service → Decision Service → Decision).

---

## Validate Context Use Case

Responsabilidade:

Construir e validar um Market Context (Evidence Builder → Market Context Builder → Context Validation Policy).

---

## Evaluate Opportunity Use Case

Responsabilidade:

Avaliar uma Opportunity para um Market Context válido.

---

## Generate Decision Use Case

Responsabilidade:

Produzir uma Decision para uma Opportunity (Confidence Service → Risk Service → Decision Service).

---

## Publish Signal Use Case

Responsabilidade:

Entregar uma Decision ao contexto de Execution via Signal Builder. Encerra a responsabilidade do Application Service.

---

# Infrastructure Providers

Data Provider

Indicator Provider

Configuration Provider

Time Provider

Persistence Provider

Logger

---

# Execution Components

Signal Builder

Order Manager

Position Manager

Broker Adapter

MT5 Adapter

---

# Contratos

Cada componente deverá expor:

- Interface pública;
- Responsabilidades;
- Dependências;
- Eventos produzidos;
- Eventos consumidos.

Nenhum componente poderá acessar componentes fora das dependências permitidas pelo ARCH-001.

---

# Dependências

Infrastructure

↓

Strategy

↓

Core Domain

Execution

↓

Core Domain

---

# Componentes Legacy

Os seguintes componentes da versão atual permanecem válidos:

TrendService

ATRService

ADXService

RSIService

SessionService

PivotService

TradingSignal

SignalBuilderService

Config

Logger

A migração será incremental.

---

# Extensibilidade

Novos componentes poderão ser adicionados desde que:

- respeitem o modelo arquitetural;
- possuam interface definida;
- sejam registrados neste documento;
- mantenham rastreabilidade.

---

# Component Lifecycle

Classificação de cada componente listado neste documento frente ao estado real do código (V1 / Legacy Baseline), para criar um elo claro entre a documentação e a implementação.

Estados possíveis: **Implemented** (existe na Legacy Baseline, ainda que informalmente), **Planned** (modelado, não implementado), **Deprecated** (mantido só por compatibilidade), **Future** (previsto, sem modelo concreto ainda).

## Core Domain Builders

| Componente | Status | Observação |
|---|---|---|
| Evidence Builder | Implemented | Informal — `TrendService`, `ATRService`, `RSIService`, `ADXService`, `SessionService`, `PivotService` produzem informação equivalente, sem a estrutura formal de DOMAIN-003 (sem `EvidenceId`/`Category`/`Weight`). |
| Market Context Builder | Implemented | `struct MarketContext` cumpre o papel hoje — mutável, campos públicos, sem coleção formal de Evidence (diferente da Aggregate Root imutável de DOMAIN-004). |

## Core Domain Services

| Componente | Status | Observação |
|---|---|---|
| Opportunity Service | Implemented | Informal — `MarketAssessmentService` aplica pesos (0.5/0.3/0.2 por timeframe) e regras (thresholds ±20) sobre Evidence, aproximando o papel de Opportunity Service, sem produzir um `Opportunity` formal (DOMAIN-001). |
| Decision Service | Implemented | Informal — `SignalBuilderService` cumpre o papel — sem `DecisionId`/`OpportunityId`/`ContextId` formais (DOMAIN-005). |
| Confidence Service | Implemented | Informal — embutido dentro de `MarketAssessmentService` (`ConfidenceScore`/`ConfidenceLevel`), não é um componente isolado. |
| Risk Service | Planned | Modelado aqui; nenhuma avaliação de risco existe no código (REQ-009 não atendido, ver TRACEABILITY.md). |

## Domain Policies

| Componente | Status | Observação |
|---|---|---|
| Context Validation Policy | Planned | Modelado aqui; hoje não há validação explícita de invariantes do `MarketContext` além do `Clear()`. |
| Evidence Validation Policy | Planned | Modelado aqui; nenhuma validação formal de consistência entre evidências existe hoje. |

## Application Services

| Componente | Status | Observação |
|---|---|---|
| Analyze Market Use Case | Planned | Modelado em SPEC-004; hoje `TradingOS.mq5` orquestra parte desse fluxo de forma implícita (`OnTimer()` chama `Market.Update()` → `SignalBuilder.Build()`), sem um Application Service dedicado. |
| Validate Context Use Case | Planned | Nenhuma validação explícita de contexto existe hoje (depende de Context Validation Policy, também Planned). |
| Evaluate Opportunity Use Case | Planned | Aproximado informalmente pela chamada a `MarketAssessmentService` dentro de `MarketService.Update()`, sem separação como Application Service. |
| Generate Decision Use Case | Planned | Aproximado informalmente pela chamada a `SignalBuilder.Build()` em `TradingOS.mq5`, sem separação como Application Service. |
| Publish Signal Use Case | Planned | Hoje o `TradingSignal` resultante é consumido diretamente pelo `Dashboard`, sem uma etapa dedicada de publicação para Execution. |

## Infrastructure Providers

| Componente | Status | Observação |
|---|---|---|
| Data Provider | Implemented | Informal — chamadas diretas (`iHigh`/`iLow`/`iClose`) embutidas em `MarketService`, sem componente isolado. |
| Indicator Provider | Implemented | Informal — cada serviço (`TrendService`, `ATRService` etc.) chama `iMA`/`iRSI`/`iATR`/`iADX` diretamente, sem abstração separada. |
| Configuration Provider | Implemented | `CConfig` (`Config.mqh`). |
| Time Provider | Future | Chamadas diretas a `TimeCurrent()`/`PeriodSeconds()` onde necessário; sem abstração. |
| Persistence Provider | Future | Nenhuma necessidade identificada até agora; sem modelo concreto. |
| Logger | Implemented | `CLogger` (`Logger.mqh`). |

## Execution Components

| Componente | Status | Observação |
|---|---|---|
| Signal Builder | Implemented | `CSignalBuilderService` (Sprint 6.4). |
| Order Manager | Future | Não implementado — fora de escopo até agora (ver Docs/BACKLOG.md, roadmap de Risk/Trade Manager). |
| Position Manager | Future | Não implementado. |
| Broker Adapter | Future | Não implementado. |
| MT5 Adapter | Planned | Modelado em ARCH-001 como camada obrigatória de Infrastructure; hoje o acesso ao MT5 está disperso diretamente em cada serviço, sem adapter isolado — é justamente a dependência proibida que ARCH-001 aponta como violada pela Legacy Baseline. |

## Deprecated

Nenhum componente listado neste documento se enquadra nesta categoria hoje. Os módulos órfãos congelados pela Sprint 0.5 (`TrendAnalyzer`, `IAnalyzer`, `MarketSnapshot`, `MarketAnalysis`) nunca fizeram parte deste modelo — seu status é tratado em `Docs/BACKLOG.md` e `ADR-001`, não aqui.

---

# Rastreabilidade

ARCH-001

SPEC-004

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
