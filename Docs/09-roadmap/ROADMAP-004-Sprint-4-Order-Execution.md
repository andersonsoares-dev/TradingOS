---
id: ROADMAP-004
title: Sprint 4 — Order Execution Integration (Release 1.0)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-009
  - RFC-006
  - RFC-007
  - ROADMAP-001
  - ROADMAP-002
  - ROADMAP-003
  - EXEC-001
  - EXEC-002
  - EXEC-005
last_updated: 2026-07-21
---

# Sprint 4 — Order Execution Integration (Release 1.0)

Quarto documento da família `ROADMAP-*` (`ADR-009`). Define o plano executivo da Sprint 4. Este documento **não altera arquitetura, contratos ou componentes** — implementa `EXEC-001`, `EXEC-002` e `EXEC-005` exatamente como já especificados.

## Validação Prévia — ajuste de terminologia (cosmético, não uma divergência de pipeline)

O brief de origem usa "Decision" como o gatilho recebido por `Order Manager` e "Execution Result" como saída de `MT5 Adapter`. Diferente da divergência encontrada em `ROADMAP-003` (que reintroduzia `Opportunity`/`Decision` como entidades de Core Domain cruzando para Execution), aqui o ajuste é apenas terminológico: `EXEC-001` já especifica textualmente suas entradas como **`Signal Result`, `Risk Result`, `Symbol Information`, `Configuration`** (não "Decision"), e `EXEC-005` já especifica sua saída como **`Order Response`** (não "Execution Result"). Este documento usa os termos exatos já aprovados, sem alterar nenhum contrato.

---

## Status

Architecture Baseline: LOCKED (`ADR-009`). `RFC-006`/`RFC-007`: Approved. `ROADMAP-001`/`ROADMAP-002`/`ROADMAP-003`: Completed (documentalmente — implementação ainda não iniciada em código). Nenhuma alteração arquitetural é permitida neste documento.

---

# Objetivo

Implementar a camada de execução da Release 1.0, integrando os componentes responsáveis por transformar um `Signal Result` aprovado pelo `Risk Service` em uma operação executada no MetaTrader 5. Esta sprint conclui a implementação funcional da cadeia operacional da Release 1.0.

---

# Escopo

Implementar exclusivamente:

- `EXEC-001` Order Manager;
- `EXEC-002` Position Manager;
- `EXEC-005` MT5 Adapter.

Utilizando os contratos já aprovados — sem alterá-los.

---

# Dependências

- `ROADMAP-001`, `ROADMAP-002`, `ROADMAP-003`;
- `EXEC-001`, `EXEC-002`, `EXEC-005`.

---

# Objetivos da Sprint (fluxo)

Ao término desta sprint, o TradingOS deverá ser capaz de:

```
Signal Result + Risk Result (Approved)
↓
Order Manager: criar Order Request
↓
Validar estado operacional
↓
Enviar ordem ao MT5 Adapter
↓
Receber Order Response
↓
Atualizar Position Manager
↓
Registrar eventos
```

---

# Order Manager (EXEC-001)

Implementar:

- [ ] Recebimento de `Signal Result`/`Risk Result` aprovado
- [ ] Criação de `Order Request`
- [ ] Validação operacional
- [ ] Coordenação da execução
- [ ] Tratamento de erros
- [ ] Logging

---

# MT5 Adapter (EXEC-005)

Implementar:

- [ ] Conversão de modelos internos
- [ ] Envio de ordens
- [ ] Recebimento de `Order Response`
- [ ] Conversão de respostas
- [ ] Tratamento de erros
- [ ] Reconexão
- [ ] Logging

---

# Position Manager (EXEC-002)

Implementar:

- [ ] Abertura de posição
- [ ] Atualização de posição
- [ ] Encerramento
- [ ] Consulta de posições
- [ ] Sincronização de estado
- [ ] Logging

---

# Pipeline

```
Signal Result + Risk Result (Approved)
↓
Order Manager
↓
MT5 Adapter
↓
Broker
↓
Order Response
↓
Position Manager
```

Nenhum outro fluxo é permitido nesta sprint.

---

# Validações

- [ ] Ordem enviada
- [ ] Ordem rejeitada
- [ ] Timeout
- [ ] Reconexão
- [ ] Erro da API
- [ ] Atualização de posição
- [ ] Estado consistente

---

# Testes

- ordem BUY;
- ordem SELL;
- rejeição;
- timeout;
- reconexão;
- atualização de posição;
- encerramento de posição;
- recuperação após falha.

---

# Critérios de Aceitação

A Sprint será considerada concluída quando:

- ordens forem enviadas corretamente;
- respostas forem processadas corretamente;
- `Position Manager` permanecer consistente;
- build permanecer sem erros;
- zero warnings.

---

# Fora de Escopo

Não implementar nesta sprint:

- novas estratégias;
- novos indicadores;
- gestão de portfólio;
- multiativo;
- otimizações.

---

# Riscos

Riscos técnicos de integração apenas — nenhuma alteração arquitetural proposta. Melhorias identificadas são registradas para Release 2.0.

| Risco | Impacto | Mitigação |
|---|---|---|
| Comportamento do Strategy Tester/terminal MT5 ao simular reconexão e timeout pode diferir do ambiente real (demo/produção) | Testes de reconexão podem não cobrir todos os cenários reais de falha de rede/broker | Testar também em conta demo real (não só Strategy Tester) antes de considerar `MT5 Adapter` validado |
| Sincronização de estado do `Position Manager` após reinicialização do terminal | Divergência entre posições reais no broker e estado interno após um restart | Implementar reconstrução de estado a partir de `GetPositions()`/`GetOrders()` (`EXEC-005`) na inicialização, conforme já previsto no critério de aceitação de `EXEC-002` ("permitir reconstrução após reinicialização") |
| Códigos de erro específicos do broker/corretora não mapeados para o vocabulário interno (`Order Response`/`Execution Error`) | Tratamento de erro incompleto para casos não previstos nos testes desta sprint | Registrar (via `Logger`) qualquer código de erro do MT5 não reconhecido, para tratamento incremental, sem bloquear o fluxo dos casos já cobertos |

---

# Rastreabilidade

- `ADR-009` (sequência de roadmap, critério de reabertura de discussão arquitetural).
- `RFC-006`/`RFC-007` (decisões que autorizam este escopo de execução).
- `EXEC-001`/`EXEC-002`/`EXEC-005` (contratos implementados nesta sprint).
- `ROADMAP-001`/`ROADMAP-002`/`ROADMAP-003` (pré-requisitos).
- `ADR-004` (pipeline de validação aplicável).

---

# Definition of Done

Esta sprint estará concluída quando `Order Manager`, `MT5 Adapter` e `Position Manager` estiverem implementados conforme `EXEC-001`/`EXEC-005`/`EXEC-002`, processando o ciclo completo de envio de ordem e atualização de posição de forma consistente.

---

# Próxima Sprint

`ROADMAP-005` — First Execution & End-to-End Validation, conforme sequência travada em `ADR-009`.
