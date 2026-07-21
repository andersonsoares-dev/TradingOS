---
id: ROADMAP-003
title: Sprint 3 — Signal Evaluation & Risk Validation (Release 1.0)
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-009
  - RFC-006
  - RFC-007
  - ROADMAP-001
  - ROADMAP-002
  - INFRA-002
  - INFRA-003
  - EXEC-003
  - EXEC-004
last_updated: 2026-07-21
---

# Sprint 3 — Signal Evaluation & Risk Validation (Release 1.0)

Terceiro documento da família `ROADMAP-*` (`ADR-009`). Define o plano executivo da Sprint 3. Este documento **não altera arquitetura, contratos ou componentes** — implementa `EXEC-003`/`EXEC-004` exatamente como já especificados e decididos em `RFC-007`.

## Validação Prévia — divergência de pipeline corrigida (não uma nova RFC)

O brief de origem descrevia o pipeline como `Signal Engine → Opportunity → Risk Service → Decision`. Isso **não corresponde** ao que `RFC-007` decidiu (Alternativa B: `Indicators → Decision → Risk Service → Order Manager`, sem estágio `Opportunity`, com `Risk Service` produzindo aprovação/rejeição — não uma `Decision`), nem ao que `EXEC-004` (saída: `SignalResult`) e `EXEC-003` (saída: `Risk Approved`/`Risk Rejected`/`Risk Warning`/`Risk Error`/`Risk Evaluation Result`) já especificam textualmente.

`Opportunity` e `Decision` são entidades do Core Domain (`DOMAIN-001`/`DOMAIN-005`, congeladas). Usá-las como nomes de saída de `EXEC-004`/`EXEC-003` reintroduziria o cruzamento de camada que `RFC-007` decidiu evitar para a Release 1.0 — sem nenhuma evidência de implementação/teste, que `ADR-009` §8 agora exige para reabrir essa decisão. Este documento **não abre uma nova RFC** (`RFC-007` já respondeu exatamente esta pergunta) — apenas usa os nomes já aprovados: `Signal Result` (saída de `EXEC-004`) e `Risk Approved`/`Risk Rejected`/`Risk Evaluation Result` (saída de `EXEC-003`).

**Nomenclatura**: "Signal Engine" do brief de origem corresponde a `EXEC-004` — **`Signal Builder`**, nome canônico já corrigido em `ADR-009`/`EXEC-004`.

---

## Status

Architecture Baseline: LOCKED (`ADR-009`). `RFC-006`: Approved. `RFC-007`: Approved. Nenhuma alteração arquitetural é permitida neste documento.

---

# Objetivo da Sprint

Implementar os componentes responsáveis por transformar dados de mercado em um resultado elegível para avaliação de risco e posterior execução. Esta sprint encerra a camada de avaliação de sinal e risco da Release 1.0. Nenhuma comunicação com MT5 é implementada nesta sprint.

---

# Escopo

Implementar exclusivamente:

- `EXEC-004` Signal Builder;
- `EXEC-003` Risk Service (Pre-Order Risk Gate).

Utilizando os contratos já aprovados — sem alterá-los.

---

# Dependências

- `ROADMAP-001` concluído;
- `ROADMAP-002` concluído;
- `INFRA-002` (Data Provider);
- `INFRA-003` (Indicator Provider);
- `EXEC-003` (Risk Service);
- `EXEC-004` (Signal Builder);
- `RFC-006`, `RFC-007` (decisões que autorizam este escopo).

---

# Objetivos da Sprint (fluxo)

Ao término desta sprint, o TradingOS deverá ser capaz de:

```
Market Snapshot
↓
Indicator Snapshot
↓
Signal Builder (EXEC-004)
↓
Signal Result (BUY / SELL / NO_SIGNAL)
↓
Risk Service (EXEC-003)
↓
Risk Approved / Risk Rejected / Risk Warning / Risk Error
```

Sem qualquer comunicação com MT5.

---

# Signal Builder (EXEC-004)

Implementar:

- [ ] Inicialização
- [ ] Pipeline de avaliação
- [ ] Rule Evaluation
- [ ] Filter Evaluation
- [ ] Conflict Resolution
- [ ] Signal Decision
- [ ] Signal Result
- [ ] Logging

---

# Risk Service (EXEC-003)

Implementar:

- [ ] Recebimento do Signal Result
- [ ] Avaliação de risco
- [ ] Aplicação dos limites
- [ ] Aprovação
- [ ] Rejeição
- [ ] Justificativa
- [ ] Risk Evaluation Result
- [ ] Logging

---

# Pipeline

Fluxo implementado exatamente conforme a Alternativa B aprovada em `RFC-007`:

```
Market Snapshot
↓
Indicator Snapshot
↓
Signal Builder
↓
Signal Result
↓
Risk Service
↓
Risk Approved / Risk Rejected
```

Nenhum outro fluxo é permitido nesta sprint.

---

# Validações

- [ ] Signal Result válido
- [ ] Signal Result rejeitado (NO_SIGNAL)
- [ ] Dados insuficientes
- [ ] Indicadores inválidos
- [ ] Regras conflitantes
- [ ] Limite diário
- [ ] Limite por operação
- [ ] Limite de exposição
- [ ] Configuração inválida

---

# Testes

- BUY válido;
- SELL válido;
- NO_SIGNAL;
- Signal Result rejeitado por filtro;
- Risk Rejected;
- Risk Approved;
- Risk Evaluation Result gerado;
- reprodutibilidade dos resultados.

---

# Critérios de Aceitação

A Sprint será considerada concluída quando:

- `Signal Builder` produzir `Signal Result` consistente;
- `Risk Service` produzir `Risk Evaluation Result` consistente;
- mesmo conjunto de entradas produzir sempre o mesmo resultado;
- nenhum componente possuir efeitos colaterais;
- build permanecer sem erros;
- zero warnings.

---

# Fora de Escopo

Não implementar nesta sprint:

- `EXEC-001` Order Manager;
- `EXEC-002` Position Manager;
- `EXEC-005` MT5 Adapter;
- envio de ordens;
- integração MT5;
- execução.

---

# Riscos

Riscos de implementação apenas — nenhuma alteração arquitetural proposta. Melhorias identificadas são registradas para Release 2.0, não aplicadas agora.

| Risco | Impacto | Mitigação |
|---|---|---|
| Divergência de terminologia entre briefs de sprint e contratos já aprovados (como a corrigida na Validação Prévia) se repetir em sprints futuras | Risco de implementar um pipeline diferente do decidido em RFC-007 | Toda sprint futura deve validar seu pipeline contra `EXEC-00X`/`RFC-007` antes de iniciar implementação, não apenas contra o brief recebido |
| `Conflict Resolution` (Signal Builder) e `Aplicação dos limites` (Risk Service) sem critério numérico definido ainda | Comportamento não determinístico se implementado sem regra explícita | Definir os critérios de desempate/limite como configuração explícita (`Configuration Provider`) antes de codificar, não deixar implícito no código |
| Ausência de dados de referência (valores esperados) para validar `Signal Result`/`Risk Evaluation Result` de forma determinística | Testes de aceitação sem oráculo confiável | Reaproveitar os mesmos dados/expectativas já usados na V1 Legacy (RC1, `Docs/BACKLOG.md`) como primeira referência de comparação |

---

# Rastreabilidade

- `ADR-009` (sequência de roadmap, critério de reabertura de discussão arquitetural).
- `RFC-006`/`RFC-007` (decisões que definem o pipeline e o papel do Risk Service, implementados aqui sem alteração).
- `EXEC-003`/`EXEC-004` (contratos implementados nesta sprint).
- `ROADMAP-001`/`ROADMAP-002` (pré-requisitos).
- `ADR-004` (pipeline de validação aplicável).

---

# Definition of Done

Esta sprint estará concluída quando `Signal Builder` e `Risk Service` estiverem implementados conforme `EXEC-004`/`EXEC-003`, produzindo `Signal Result` e `Risk Evaluation Result` consistentes e determinísticos, sem nenhuma comunicação com MT5.

---

# Próxima Sprint

`ROADMAP-004` — Order Execution Integration, conforme sequência travada em `ADR-009`.
