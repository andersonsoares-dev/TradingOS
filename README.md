# TradingOS

## Visão Geral

TradingOS é uma plataforma modular para MetaTrader 5 desenvolvida para auxiliar a tomada de decisão operacional através da análise do contexto do mercado.

O projeto foi concebido para evoluir de um simples painel de informações para um sistema completo composto por:

* Análise de tendência
* Análise de força do movimento
* Contexto do mercado
* Motor de decisão
* Gestão de risco
* Execução automática de ordens

---

# Objetivos

* Código limpo
* Arquitetura modular
* Fácil manutenção
* Fácil expansão
* Alto desempenho
* Baixo acoplamento entre módulos

---

# Arquitetura

```text
TradingOS

Experts
    TradingOS.mq5

Include

    Core
        Config.mqh
        Logger.mqh

    Models
        MarketContext.mqh

    Indicators
        TrendService.mqh
        ATRService.mqh
        RSIService.mqh
        ADXService.mqh
        PivotService.mqh

    Services
        SessionService.mqh
        SignalService.mqh

    Dashboard
        DashboardService.mqh

    Decision
        DecisionEngine.mqh

    Execution
        RiskManager.mqh
        TradeManager.mqh
```

---

# Fluxo de Dados

```text
Mercado

↓

Indicator Services

↓

MarketContext

↓

Decision Engine

↓

Trade Manager

↓

MetaTrader 5
```

Os indicadores nunca conversarão entre si.

Todos os serviços escrevem seus resultados apenas no MarketContext.

---

# Responsabilidade dos módulos

## Core

Responsável por configuração, logs e inicialização do sistema.

## Models

Representação dos dados do mercado.

Nenhuma regra de negócio deverá existir nesta camada.

## Indicators

Realizam todos os cálculos técnicos.

## Dashboard

Responsável apenas pela interface gráfica.

## Decision Engine

Transforma o contexto do mercado em uma recomendação operacional.

## Execution

Responsável pela abertura, gerenciamento e encerramento das operações.

---

# Roadmap

## Sprint 1

* Estrutura do projeto
* Config
* Logger
* MarketContext
* TrendService

## Sprint 2

* Dashboard gráfico
* ATR

## Sprint 3

* RSI
* ADX
* Market Score

## Sprint 4

* Session Service
* Pivot Service

## Sprint 5

* Decision Engine

## Sprint 6

* Risk Manager

## Sprint 7

* Trade Manager

## Sprint 8

* Backtesting

---

# Convenções

* Um serviço = uma responsabilidade.
* Nenhum número mágico no código.
* Todos os parâmetros ficam em Config.mqh.
* Toda alteração deve compilar antes do commit.
* Um commit por sprint concluída.

---

# Estado Atual

Versão: 0.1

Status:

* Estrutura criada
* Ambiente configurado
* Desenvolvimento em andamento
