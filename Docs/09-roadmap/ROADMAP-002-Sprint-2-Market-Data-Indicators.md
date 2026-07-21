---
id: ROADMAP-002
title: Sprint 2 — Market Data & Indicators (Release 1.0)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-009
  - ROADMAP-001
  - INFRA-002
  - INFRA-003
last_updated: 2026-07-21
---

# Sprint 2 — Market Data & Indicators (Release 1.0)

Segundo documento da família `ROADMAP-*` (`ADR-009`). Define o plano executivo da Sprint 2, sequência à `ROADMAP-001` (Sprint 1 — Foundation). Este documento **não altera contratos, não cria componentes** — implementa, usando os contratos já definidos em `INFRA-002`/`INFRA-003`, apenas a sequência de implementação.

**Nota de família/pasta**: solicitado originalmente como `Docs/07-implementation/IMPLEMENTATION-002-Sprint-2.md` — mesmo conflito com `ADR-009` já identificado e corrigido em `ROADMAP-001`. Criado como `ROADMAP-002`, em `Docs/09-roadmap/`.

---

## Contexto

Sprint 1 concluída (`ROADMAP-001`): Bootstrap operacional, configuração carregada, Logger funcional, Lifecycle implementado, build estável. Architecture Baseline permanece congelada.

---

# Objetivo

Implementar toda a infraestrutura necessária para obtenção dos dados de mercado e cálculo de indicadores técnicos utilizados pelo Signal Builder (`EXEC-004`). Nenhuma decisão operacional é tomada nesta sprint.

---

# Escopo

- `Data Provider`;
- `Indicator Provider`;
- Market Snapshot;
- Indicator Snapshot;
- cache de dados;
- atualização por Tick;
- atualização por Candle.

---

# Componentes

Implementados utilizando os contratos já definidos em:

- `INFRA-002` (Data Provider);
- `INFRA-003` (Indicator Provider).

Sem alterar os contratos.

---

# Funcionalidades

## Data Provider

- obter OHLC;
- Volume;
- Spread;
- Tick atual;
- Horário;
- Timeframe;
- Symbol Information.

## Indicator Provider

- receber Market Snapshot;
- calcular indicadores configurados;
- gerar Indicator Snapshot.

---

# Não Implementar

Não implementar nesta sprint:

- Signal Builder (`EXEC-004`);
- Risk Service (`EXEC-003`);
- Order Manager (`EXEC-001`);
- Position Manager (`EXEC-002`);
- execução;
- envio de ordens.

---

# Validações

- [ ] Dados recebidos corretamente
- [ ] Atualização por Tick
- [ ] Atualização por Candle
- [ ] Cache consistente
- [ ] Indicadores atualizados
- [ ] Sem vazamento de memória

---

# Testes

- inicialização;
- mudança de símbolo;
- mudança de timeframe;
- mercado fechado;
- mercado aberto;
- dados insuficientes;
- histórico incompleto.

---

# Critérios de Aceitação

A Sprint será considerada concluída quando:

- dados forem obtidos corretamente;
- Indicator Snapshot estiver consistente;
- atualização automática funcionar;
- build permanecer sem erros;
- logs registrarem todos os eventos críticos.

Validação conforme pipeline já definido em `ADR-004`.

---

# Rastreabilidade

- `ADR-009` (sequência de roadmap, prioridade de Primeira Execução).
- `ROADMAP-001` (Sprint 1 — Foundation, pré-requisito).
- `INFRA-002`/`INFRA-003` (contratos de Data Provider/Indicator Provider, não alterados).
- `ADR-004` (pipeline de validação aplicável).

---

# Definition of Done

Esta sprint estará concluída quando `Data Provider` e `Indicator Provider` estiverem implementados conforme `INFRA-002`/`INFRA-003`, produzindo `Market Snapshot`/`Indicator Snapshot` consistentes, com atualização por Tick e por Candle funcionando, sem dependência de `Signal Builder`, `Risk Service`, `Order Manager`, `Position Manager` ou execução.

---

# Próxima Sprint

`ROADMAP-003` — Sprint 3 (Signal Builder + Risk Service), conforme sequência travada em `ADR-009`.
