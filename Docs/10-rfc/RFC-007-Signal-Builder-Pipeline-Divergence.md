---
id: RFC-007
title: Signal Builder Pipeline Divergence (ARCH-001/SPEC-002 vs EXEC-004)
version: 2.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-002
  - SPEC-003
  - EXEC-004
related:
  - RFC-006
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-007: Signal Builder Pipeline Divergence

## Classificação

Requires Architectural Decision (severidade alta — afeta se o pipeline de Core Domain é usado ou contornado)

## Contexto

Durante a Validação Prévia de `Docs/03-architecture/EXEC-004-Signal-Builder.md`, foi identificada uma divergência significativa entre o fluxo oficial já definido na Baseline e o pipeline descrito no brief de origem desta entrega.

**Fluxo oficial (`ARCH-001`)**:
> Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order

**Contrato já existente de `Signal Builder` (`SPEC-002`, congelado)**:
> Responsabilidade: Transformar Decision em Signal operacional. Entrada: Decision. Saída: Signal. Consumidores: Order Manager.

**Pipeline descrito no brief de `EXEC-004`**:
> Entrada: Market Context, Indicator Snapshot, Configuration → (Indicator Validation → Rule Evaluation → Filter Evaluation → Conflict Resolution → Signal Decision) → SignalResult (BUY/SELL/NO_SIGNAL) → consumido por Risk Service (`EXEC-003`).

O pipeline de `EXEC-004` **não consome uma `Decision`** e **não produz um `Signal` para `Order Manager`** — ele consome `Market Context` e indicadores diretamente, e entrega o resultado a `Risk Service` (`EXEC-003`), não a `Order Manager`. Isso significa que, tal como especificado, `EXEC-004` (junto com `EXEC-003`) descreve um pipeline operacional completo que **não passa pela Opportunity (`DOMAIN-001`) nem pela Decision (`DOMAIN-005`)** — as duas entidades centrais do Core Domain construídas ao longo desta Baseline, com Domain Services próprios já especificados em `SPEC-003` (`Opportunity Service`, `Decision Service`).

Esta é uma divergência mais séria que a de `RFC-006` (Risk Service): ali, dois contratos coexistiam sob o mesmo nome; aqui, um pipeline inteiro de Execution parece **substituir funcionalmente** a cadeia de Core Domain, não apenas nomear diferente uma peça isolada.

## Proposta em aberto

Esta RFC não decide qual pipeline é o correto. Alternativas possíveis, apenas para registro:

1. **`EXEC-003`/`EXEC-004` descrevem um MVP operacional intencional** — um caminho mais curto (indicadores → sinal → risco → ordem) para viabilizar a Primeira Execução (`ADR-009`) antes que `Opportunity`/`Decision`/`Market Context Builder`/`Opportunity Service`/`Decision Service` estejam implementados. Neste caso, o pipeline de `ARCH-001` (`Opportunity → Decision → Signal`) seria a arquitetura-alvo de longo prazo, e `EXEC-003`/`EXEC-004` um "modo de operação" explicitamente transitório — o que precisaria ser dito claramente em `ARCH-001` ou em ADR próprio, não deixado implícito.
2. **É um mal-entendido de terminologia** — "Market Context" e "Decision" nos briefs de origem podem estar sendo usados coloquialmente (não como os agregados formais `DOMAIN-004`/`DOMAIN-005`), e a intenção real seria consumir a saída já formal de `Decision Service`. Neste caso, `EXEC-004` precisaria ser corrigido para consumir `Decision`, não `Market Context`/`Indicator Snapshot` diretamente.
3. **O Core Domain (`Opportunity`/`Decision`) é redundante para a Release 1.0** e o projeto decide conscientemente operar apenas na camada de Execution até que haja motivo real para reativar o pipeline de Core Domain — decisão que precisaria revisitar `ADR-002` (Domain Evolution) e o investimento já feito em `DOMAIN-001`/`DOMAIN-005`/`SPEC-003`.

## Encaminhamento

Dado o impacto (decide se meses de trabalho em `DOMAIN-001`/`DOMAIN-005`/`SPEC-003` são usados na Release 1.0 ou contornados), recomenda-se que esta RFC seja resolvida por ADR explícito antes de `EXEC-005` ser tratado como o fechamento da sequência operacional — ou, ao menos, antes de qualquer implementação de `EXEC-003`/`EXEC-004` começar.

---

## Post-Execution Architecture Review — Decision Pipeline (Prioridade 1)

Revisão solicitada após a conclusão de `EXEC-001` a `EXEC-005` (`ADR-009`). Compara formalmente duas alternativas de pipeline para a **Release 1.0**. Esta decisão **não altera** `ARCH-001`, o Canonical Component Catalog, nem `EXEC-001` a `EXEC-005` — define apenas qual pipeline rege o *escopo de implementação* da Release 1.0.

### Alternativa A

```
Indicators → Opportunity → Risk Service → Decision → Order Manager
```

Risk Service opera como Core Domain Service (`SPEC-003`): avalia a `Opportunity` e alimenta a `Decision Service`, que produz a `Decision` final consumida por `Order Manager`.

### Alternativa B

```
Indicators → Decision → Risk Service → Order Manager
```

`Decision` é produzida diretamente a partir dos indicadores (via o mecanismo já especificado em `EXEC-004`, adaptando a lógica já implementada na Legacy Baseline — `MarketService`/`MarketAssessmentService`/`SignalBuilderService`). `Risk Service` opera como gate operacional pré-envio (`EXEC-003`), imediatamente antes de `Order Manager`.

### Análise Comparativa

| Critério | Alternativa A | Alternativa B |
|---|---|---|
| Responsabilidades | Mais granular e alinhada ao DDD: Opportunity Service identifica, Risk Service avalia risco da hipótese, Decision Service decide. Mas exige que `Opportunity Service`, `Decision Service` e `Market Context Builder` existam — nenhum está implementado hoje (`AUDIT-001`). | Menos granular — `Decision` conflacia o papel de Opportunity+Decision Service, reaproveitando a lógica já implementada e compilando na Legacy Baseline (`MarketAssessmentService`/`SignalBuilderService`). |
| Acoplamento | Risk Service acoplado a tipos de Core Domain (`Opportunity`, `Market Context`) — baixo acoplamento com Execution/Infraestrutura, conforme `ARCH-001`. | Risk Service acoplado a `Signal Result`/dados operacionais (`EXEC-003`, já especificado) — mais próximo da Execution, mas ainda sem depender de Core Domain (não viola `ARCH-001`). |
| Rastreabilidade | Corresponde exatamente ao fluxo oficial de `ARCH-001` e à suíte `DOMAIN-001`/`DOMAIN-005`/`SPEC-003`. | Corresponde exatamente ao que `EXEC-003`/`EXEC-004`/`VALIDATION-001` já especificam e ao que `BACKTEST-001` já está preparado para validar sobre a Legacy Baseline. |
| Testabilidade | Testável em teoria, mas hoje testaria contra tipos (`Opportunity`, `Market Context`) que não existem em código — nenhuma base para backtest imediato. | Testável imediatamente — `VALIDATION-001`/`BACKTEST-001` já assumem que a estratégia validada é a Legacy Baseline adaptada, não o modelo de domínio formal. |
| Extensibilidade | Superior a longo prazo — é o modelo pensado para múltiplas estratégias, reuso de Domain Services (`ADR-002`, `ADR-003`). | Inferior a longo prazo, mas suficiente para a Release 1.0; não impede migração futura (`ADR-001`: Legacy Baseline não é refatorada à força, mas convive e pode evoluir com benefício real). |
| Impacto na implementação | **Alto**: exige implementar `Evidence Builder`, `Market Context Builder`, `Opportunity Service`, `Decision Service` — hoje 0% implementados — antes de qualquer ordem poder ser enviada. | **Baixo**: reaproveita código já implementado e compilando (Legacy Baseline) mais a camada de Execution já 100% especificada (`EXEC-001` a `EXEC-005`). |

### Decisão

**Alternativa B é adotada como pipeline normativo da Release 1.0.**

Justificativa: `ADR-009` estabeleceu a Primeira Execução como prioridade absoluta do projeto, com o critério explícito "esta mudança aproxima ou afasta a Primeira Execução?". A Alternativa A afasta — exige construir do zero toda a cadeia de Core Domain (`Opportunity Service`, `Decision Service`, `Market Context Builder`, `Evidence Builder`) antes de qualquer ordem poder ser enviada. A Alternativa B aproxima — reaproveita a Legacy Baseline já implementada e compilando, mais a camada `EXEC-001` a `EXEC-005` já inteiramente especificada nesta sessão, sem exigir nenhum código novo de Core Domain.

Esta decisão **não invalida nem substitui** `ARCH-001`, `DOMAIN-001`, `DOMAIN-005` ou `SPEC-003` — nenhum desses documentos é alterado. O fluxo `Opportunity → Decision` continua sendo a arquitetura-alvo de longo prazo, registrada e válida, para quando houver benefício real em migrar (`ADR-001`, `ADR-002`). A Alternativa B é adotada **especificamente como escopo da Release 1.0**, não como revogação do modelo de domínio.

`EXEC-003` e `EXEC-004`, tal como já especificados, estão corretos e **não precisam de nenhuma alteração** — eles já implementavam a Alternativa B.

### Status

**Approved** — decisão normativa para a Release 1.0.
