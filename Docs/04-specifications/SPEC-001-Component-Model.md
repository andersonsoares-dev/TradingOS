---
id: SPEC-001
title: Component Model
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
related:
  - SPEC-002
  - SPEC-003
last_updated: 2026-07-21
---

# Component Model

## Objetivo

Definir os componentes oficiais do TradingOS, suas responsabilidades, contratos e dependências.

Este documento representa a transição entre arquitetura e implementação.

Nenhum componente poderá ser criado fora deste modelo sem aprovação através de ADR.

---

# Organização

O sistema é dividido em quatro grandes grupos:

- Core Domain
- Strategy
- Infrastructure
- Execution

---

# Core Domain

## Opportunity

Responsabilidade:

Representar uma oportunidade identificada pelo domínio.

Entradas:

- Market Context

Saídas:

- Opportunity

---

## Evidence

Responsabilidade:

Representar fatos observados.

Entradas:

- Data Providers

Saídas:

- Evidence

---

## Market Context

Responsabilidade:

Consolidar múltiplas Evidence.

Entradas:

- Evidence

Saídas:

- Market Context

---

## Decision

Responsabilidade:

Representar a decisão produzida pelo domínio.

Entradas:

- Opportunity

Saídas:

- Decision

---

# Strategy

## Strategy Engine

Responsabilidade:

Interpretar Evidence.

Aplicar pesos.

Aplicar regras.

Gerar Opportunity.

---

## Confidence Evaluator

Responsabilidade:

Calcular Confidence.

---

## Risk Evaluator

Responsabilidade:

Avaliar risco.

Não executa gerenciamento de posição.

---

# Infrastructure

## Data Provider

Obtém dados do mercado.

---

## Indicator Provider

Calcula indicadores.

---

## Configuration Provider

Fornece parâmetros.

---

## Logger

Persistência de logs.

---

## Persistence

Armazenamento de dados.

---

## Time Provider

Fornece tempo padronizado.

---

# Execution

## Signal Builder

Converte Decision em Signal.

---

## Order Manager

Converte Signal em ordens.

---

## Position Manager

Gerencia posições abertas.

---

## Broker Adapter

Integra com corretoras.

---

## MT5 Adapter

Integra com MetaTrader.

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

## Core Domain

| Componente | Status | Observação |
|---|---|---|
| Opportunity | Planned | Modelado em DOMAIN-001; nenhum código implementa. `TradingSignal` cobre parte do papel, mas não é equivalente estrutural. |
| Evidence | Implemented | Informal — `TrendService`, `ATRService`, `RSIService`, `ADXService`, `SessionService`, `PivotService` produzem informação equivalente, sem a estrutura formal de DOMAIN-003 (sem `EvidenceId`/`Category`/`Weight`). |
| Market Context | Implemented | `struct MarketContext` cumpre o papel hoje — mutável, campos públicos, sem coleção formal de Evidence (diferente da Aggregate Root imutável de DOMAIN-004). |
| Decision | Implemented | `TradingSignal`/`ENUM_TRADING_SIGNAL`/`SignalBuilderService` cumprem o papel — sem `DecisionId`/`OpportunityId`/`ContextId` formais (DOMAIN-005). |

## Strategy

| Componente | Status | Observação |
|---|---|---|
| Strategy Engine | Implemented | Informal — `MarketAssessmentService` aplica pesos (0.5/0.3/0.2 por timeframe) e regras (thresholds ±20) sobre Evidence, sem existir como componente separado da camada Strategy. |
| Confidence Evaluator | Implemented | Informal — embutido dentro de `MarketAssessmentService` (`ConfidenceScore`/`ConfidenceLevel`), não é um componente isolado. |
| Risk Evaluator | Planned | Modelado aqui; nenhuma avaliação de risco existe no código (REQ-009 não atendido, ver TRACEABILITY.md). |

## Infrastructure

| Componente | Status | Observação |
|---|---|---|
| Data Provider | Implemented | Informal — chamadas diretas (`iHigh`/`iLow`/`iClose`) embutidas em `MarketService`, sem componente isolado. |
| Indicator Provider | Implemented | Informal — cada serviço (`TrendService`, `ATRService` etc.) chama `iMA`/`iRSI`/`iATR`/`iADX` diretamente, sem abstração separada. |
| Configuration Provider | Implemented | `CConfig` (`Config.mqh`). |
| Logger | Implemented | `CLogger` (`Logger.mqh`). |
| Persistence | Future | Nenhuma necessidade identificada até agora; sem modelo concreto. |
| Time Provider | Future | Chamadas diretas a `TimeCurrent()`/`PeriodSeconds()` onde necessário; sem abstração. |

## Execution

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
