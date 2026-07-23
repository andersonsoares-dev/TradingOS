---
id: ROADMAP-006
title: Architecture Decision Backlog
version: 1.10.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-007
  - ADR-009
  - ADR-010
  - AUDIT-002
related:
  - DOMAIN-003
  - RFC-001
  - RFC-002
  - RFC-003
  - RFC-004
  - RFC-005
  - ADR-014
  - ADR-013
  - ADR-011
  - ADR-015
  - ADR-016
  - ADR-017
  - ADR-018
last_updated: 2026-07-22
---

# Architecture Decision Backlog

Backlog oficial de decisões arquiteturais do TradingOS. Registra, classifica, prioriza e rastreia evoluções arquiteturais identificadas durante revisões técnicas, antes que qualquer alteração seja incorporada à Baseline. **Este documento não toma decisões arquiteturais e não altera nenhum documento existente** — apenas organiza e controla decisões futuras.

**Nota de família/pasta**: solicitado originalmente como `ADB-001`. `ADB-*` não é família documental congelada por `ADR-009` (Governança/Arquitetura/Especificações/Validação/Roadmap). Um backlog de decisões pendentes é, por natureza, um artefato de planejamento — mesma família de `ROADMAP-00X`. Criado como `ROADMAP-006`, em `Docs/09-roadmap/`, dando continuidade à numeração já existente (`ROADMAP-001` a `005`).

**Nota de numeração interna**: o brief de origem nomeava os itens do backlog como `ADB-001` a `ADB-007` — mesmo id do documento. Renumerados como `ITEM-01` a `ITEM-07` para evitar colisão.

---

# Objetivo

Registrar, classificar, priorizar e rastrear todas as evoluções arquiteturais identificadas durante revisões técnicas, antes que qualquer alteração seja incorporada à Baseline.

---

# Escopo

Cobre propostas de evolução identificadas durante revisões técnicas (ex.: a análise de evolução do `DOMAIN-003` realizada nesta sessão; os achados de `AUDIT-002`) que ainda não foram formalizadas como ADR ou RFC aprovada, **e** RFCs abertas que ainda aguardam decisão — consolidadas aqui como itens de backlog para que este documento concentre toda pendência arquitetural, conforme recomendado por `AUDIT-002` (achado NC-01). RFCs/ADRs já resolvidos permanecem rastreados também em `DOCUMENT_INDEX.md`/`TRACEABILITY.md`, sem duplicar conteúdo técnico — este documento apenas referencia seu status.

---

# Critérios de Entrada

Uma proposta entra neste backlog quando:

- foi identificada durante uma revisão técnica (ex.: validação prévia de um novo documento, auditoria, discussão arquitetural);
- foi classificada em uma das 5 categorias (ver "Classificação");
- ainda não foi formalizada como ADR ou RFC aprovada.

---

# Critérios de Saída

Um item sai do backlog (estado `Archived`) quando:

- foi **implementado** — o ADR/RFC correspondente foi aprovado e o documento-alvo já reflete a mudança;
- foi **rejeitado** — decisão formal de não prosseguir, com justificativa registrada;
- tornou-se **obsoleto** — o contexto que o motivou deixou de existir.

---

# Processo de Decisão

```
Identificação
↓
Classificação
↓
Análise Técnica
↓
Decisão Arquitetural (quando necessária)
↓
Atualização da Baseline
↓
Implementação
```

---

# Fluxo de Governança

| Categoria | Quem decide | Pré-requisito para avançar |
|---|---|---|
| 1 — Correção documental | Product Owner, diretamente | Nenhum — aplicável a qualquer momento |
| 2 — Evolução compatível | Product Owner, diretamente | Confirmar que o documento-alvo já autoriza esse tipo de extensão (ex.: `DOMAIN-003` já autoriza novas categorias) |
| 3 — Evolução arquitetural | ADR ou RFC aprovada | Análise técnica completa; não avança sem decisão formal |
| 4 — Novo conceito | ADR/RFC definindo o Bounded Context primeiro | Mesma exigência já aplicada a `Knowledge` (`ADR-010`) |
| 5 — Conceito em avaliação | Nenhuma decisão ainda | Conclusão da análise conceitual antes de poder ser reclassificado em 1-4 |

---

# Critérios de Priorização

1. Itens que já bloqueiam trabalho em andamento (ex.: dependência de uma RFC aberta que outro componente já espera) têm prioridade mais alta.
2. Itens que tensionam fronteiras entre Bounded Contexts (Categoria 3/4) devem ser resolvidos antes de qualquer implementação relacionada começar.
3. Itens de baixo risco (Categoria 1/2) podem ser aplicados a qualquer momento, sem bloquear ou aguardar os demais.
4. Itens Categoria 5 têm prioridade de *análise*, não de decisão — o objetivo imediato é sair do estado "em avaliação", não resolver a questão de fundo ainda.

---

# Estados Possíveis

- **Proposed** — identificado, ainda não analisado tecnicamente;
- **Under Analysis** — em avaliação conceitual (tipicamente Categoria 5);
- **Awaiting ADR** — análise concluída, aguardando decisão formal via ADR;
- **Awaiting RFC** — análise concluída, aguardando RFC (geralmente por depender de outra RFC ainda aberta);
- **Approved** — decisão tomada, aguardando propagação aos documentos-alvo;
- **Rejected** — decisão formal de não prosseguir;
- **Implemented** — propagado aos documentos-alvo;
- **Archived** — encerrado (implementado, rejeitado ou obsoleto), mantido para histórico.

---

# Backlog Atual

`ITEM-01` a `ITEM-07` originam-se da análise de evolução do `DOMAIN-003` (Evidence). `ITEM-08` origina-se da resolução de `RFC-005`. `ITEM-09` a `ITEM-14` originam-se da consolidação de `AUDIT-002` (achado NC-01/NC-02/NC-03).

### ITEM-01 — Renomear "Structure" para "Market Structure"

Categoria: **1**. Status: **Implemented** — propagado para `DOMAIN-003` v2.1.0.

### ITEM-02 — Adicionar categorias "Price Action" e "Custom" a Evidence

Categoria: **2**. Status: **Implemented** — propagado para `DOMAIN-003` v2.1.0.

### ITEM-03 — Categoria "Risk" para Evidence

Categoria: **3 → 2** (rebaixada). Dependência: **`RFC-001`** — **resolvida**. Status: **Approved, pronta para aplicação direta**.

`RFC-001` resolvida por `ADR-015` (`Risk Profile` classificado como Value Object, `DOMAIN-007`), sem colidir com a categoria de `Evidence` proposta aqui (conceitos distintos: `Risk Profile` avalia a `Opportunity`; a categoria "Risk" de `Evidence` descreveria uma observação de mercado relacionada a risco). Item desbloqueado — passa a Categoria 2 (`DOMAIN-003` já autoriza novas categorias), sem exigir ADR próprio para ser aplicado. Ainda não propagado a `DOMAIN-003`.

### ITEM-04 — Categoria "Execution" para Evidence

Categoria: **3**. Status: **Awaiting ADR**.

### ITEM-05 — Ciclo de vida de Evidence (`Candidate → Confirmed → Weak → Rejected → Expired`)

Categoria: **3**. Status: **Implemented** — formalizado por `ADR-011`, propagado a `DOMAIN-003` (v2.0.0).

### ITEM-06 — Adicionar atributos "Estado" e "Validade" a Evidence

Categoria: **3**. Dependência: **ITEM-05**. Status: **Implemented** — formalizado por `ADR-011`, propagado a `DOMAIN-003` (v2.0.0).

### ITEM-07 — Conceito "Observation"

Categoria: **5**. Status: **Rejected**.

**Avaliação concluída**: `Observation` não é um conceito de domínio novo. É o nome informal para a saída já produzida por `Data Provider` (`INFRA-002`) e `Indicator Provider` (`INFRA-003`, modelo de resultado uniforme: Valor/Timestamp/Timeframe/Símbolo/Status/Origem/Qualidade), já consumida por `Evidence Builder` (`SPEC-001`) para construir `Evidence` (`DOMAIN-003`). Nenhuma responsabilidade nova foi identificada que não esteja coberta por componentes já especificados. Proposta de criar uma entidade formal `Observation` rejeitada — não introduz nada que `INFRA-002`/`INFRA-003`/`Evidence Builder` já não cubram.

---

### ITEM-08 — Trading Risk & Exit Strategy

Categoria: **3**. Dependência: **`RFC-005`**. Status: **Implemented** — formalizado por `ADR-013`.

Para a Release 1.0, foi aprovada a combinação de Stop baseado em ATR, Stop Temporal e Percentual por Risco. Break-even, Stop por Estrutura de Mercado e Trailing Stop permanecem postergados.

---

# Pendências Externas Consolidadas (AUDIT-002)

Itens abaixo originam-se do achado NC-01 de `AUDIT-002` (Baseline Architecture Certification): `ROADMAP-006` não concentrava as RFCs abertas nem os gaps de rastreamento identificados na certificação. Consolidados aqui **sem resolver nenhuma delas** — nenhuma RFC nova foi criada, nenhum conteúdo técnico das RFCs existentes foi alterado.

### ITEM-09 — RFC-001: Risk Profile Classification

Categoria: **3**. Dependência: **`RFC-001`**. Status: **Implemented** — resolvido por `ADR-015`. `RFC-001` passa a `Approved`; `DOMAIN-007-Risk-Profile.md` criado.

### ITEM-10 — RFC-002: Infrastructure Candidate Components

Categoria: **3**. Dependência: **`RFC-002`** — **resolvida**. Status: **Approved** — decisão de adiamento formalizada por `ADR-016`.

`Event Dispatcher` (Adiado — necessidade potencial, sem dependência bloqueante comprovada) e `Scheduler` (Adiado, viés para rejeição futura — necessidade já coberta por `OnTimer()`) permanecem **não catalogados** em `SPEC-001`, por decisão explícita — não por pendência. Critério de reabertura: evidência de implementação de `ROADMAP-001` ou sprints subsequentes (`ADR-009 §8`).

### ITEM-11 — RFC-003: Data Provider Candidate Adapters

Categoria: **3**. Dependência: **`RFC-003`** — **resolvida**. Status: **Approved** — decisão de adiamento formalizada por `ADR-017`.

`Replay Adapter`/`CSV Provider`/`CSV Adapter`/`Mock Provider`/`REST Adapter`/`FIX Adapter`/`WebSocket Adapter` (citados em `INFRA-002`) permanecem **não catalogados** em `SPEC-001`, por decisão explícita — não por pendência. `Replay Adapter`/`CSV Provider`: prioridade média-baixa para Release 2.0. `Mock Provider`/`FIX Adapter`: viés para rejeição futura. `REST Adapter`/`WebSocket Adapter`: nenhuma necessidade identificada. Critério de reabertura: evidência de implementação, provavelmente da Trilha de Validação/Learning Domain (`ADR-009 §8`).

### ITEM-12 — RFC-004: Legacy Indicator Mapping Ambiguity

Categoria: **3**. Dependência: **`RFC-004`** — **resolvida**. Status: **Implemented** — corrigido por `ADR-018`.

Divergência entre `SPEC-001` e `SPEC-003` quanto ao mapeamento de `TrendService`/`ATRService`/`RSIService`/`ADXService` resolvida por leitura direta do código: os quatro serviços mapeiam exclusivamente para `Indicator Provider` (`SPEC-001`, já correto, inalterado). `SPEC-003` corrigido (v1.1.0 → v1.2.0) — removida a correspondência incorreta com `Evidence Builder`.

### ITEM-13 — Gap de componentes do Bounded Context Strategy em SPEC-001

Categoria: **2**. Status: **Implemented** — `Strategy Policy` catalogado em `SPEC-001` v1.7.0.

`Strategy` foi confirmado como Bounded Context ativo em `RC-001` (Decisão A, ver `AUDIT-001-CLOSURE`), mas nenhum componente seu está catalogado no Canonical Component Catalog (`SPEC-001`) — gap recorrente, identificado em `AUDIT-001` (Finding #4) e reconfirmado por `AUDIT-002` (NC-02). `SPEC-001` já autoriza essa extensão diretamente (seção "Extensibilidade"), sem exigir ADR — decisão de Product Owner sobre quais componentes catalogar.

### ITEM-14 — Account Provider não catalogado em SPEC-001

Categoria: **3**. Dependência: **`RFC-006`**. Status: **Implemented** — resolvido por `ADR-014`.

Dependência citada em `EXEC-003`/`EXEC-005` e registrada em `RFC-006`. A decisão formal utiliza `EXEC-005.GetAccount()` como origem de `Account Snapshot`; nenhum `Account Provider` independente é catalogado em `SPEC-001`. Identificado por `AUDIT-002` (NC-03).

---

# Critérios para Encerramento

Um item é considerado encerrado (`Archived`) quando:

- implementado com sucesso na Baseline, com o documento-alvo atualizado e `TRACEABILITY.md` refletindo a mudança; ou
- rejeitado formalmente, com justificativa registrada neste backlog.

Nenhum item é removido do histórico — apenas transita para `Archived`, preservando rastreabilidade (mesmo princípio de retenção de `DOCUMENT_CONTROL`, Regra 10).

---

# Rastreabilidade

`ADR-007` (Baseline Freeze — motivo pelo qual itens Categoria 3+ exigem decisão formal) · `ADR-009` (Baseline Lock v1.1 — famílias documentais e critério de reabertura) · `ADR-010` (precedente de resolução de Bounded Context, aplicável a ITEM-04/ITEM-07) · `ADR-013` (resolve ITEM-08) · `ADR-015` (resolve ITEM-03/ITEM-09) · `ADR-016` (resolve ITEM-10, decisão de adiamento) · `ADR-017` (resolve ITEM-11, decisão de adiamento) · `ADR-018` (resolve ITEM-12, correção de mapeamento) · `DOMAIN-003` (origem de ITEM-01 a ITEM-07) · `DOMAIN-007` (formalizada por ITEM-09) · `AUDIT-002` (origem de ITEM-09 a ITEM-14, achado NC-01 a NC-03) · `RFC-001` (dependência de ITEM-03/ITEM-09, resolvida) · `RFC-002` (dependência de ITEM-10, resolvida) · `RFC-003` (dependência de ITEM-11, resolvida) · `RFC-004` (dependência de ITEM-12, resolvida) · `RFC-005` (dependência de ITEM-08, resolvida) · `RFC-006` (dependência de ITEM-14) · `AUDIT-001`/`AUDIT-001-CLOSURE` (origem histórica de ITEM-13).

---

# Resumo

- **Itens por categoria**: Categoria 1 — 1 item implementado (ITEM-01); Categoria 2 — 3 itens, sendo 2 implementados (ITEM-02, ITEM-13) e 1 pronto para aplicação direta (ITEM-03, rebaixado de Categoria 3); Categoria 3 — 9 itens, sendo 6 implementados (ITEM-05, ITEM-06, ITEM-08, ITEM-09, ITEM-12, ITEM-14), 2 aprovados com decisão de adiamento (ITEM-10, ITEM-11) e 1 ainda bloqueado (ITEM-04); Categoria 5 — 0 itens ativos (ITEM-07 avaliado e encerrado). Categoria 4 — 0 itens atualmente.
- **Bloqueados por decisão arquitetural** (Awaiting ADR/RFC): 1 (ITEM-04).
- **Prontos para execução documental direta** (Categoria 1/2, sem ADR/RFC): 1 (ITEM-03 — ainda não propagado a `DOMAIN-003`).
- **Implementados**: 9 (ITEM-01, ITEM-02 — propagados para `DOMAIN-003` v2.1.0; ITEM-05, ITEM-06 — formalizados por `ADR-011`; ITEM-08 — formalizado por `ADR-013`; ITEM-09 — formalizado por `ADR-015`, `DOMAIN-007` criado; ITEM-12 — corrigido por `ADR-018`, `SPEC-003` v1.2.0; ITEM-13 — `Strategy Policy` catalogado em `SPEC-001` v1.7.0; ITEM-14 — resolvido por `ADR-014`; todos propagados aos documentos-alvo).
- **Aprovados com decisão de adiamento** (sem propagação a `SPEC-001` por design): 2 (ITEM-10 — `Event Dispatcher`/`Scheduler`, `ADR-016`; ITEM-11 — 6 candidatos de Data Provider Adapters, `ADR-017`).
- **Encerrados/Rejeitados**: 1 (ITEM-07 — `Observation` avaliado e rejeitado como conceito de domínio novo).
- **RFCs abertas consolidadas nesta entrega** (`AUDIT-002`, NC-01): nenhuma — todas as 4 (`RFC-001` a `RFC-004`) resolvidas. `RFC-001` (ITEM-09) por `ADR-015`; `RFC-002` (ITEM-10) por `ADR-016` (adiamento); `RFC-003` (ITEM-11) por `ADR-017` (adiamento); `RFC-004` (ITEM-12) por `ADR-018` (correção).
- **Gaps de rastreamento consolidados nesta entrega** (`AUDIT-002`, NC-02/NC-03): gap de componentes de `Strategy` em `SPEC-001` (ITEM-13, resolvido); dependência `Account Provider` não catalogada (ITEM-14, resolvido).
- **Recomendação de priorização para as próximas revisões**: aplicar `ITEM-03` a qualquer momento (baixo risco, Categoria 2, dependência já resolvida). `ITEM-04` segue como `Awaiting ADR`, único item ainda bloqueado — próximo candidato natural. `ITEM-10`/`ITEM-11` só devem ser reabertos mediante evidência de implementação (`ADR-009 §8`).

---

# Alterações

**v1.2.0** (`ADR-013`): adicionado `ITEM-08` (Trading Risk & Exit Strategy), resolvendo `RFC-005`.

**v1.3.0** (`AUDIT-002`, achado NC-01/NC-02/NC-03): adicionados `ITEM-09` a `ITEM-14`, consolidando `RFC-001` a `RFC-004` (Open), o gap de componentes de `Strategy` em `SPEC-001` e a dependência `Account Provider` não catalogada. Nenhuma RFC nova criada; nenhum conteúdo técnico de RFC existente alterado; nenhuma das quatro RFCs (`RFC-001` a `RFC-004`) resolvida por esta entrega.

**v1.4.0** (`ITEM-01`/`ITEM-02`): renomeada `Structure` para `Market Structure` e adicionadas as categorias `Price Action` e `Custom` em `DOMAIN-003`. Ambos os itens passam a `Implemented`.

**v1.5.0** (`ITEM-13`): catalogado `Strategy Policy` em `SPEC-001` v1.7.0. `ITEM-13` passa a `Implemented`; nenhum componente adicional de Strategy foi criado.

**v1.6.0** (`ITEM-14`): formalizada por `ADR-014` a origem de `Account Information` em `EXEC-005.GetAccount()` → `Account Snapshot`. Nenhum `Account Provider` independente foi criado.

**v1.7.0** (`ITEM-09`/`ITEM-03`): `RFC-001` resolvida por `ADR-015` — `Risk Profile` classificado como Value Object, atributo `Risk` de `Opportunity` (`DOMAIN-007` criado). `ITEM-09` passa a `Implemented`. `ITEM-03` desbloqueado, rebaixado de Categoria 3 para Categoria 2 (dependência resolvida, sem colisão de conceito), pronto para aplicação direta — ainda não propagado a `DOMAIN-003`.

**v1.8.0** (`ITEM-10`): `RFC-002` resolvida por `ADR-016` — decisão de **adiamento** para `Event Dispatcher` e `Scheduler` (nenhum catalogado em `SPEC-001`, nenhum rejeitado definitivamente). `ITEM-10` passa de `Awaiting RFC` para `Approved`, sem propagação a `SPEC-001` por design. Critério de reabertura: evidência de implementação de `ROADMAP-001`/sprints subsequentes (`ADR-009 §8`).

**v1.9.0** (`ITEM-11`): `RFC-003` resolvida por `ADR-017` — decisão de **adiamento** para os 6 candidatos de Data Provider Adapters (`Replay Adapter`, `CSV Provider`/`CSV Adapter`, `Mock Provider`, `REST Adapter`, `FIX Adapter`, `WebSocket Adapter`), nenhum catalogado em `SPEC-001`, nenhum rejeitado definitivamente. `ITEM-11` passa de `Awaiting RFC` para `Approved`, sem propagação a `SPEC-001` por design. Critério de reabertura: evidência de implementação, provavelmente da Trilha de Validação/Learning Domain (`ADR-009 §8`).

**v1.10.0** (`ITEM-12`): `RFC-004` resolvida por `ADR-018` — correção factual, fundamentada em leitura direta do código (`MQL5/Include/TradingOS/Indicators/*.mqh`): `TrendService`/`ATRService`/`RSIService`/`ADXService` mapeiam exclusivamente para `Indicator Provider` (`SPEC-001`, já correto, inalterado). `SPEC-003` corrigido (v1.1.0 → v1.2.0) — removida a correspondência incorreta com `Evidence Builder`. `ITEM-12` passa de `Awaiting ADR` para `Implemented`. Com esta resolução, `RFC-001` a `RFC-004` estão todas encerradas.
