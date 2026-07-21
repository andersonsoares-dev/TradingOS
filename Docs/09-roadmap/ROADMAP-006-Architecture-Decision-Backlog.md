---
id: ROADMAP-006
title: Architecture Decision Backlog
version: 1.1.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-007
  - ADR-009
  - ADR-010
related:
  - DOMAIN-003
  - RFC-001
  - ADR-011
last_updated: 2026-07-21
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

Cobre propostas de evolução identificadas durante revisões técnicas (ex.: a análise de evolução do `DOMAIN-003` realizada nesta sessão) que ainda não foram formalizadas como ADR ou RFC. Não cobre ADRs/RFCs já formalizados — esses são rastreados diretamente em `DOCUMENT_INDEX.md`/`TRACEABILITY.md`.

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

Todos os itens abaixo originam-se da análise de evolução do `DOMAIN-003` (Evidence) realizada nesta sessão.

### ITEM-01 — Renomear "Structure" para "Market Structure"

Categoria: **1**. Status: **Proposed**.

### ITEM-02 — Adicionar categorias "Price Action" e "Custom" a Evidence

Categoria: **2**. Status: **Proposed**.

### ITEM-03 — Categoria "Risk" para Evidence

Categoria: **3**. Dependência: **`RFC-001`** (Risk Profile Classification, ainda Open). Status: **Awaiting RFC**.

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

# Critérios para Encerramento

Um item é considerado encerrado (`Archived`) quando:

- implementado com sucesso na Baseline, com o documento-alvo atualizado e `TRACEABILITY.md` refletindo a mudança; ou
- rejeitado formalmente, com justificativa registrada neste backlog.

Nenhum item é removido do histórico — apenas transita para `Archived`, preservando rastreabilidade (mesmo princípio de retenção de `DOCUMENT_CONTROL`, Regra 10).

---

# Rastreabilidade

`ADR-007` (Baseline Freeze — motivo pelo qual itens Categoria 3+ exigem decisão formal) · `ADR-009` (Baseline Lock v1.1 — famílias documentais e critério de reabertura) · `ADR-010` (precedente de resolução de Bounded Context, aplicável a ITEM-04/ITEM-07) · `DOMAIN-003` (origem de todos os itens atuais) · `RFC-001` (dependência de ITEM-03).

---

# Resumo

- **Itens por categoria**: Categoria 1 — 1 item (ITEM-01); Categoria 2 — 1 item (ITEM-02); Categoria 3 — 4 itens, sendo 2 implementados (ITEM-05, ITEM-06) e 2 ainda bloqueados (ITEM-03, ITEM-04); Categoria 5 — 0 itens ativos (ITEM-07 avaliado e encerrado). Categoria 4 — 0 itens atualmente.
- **Bloqueados por decisão arquitetural** (Awaiting ADR/RFC): 2 (ITEM-03, ITEM-04).
- **Prontos para execução documental direta** (Categoria 1/2, sem ADR/RFC): 2 (ITEM-01, ITEM-02).
- **Implementados**: 2 (ITEM-05, ITEM-06 — formalizados por `ADR-011`, propagados a `DOMAIN-003` v2.0.0).
- **Encerrados/Rejeitados**: 1 (ITEM-07 — `Observation` avaliado e rejeitado como conceito de domínio novo).
- **Recomendação de priorização para as próximas revisões**: aplicar `ITEM-01`/`ITEM-02` a qualquer momento (baixo risco). `ITEM-03` (categoria Risk) permanece bloqueado até `RFC-001` avançar — não priorizar isoladamente. `ITEM-04` (categoria Execution) segue como `Awaiting ADR`, independente dos demais — próximo candidato natural a ser tratado.
