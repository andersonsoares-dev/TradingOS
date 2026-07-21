---
id: ADR-011
title: Evidence Lifecycle
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-007
  - DOMAIN-003
related:
  - ROADMAP-006
last_updated: 2026-07-21
---

# ADR-011: Evidence Lifecycle

## Status

Accepted

## Contexto

`DOMAIN-003` (Evidence, Core Domain, congelado por `ADR-007`) define hoje apenas uma Classificação estática (Primary/Derived/Composite), sem nenhum ciclo de vida. Durante a análise de evolução de `DOMAIN-003` (`ROADMAP-006`), foi proposto um ciclo de vida de 5 estados — `Candidate → Confirmed → Weak → Rejected → Expired` — classificado como Categoria 3 (Evolução arquitetural, exige ADR), já que introduzir estados implica novas regras sobre como os consumidores de Evidence já catalogados (`Market Context Builder`, `Evidence Validation Policy`, `SPEC-001`) devem tratá-la em cada estágio.

O item dependente (`ITEM-06` — atributos `Estado`/`Validade`) estava bloqueado pela mesma decisão, e ambos aguardavam a resolução de `ITEM-07` (o conceito `Observation`), que poderia ter afetado o desenho do ciclo de vida. `ITEM-07` foi avaliado e rejeitado (`Observation` não é um conceito de domínio novo — já coberto por `Data Provider`/`Indicator Provider`/`Evidence Builder`), removendo esse bloqueio.

## Decisão

1. **`DOMAIN-003` (Evidence) ganha um ciclo de vida formal**:

```
Candidate
↓
Confirmed
↓
Weak
↓
Rejected
↓
Expired
```

2. **Significado de cada estado**:
   - **Candidate**: Evidence recém-produzida por um Core Domain Builder (`Evidence Builder`, `SPEC-001`), ainda não avaliada pela `Evidence Validation Policy`.
   - **Confirmed**: avaliada e aprovada pela `Evidence Validation Policy` — consistente, pode compor um `Market Context` com seu `Weight` pleno.
   - **Weak**: avaliada e aprovada, porém com baixa confiança/consistência — pode compor um `Market Context`, mas com influência reduzida (`Weight` rebaixado). Não é o mesmo que `Rejected`.
   - **Rejected**: falhou na avaliação da `Evidence Validation Policy` — nunca compõe um `Market Context`.
   - **Expired**: ultrapassou sua janela de validade (`Validade`, novo atributo) — deixa de ser elegível para novos `Market Context`, mas é preservada para auditoria.

3. **Dois novos atributos em `DOMAIN-003`**: `Estado` (um dos cinco valores acima) e `Validade` (janela temporal após a qual uma Evidence transita automaticamente para `Expired`).

4. **Novas regras de negócio** (numeração sequencial às já existentes, `BR-006` a `BR-008`):
   - `BR-006`: toda Evidence nasce em estado `Candidate`.
   - `BR-007`: apenas Evidence em estado `Confirmed` ou `Weak` pode compor um `Market Context`; `Candidate`, `Rejected` e `Expired` não podem.
   - `BR-008`: a transição para `Expired` ocorre automaticamente quando `Validade` é ultrapassada, independentemente do estado anterior (exceto se já `Rejected`).

5. **Nenhum outro documento é alterado** por este ADR — `SPEC-001` (`Evidence Validation Policy`, já catalogada, status `Planned`) não precisa de atualização de catálogo; a lógica de decisão de estado é detalhe de implementação futura da própria Policy, não do catálogo.

## Consequências

- `DOMAIN-003` será atualizado (v1.0.0 → v2.0.0) para incorporar o ciclo de vida, os dois novos atributos e as três novas regras de negócio.
- `ROADMAP-006`: `ITEM-05` e `ITEM-06` transitam de `Awaiting ADR` para `Implemented`.
- `Evidence Validation Policy` (`SPEC-001`, ainda `Planned`) passa a ter uma responsabilidade adicional implícita (decidir `Confirmed` vs. `Weak` vs. `Rejected`), a ser detalhada quando for especificada/implementada — não antecipada aqui.
- Nenhum impacto na Release 1.0 (`EXEC-001` a `EXEC-005`, `ROADMAP-001` a `005`) — `Evidence` pertence ao Core Domain, fora do pipeline de Execução decidido pela `RFC-007` (Alternativa B) para a Release 1.0.
