---
id: DOMAIN-003
title: Evidence
version: 2.1.0
status: Approved
owner: Product Owner
depends_on:
  - REQ-001
  - DOMAIN-002
  - ADR-011
related:
  - DOMAIN-004
  - DOMAIN-005
  - ARCH-001
last_updated: 2026-07-22
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
- Market Structure
- Volume
- Price Action
- Custom

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

## Estado

Um dos cinco estados do ciclo de vida da Evidence (ver "Ciclo de Vida"): `Candidate`, `Confirmed`, `Weak`, `Rejected`, `Expired`.

---

## Validade

Janela temporal após a qual a Evidence transita automaticamente para o estado `Expired`.

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

# Ciclo de Vida

Adicionado por `ADR-011`.

## Estados

Candidate

↓

Confirmed

↓

Weak

↓

Rejected

↓

Expired

---

### Candidate

Evidence recém-produzida por um Core Domain Builder (`Evidence Builder`), ainda não avaliada pela `Evidence Validation Policy`.

---

### Confirmed

Avaliada e aprovada pela `Evidence Validation Policy` — consistente, compõe um `Market Context` com seu `Weight` pleno.

---

### Weak

Avaliada e aprovada, porém com baixa confiança/consistência — compõe um `Market Context`, mas com influência reduzida (`Weight` rebaixado). Não é o mesmo que `Rejected`.

---

### Rejected

Falhou na avaliação da `Evidence Validation Policy` — nunca compõe um `Market Context`.

---

### Expired

Ultrapassou sua janela de validade (`Validade`) — deixa de ser elegível para novos `Market Context`, mas é preservada para auditoria.

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

## BR-006

Toda Evidence nasce em estado `Candidate` (adicionado por `ADR-011`).

---

## BR-007

Apenas Evidence em estado `Confirmed` ou `Weak` pode compor um Market Context; `Candidate`, `Rejected` e `Expired` não podem (adicionado por `ADR-011`).

---

## BR-008

A transição para `Expired` ocorre automaticamente quando `Validade` é ultrapassada, independentemente do estado anterior, exceto se já `Rejected` (adicionado por `ADR-011`).

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

ADR-011

ROADMAP-006

---

# Alterações

Novas categorias de Evidence poderão ser adicionadas sem alteração do modelo de domínio, desde que respeitem as regras definidas neste documento.

**v2.0.0** (`ADR-011`): adicionado o Ciclo de Vida (`Candidate → Confirmed → Weak → Rejected → Expired`), os atributos `Estado` e `Validade`, e as regras de negócio `BR-006` a `BR-008`. Origem: `ROADMAP-006` (Architecture Decision Backlog), itens `ITEM-05`/`ITEM-06`.

**v2.1.0** (`ROADMAP-006`): renomeada a categoria `Structure` para `Market Structure` e adicionadas as categorias `Price Action` e `Custom`, conforme `ITEM-01` e `ITEM-02`. Nenhuma regra estrutural ou responsabilidade de `Evidence` foi alterada.
