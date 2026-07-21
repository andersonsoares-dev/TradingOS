---
id: ROADMAP-005
title: Sprint 5 — First Execution & End-to-End Validation (Release 1.0)
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
  - ROADMAP-004
  - INFRA-002
  - INFRA-003
  - EXEC-001
  - EXEC-002
  - EXEC-003
  - EXEC-004
  - EXEC-005
last_updated: 2026-07-21
---

# Sprint 5 — First Execution & End-to-End Validation (Release 1.0)

Quinto documento da família `ROADMAP-*` (`ADR-009`). Esta sprint **não implementa novos componentes** — valida que a arquitetura especificada nas Sprints 1 a 4 produz um sistema funcional, ponta a ponta.

## Validação Prévia — mesma divergência de pipeline do ROADMAP-003, corrigida (não uma nova RFC)

O brief de origem novamente descreve o pipeline usando `Opportunity` e `Decision` (`Market Data → Indicator Snapshot → Opportunity → Decision → Order Request → ... → Execution Result → ...`). É a mesma divergência já identificada e corrigida em `ROADMAP-003`: `RFC-007` (Alternativa B) não inclui um estágio `Opportunity`, e os contratos reais são `EXEC-004` → `Signal Result`, `EXEC-003` → `Risk Approved`/`Risk Rejected`, `EXEC-005` → `Order Response` (não "Execution Result"). `Opportunity`/`Decision` continuam sendo entidades do Core Domain (`DOMAIN-001`/`DOMAIN-005`, congeladas), fora do pipeline decidido para a Release 1.0.

Este documento usa novamente os nomes já aprovados. Nenhuma RFC nova é aberta — `RFC-007` já resolveu esta questão, e não há evidência de implementação/teste que justifique reabri-la (`ADR-009` §8).

---

## Status

Architecture Baseline: LOCKED (`ADR-009`). `RFC-006`/`RFC-007`: Approved. `ROADMAP-001` a `ROADMAP-004`: Completed (documentalmente). Nenhuma alteração arquitetural é permitida neste documento.

---

# Objetivo

Executar pela primeira vez o pipeline completo do TradingOS, utilizando todos os componentes implementados nas Sprints 1 a 4, e validar sua operação ponta a ponta. Esta sprint não implementa novos componentes — seu propósito é validar que a arquitetura especificada produz um sistema funcional.

---

# Escopo

Executar de forma integrada:

- `INFRA-002` Data Provider;
- `INFRA-003` Indicator Provider;
- `EXEC-004` Signal Builder;
- `EXEC-003` Risk Service;
- `EXEC-001` Order Manager;
- `EXEC-005` MT5 Adapter;
- `EXEC-002` Position Manager.

---

# Objetivos da Sprint (pipeline)

```
Market Data (Data Provider)
↓
Indicator Snapshot (Indicator Provider)
↓
Signal Result (Signal Builder)
↓
Risk Approved / Risk Rejected (Risk Service)
↓
Order Request (Order Manager)
↓
MT5 Adapter
↓
Broker
↓
Order Response
↓
Position Manager
↓
Logs
```

---

# Validações Funcionais

- [ ] Inicialização completa
- [ ] Recebimento de dados
- [ ] Atualização de indicadores
- [ ] Geração de Signal Result
- [ ] Avaliação de risco
- [ ] Aprovação de risco (Risk Approved)
- [ ] Geração da Order
- [ ] Comunicação com MT5
- [ ] Atualização da posição
- [ ] Encerramento correto

---

# Validações Técnicas

- [ ] Build sem erros
- [ ] Zero warnings
- [ ] Sem exceções não tratadas
- [ ] Sem deadlocks
- [ ] Sem perda de estado
- [ ] Logs completos
- [ ] Consistência entre componentes

---

# Testes End-to-End

- inicialização;
- mercado aberto;
- mercado fechado;
- BUY completo;
- SELL completo;
- ordem rejeitada;
- timeout;
- reconexão;
- fechamento de posição;
- encerramento da aplicação.

---

# Evidências

Registrar:

- tempo de inicialização;
- tempo de processamento;
- tempo até geração do `Signal Result`;
- tempo até envio da ordem;
- tempo até confirmação;
- logs relevantes;
- erros encontrados.

Consolidar conforme convenção já definida em `DATA-001` (`validation-runs/Campaign-NNN/Test-NNN/...`), reaproveitada aqui para as evidências desta sprint.

---

# Critérios de Aceitação

A Sprint será considerada concluída quando:

- todo o pipeline executar sem intervenção manual;
- todos os componentes permanecerem consistentes;
- o ciclo completo puder ser reproduzido;
- nenhum erro arquitetural for identificado.

---

# Não é Objetivo

Não implementar nesta sprint:

- novas funcionalidades;
- refatorações;
- melhorias arquiteturais;
- novos componentes;
- otimizações.

Toda melhoria identificada é registrada para avaliação posterior (Release 2.0), conforme `ADR-009` §8.

---

# Resultados

Classificar o resultado da sprint em:

- **SUCCESS**;
- **PARTIAL SUCCESS**;
- **FAILED**.

Para cada falha, registrar: componente, causa, impacto, ação corretiva.

---

# Rastreabilidade

- `ADR-009` (sequência de roadmap, critério de reabertura de discussão arquitetural).
- `RFC-006`/`RFC-007` (decisões que definem o pipeline validado aqui).
- `INFRA-002`/`INFRA-003`, `EXEC-001` a `EXEC-005` (todos os componentes exercitados nesta sprint).
- `ROADMAP-001` a `ROADMAP-004` (pré-requisitos).
- `DATA-001` (convenção de evidências reaproveitada).
- `ADR-004` (pipeline de validação aplicável).

---

# Definition of Done

Esta sprint estará concluída quando o pipeline completo (`Data Provider → Indicator Provider → Signal Builder → Risk Service → Order Manager → MT5 Adapter → Position Manager`) executar de ponta a ponta, de forma reproduzível, com resultado classificado como `SUCCESS` ou `PARTIAL SUCCESS` com ações corretivas registradas.

---

# Marco

Após a conclusão desta sprint, a **Release 1.0 é considerada encerrada**.
