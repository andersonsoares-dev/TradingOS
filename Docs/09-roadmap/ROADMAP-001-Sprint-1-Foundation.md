---
id: ROADMAP-001
title: Sprint 1 — Foundation (Release 1.0)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-009
  - RFC-006
  - RFC-007
  - EXEC-001
  - EXEC-002
  - EXEC-003
  - EXEC-004
  - EXEC-005
last_updated: 2026-07-21
---

# Sprint 1 — Foundation (Release 1.0)

Primeiro documento da família `ROADMAP-*` (`ADR-009`). Define o plano executivo da Sprint 1 — a etapa seguinte à sequência travada `EXEC-001` a `EXEC-005`, conforme `ADR-009`. Este documento **não cria arquitetura, não altera contratos, não altera componentes** — define apenas a sequência de implementação.

**Nota de família/pasta**: solicitado originalmente como `Docs/07-implementation/IMPLEMENTATION-001-Sprint-1.md`. `Docs/07-implementation/` não existe na árvore oficial travada por `ADR-009` (a posição `07` é `07-testing/`), e `IMPLEMENTATION-*` não está entre as famílias documentais congeladas. Criado como `ROADMAP-001`, em `Docs/09-roadmap/` — família já congelada, ainda sem uso até este documento.

---

## Contexto

A fase de arquitetura foi oficialmente encerrada. Architecture Baseline v1.1 (`ADR-009`) permanece congelada. Todos os componentes executáveis já possuem contrato definido:

- `EXEC-001` Order Manager;
- `EXEC-002` Position Manager;
- `EXEC-003` Risk Service (Pre-Order Risk Gate);
- `EXEC-004` Signal Builder;
- `EXEC-005` MT5 Adapter.

`RFC-006` e `RFC-007` foram aprovadas. A partir deste ponto inicia-se exclusivamente a implementação.

---

# Objetivos da Sprint

Ao final da Sprint 1, o TradingOS deverá:

- compilar;
- inicializar corretamente;
- carregar configurações;
- inicializar logging;
- registrar versão;
- inicializar Event Bus (caso previsto);
- permanecer em estado Idle.

Sem estratégia. Sem execução de ordens.

---

# Escopo

Implementar apenas infraestrutura comum:

- Bootstrap;
- Config;
- Logger;
- Common Types;
- Error Model;
- Event Model;
- Dependency Initialization;
- Lifecycle.

---

# Fora de Escopo

Não implementar nesta sprint:

- Signal Builder (`EXEC-004`);
- Risk Service (`EXEC-003`);
- Order Manager (`EXEC-001`);
- Position Manager (`EXEC-002`);
- MT5 Adapter (`EXEC-005`);
- estratégias;
- indicadores;
- execução.

Todos os cinco `EXEC-00X` permanecem apenas como contrato nesta sprint — nenhuma implementação de componente de negócio ou execução começa antes da Foundation estar concluída.

---

# Checklist de Implementação

- [ ] Estrutura de diretórios
- [ ] Configuração
- [ ] Logging
- [ ] Inicialização
- [ ] Tratamento de erros
- [ ] Shutdown
- [ ] Build
- [ ] Teste de inicialização

---

# Critérios de Aceitação

A Sprint será considerada concluída quando:

- Build = OK;
- zero erros;
- zero warnings;
- inicialização completa;
- encerramento limpo;
- logs produzidos corretamente.

Validação conforme pipeline já definido em `ADR-004` (mínimo: Static Analysis + Compilation via MetaEditor CLI).

---

# Rastreabilidade

- `ADR-009` (sequência travada, prioridade de Primeira Execução, critério de reabertura de discussão arquitetural).
- `RFC-006`/`RFC-007` (decisões que autorizam o escopo de implementação da Release 1.0).
- `EXEC-001` a `EXEC-005` (contratos que a Foundation desta sprint deverá suportar em sprints futuras, sem implementá-los agora).
- `ADR-004` (pipeline de validação aplicável ao Build/Teste de inicialização).

---

# Definition of Done

Esta sprint estará concluída quando o Expert Advisor compilar, inicializar, carregar configuração, registrar logs e versão, e permanecer em estado Idle, sem nenhuma dependência de `EXEC-001` a `EXEC-005` ainda não implementada.

---

# Próxima Sprint

A definir — Sprint 2 iniciará a implementação de um dos componentes `EXEC-00X`, conforme priorização do Product Owner, sempre respeitando a sequência travada em `ADR-009`.
