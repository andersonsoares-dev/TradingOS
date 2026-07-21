---
id: DOMAIN-003
title: Evidence
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - REQ-001
  - DOMAIN-002
related:
  - DOMAIN-004
  - DOMAIN-005
  - ARCH-001
last_updated: 2026-07-21
---

# Evidence

## Objetivo

Definir o conceito de Evidence no domínio do TradingOS.

Evidence representa qualquer informação observável capaz de contribuir para a avaliação de uma Opportunity.

Uma Evidence nunca toma decisões.

Ela apenas fornece informações ao domínio.

---

# Definição

Uma Evidence é um objeto de domínio imutável que representa uma observação do mercado.

Pode ser produzida por:

- indicadores;
- análise estrutural;
- contexto temporal;
- comportamento do preço;
- liquidez;
- volume;
- volatilidade;
- componentes futuros.

---

# Responsabilidades

Uma Evidence deve:

- representar um único fato observado;
- possuir origem conhecida;
- possuir valor mensurável;
- informar seu grau de confiabilidade;
- poder ser reutilizada em diferentes estratégias.

---

# Não Responsabilidades

Evidence NÃO deverá:

- decidir operações;
- gerar ordens;
- acessar APIs;
- acessar MT5;
- executar cálculos diretamente.

Essas responsabilidades pertencem à infraestrutura.

---

# Estrutura

Cada Evidence deverá possuir:

## Identity

EvidenceId

---

## Category

Exemplos:

- Trend
- Momentum
- Volatility
- Strength
- Liquidity
- Session
- Structure
- Volume

---

## Source

Origem da informação.

Exemplos:

EMA

RSI

ATR

ADX

Price Action

Volume

News (futuro)

---

## Value

Valor observado.

Pode ser:

- numérico;
- categórico;
- booleano;
- enumerado.

---

## Confidence

Grau de confiança da própria Evidence.

Faixa:

0.0 → 1.0

---

## Weight

Peso relativo utilizado pela Strategy.

A Strategy pode interpretar pesos de maneira diferente.

---

## Timestamp

Momento da observação.

---

## Metadata

Informações adicionais específicas da origem.

---

# Classificação

Evidence pode ser:

## Primary

Obtida diretamente da fonte.

Exemplo:

EMA 20 > EMA 50

---

## Derived

Obtida pela combinação de outras evidências.

Exemplo:

Strong Bullish Trend

---

## Composite

Resultado da agregação de múltiplas evidências.

Exemplo:

Momentum Confirmation

---

# Regras de Negócio

## BR-001

Toda Evidence deve possuir origem identificável.

---

## BR-002

Toda Evidence deve possuir Timestamp.

---

## BR-003

Toda Evidence deve possuir categoria.

---

## BR-004

Evidence não possui direção operacional.

Ela apenas descreve uma observação.

---

## BR-005

Evidence não pode produzir Decision.

---

# Invariantes

Nunca poderá existir uma Evidence sem:

- categoria;
- origem;
- valor;
- timestamp.

---

# Relacionamentos

Indicators

↓

Evidence

↓

Market Context

↓

Opportunity

---

# Legacy Baseline

Na V1, diversos serviços produzem informações equivalentes a Evidence.

Exemplos:

TrendService

ATRService

RSIService

ADXService

SessionService

PivotService

Esses componentes permanecem válidos conforme ADR-001.

A migração para o modelo de domínio ocorrerá apenas durante futuras evoluções arquiteturais.

---

# Rastreabilidade

REQ-003

REQ-004

REQ-010

---

# Alterações

Novas categorias de Evidence poderão ser adicionadas sem alteração do modelo de domínio, desde que respeitem as regras definidas neste documento.
