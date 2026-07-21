---
id: DOMAIN-002
title: Ubiquitous Language
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - REQ-001
  - DOMAIN-001
related:
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
  - ARCH-001
last_updated: 2026-07-21
---

# Ubiquitous Language

## Objetivo

Definir o vocabulário oficial do domínio TradingOS.

Todos os documentos, código-fonte, testes e ADRs deverão utilizar estes termos de forma consistente.

Sinônimos deverão ser evitados.

---

# Conceitos Fundamentais

## Opportunity

Hipótese operacional identificada pelo domínio.

Não representa uma ordem.

Não representa uma posição.

---

## Market Context

Representação consolidada das condições atuais do mercado.

É produzido a partir da análise de múltiplas evidências.

---

## Evidence

Informação observável utilizada para apoiar uma decisão.

Uma evidência nunca decide isoladamente.

Exemplos:

- tendência
- volatilidade
- momentum
- força
- liquidez
- sessão
- estrutura

---

## Decision

Resultado produzido pelo domínio após avaliar uma Opportunity.

Valores possíveis:

- BUY
- SELL
- WAIT
- NO_TRADE

---

## Confidence

Indicador normalizado do grau de confiança da decisão.

Faixa:

0.0 → 1.0

---

## Risk Profile

Representação do risco associado à Opportunity.

---

## Strategy

Conjunto de regras utilizado para avaliar oportunidades.

A Strategy consome o domínio.

Ela não altera o domínio.

---

## Signal

Resultado operacional derivado de uma Decision.

Na Legacy Baseline corresponde ao TradingSignal.

No Target Architecture é consequência da Decision.

---

## Indicator

Componente técnico responsável por produzir evidências.

Nunca produz decisões.

---

## Adapter

Camada responsável pela comunicação com tecnologias externas.

Exemplos:

- MT5
- APIs
- Brokers
- Banco de Dados

---

## Domain Service

Serviço que implementa regras de negócio sem pertencer a uma entidade específica.

---

## Infrastructure Service

Serviço responsável por funcionalidades técnicas.

Não contém regras de negócio.

---

# Regras de Linguagem

Sempre utilizar:

Market Context

Nunca:

Market State

---

Sempre utilizar:

Opportunity

Nunca:

Trade

Entry

Operation

---

Sempre utilizar:

Evidence

Nunca:

Trigger

---

Decision

Resultado produzido pelo domínio.

---

Signal

Representação operacional derivada de uma Decision.

Signal pertence ao contexto de execução.

Não representa uma entidade do Core Domain.

---

Confirmation

Representa a validação de uma ou mais evidências.

Pode existir na infraestrutura e na camada de estratégia.

Não representa uma entidade do Core Domain.

---

Execution

Responsável por transformar um Signal em ordens na plataforma.

Não pertence ao domínio.

---

# Linguagem Oficial

O idioma oficial do código é inglês.

A documentação pode ser escrita em português.

Os nomes de classes, interfaces, métodos e objetos deverão utilizar exclusivamente os termos definidos neste documento.

---

# Rastreabilidade

REQ-002

REQ-003

REQ-004

REQ-005

REQ-008

---

# Alterações

Novos termos deverão ser adicionados somente após aprovação do Product Owner e, quando impactarem o modelo de domínio, registrados em ADR.

---

# Terminologia Arquitetural

Builders

Responsáveis pela construção de objetos do domínio.

Services

Executam regras de negócio.

Policies

Validam invariantes e regras específicas.

Providers

Obtêm dados externos.

Adapters

Integram plataformas externas.
