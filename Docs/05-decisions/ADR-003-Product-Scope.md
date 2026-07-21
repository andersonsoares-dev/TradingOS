---
id: ADR-003
title: Product Scope
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - CONST-001
  - VISION-001
related:
  - TRACEABILITY.md
last_updated: 2026-07-21
---

# ADR-003: Product Scope

## Status

Accepted

## Contexto

`CONST-001` e `VISION-001` declaram a missão do TradingOS como Swing Trading. A implementação atual (V1) é orientada a intraday (timeframes H4/H1/M15, `SessionService` bloqueando sinal fora de London/NY/Overlap, pivô diário). Isso gerou divergência entre a missão declarada e a configuração real do sistema.

## Decisão

- A implementação atual é orientada ao intraday.
- A visão estratégica continua permitindo Swing Trade.
- A Constituição deverá ser interpretada como: *"O TradingOS é uma plataforma de análise de oportunidades de mercado."*
- As estratégias passam a ser especializações do domínio: Swing, Position, Intraday, Scalping.
- O domínio permanece independente da estratégia escolhida.

## Consequências

- A configuração intraday atual deixa de ser tratada como violação da missão — passa a ser uma especialização válida dela.
- Futuras especializações (Swing, Position, Scalping) deverão ser implementadas como variações parametrizáveis sobre o mesmo domínio, não como sistemas separados.
- `CONST-001` e `VISION-001` permanecem válidos sem necessidade de alteração de texto, à luz desta interpretação.
