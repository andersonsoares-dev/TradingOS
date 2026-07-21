---
id: SPEC-002
title: Interface Contracts
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - SPEC-001
related:
  - SPEC-003
  - ARCH-001
last_updated: 2026-07-21
---

# Interface Contracts

## Objetivo

Definir os contratos públicos entre os componentes do TradingOS.

Os contratos garantem desacoplamento entre módulos, interoperabilidade entre implementações e estabilidade arquitetural.

Nenhuma implementação poderá depender de detalhes internos de outro componente.

A comunicação deverá ocorrer exclusivamente através das interfaces aqui definidas.

---

# Princípios

Interfaces definem comportamento.

Implementações definem tecnologia.

Toda dependência deverá ocorrer sobre abstrações.

Interfaces nunca dependerão de infraestrutura.

---

# Contrato: Data Provider

## Responsabilidade

Disponibilizar dados brutos de mercado.

## Entrada

Asset

Timeframe

Timestamp

## Saída

Market Data Snapshot

## Consumidores

Indicator Provider

Evidence Builder

---

# Contrato: Indicator Provider

## Responsabilidade

Produzir indicadores técnicos.

## Entrada

Market Data Snapshot

## Saída

Indicator Values

## Consumidores

Evidence Builder

---

# Contrato: Evidence Builder

## Responsabilidade

Converter dados técnicos em objetos Evidence.

## Entrada

Indicator Values

Market Data

## Saída

Evidence Collection

## Consumidores

Market Context Builder

---

# Contrato: Market Context Builder

## Responsabilidade

Construir um Market Context consistente.

## Entrada

Evidence Collection

## Saída

Market Context

## Consumidores

Opportunity Service

---

# Contrato: Opportunity Service

## Responsabilidade

Avaliar oportunidades.

## Entrada

Market Context

## Saída

Opportunity

## Consumidores

Decision Service

---

# Contrato: Decision Service

## Responsabilidade

Produzir Decision.

## Entrada

Opportunity

## Saída

Decision

## Consumidores

Signal Builder

---

# Contrato: Signal Builder

## Responsabilidade

Transformar Decision em Signal operacional.

## Entrada

Decision

## Saída

Signal

## Consumidores

Order Manager

---

# Contrato: Order Manager

## Responsabilidade

Converter Signal em ordens.

## Entrada

Signal

## Saída

Broker Order

---

# Regras Gerais

Toda interface deverá:

- possuir responsabilidade única;
- possuir entradas bem definidas;
- produzir saída determinística;
- ser independente de plataforma;
- ser testável isoladamente.

---

# Pré-condições

Cada componente deverá validar seus parâmetros antes do processamento.

Dados inválidos deverão ser rejeitados.

---

# Pós-condições

Cada componente deverá garantir consistência da saída produzida.

Nenhum componente poderá modificar objetos recebidos.

Objetos de domínio são imutáveis.

---

# Tratamento de Erros

Os contratos deverão:

- retornar erros explícitos;
- nunca ocultar falhas;
- preservar contexto para auditoria;
- evitar efeitos colaterais.

---

# Evolução

Novos contratos poderão ser adicionados.

Alterações incompatíveis exigem:

- novo ADR;
- atualização do ARCH-001;
- atualização do SPEC-001.

---

# Rastreabilidade

ARCH-001

SPEC-001

DOMAIN-003

DOMAIN-004

DOMAIN-005
