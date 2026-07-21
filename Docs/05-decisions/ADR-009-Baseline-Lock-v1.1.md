---
id: ADR-009
title: Baseline Lock v1.1 — Documentation Stabilization & Delivery Sequence
version: 1.1.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-007
  - ADR-008
related:
  - EXEC-001
  - EXEC-002
  - RFC-006
  - RFC-007
  - DOCUMENT_INDEX.md
last_updated: 2026-07-21
---

# ADR-009: Baseline Lock v1.1 — Documentation Stabilization & Delivery Sequence

## Status

Accepted

## Contexto

Após o fechamento do RC-001 (`ADR-007`) e a reestruturação do roadmap em trilhas paralelas (`ADR-008`), o repositório acumulou uma estrutura documental madura: famílias `ADR-*`, `RFC-*`, `ARCH-*`/`DOMAIN-*`/`SPEC-*`, `INFRA-*` e, mais recentemente, `EXEC-*` (introduzida organicamente em `EXEC-001`/`EXEC-002` por analogia ao padrão já usado em `INFRA-00X`).

Existe o risco de que a documentação continue sendo reorganizada indefinidamente (renumerações, novas famílias, movimentação de pastas) às custas do objetivo real do projeto: chegar à Primeira Execução da plataforma. Este ADR congela a estrutura documental no estado atual e redireciona a prioridade do projeto para a entrega de código executável.

## Decisão

### 1. Estabilização estrutural (Baseline Lock v1.1)

A partir deste ADR:

- nenhuma nova reorganização da documentação será proposta;
- nenhum documento será renumerado;
- nenhum documento será movido entre pastas;
- nenhuma família documental será alterada;
- nenhum novo tipo de documento será proposto sem justificativa arquitetural explícita.

Qualquer melhoria estrutural identificada deverá ser apenas registrada como sugestão (backlog/RFC), nunca aplicada automaticamente.

### 2. Repositório como autoridade

`DOCUMENT_INDEX.md` é sempre a fonte da verdade sobre quais documentos existem e sob qual id/caminho. Antes de criar, numerar ou renomear qualquer documento, ou de propor uma nova família documental, `DOCUMENT_INDEX.md` deve ser consultado. Nenhum id é assumido sem essa verificação.

### 3. Famílias documentais congeladas

| Domínio | Famílias |
|---|---|
| Governança | `DOCUMENT-*`, `ADR-*`, `RFC-*` |
| Arquitetura | `ARCH-*`, `DOMAIN-*`, `INFRA-*`, `EXEC-*` |
| Especificações | `SPEC-*` |
| Validação | `VALIDATION-*` (além de `BACKTEST-*`, `WALKFORWARD-*`, `FORWARDTEST-*`, `EDGE-REPORT-*`, `DATA-*`, já em uso em `Docs/06-validation/`) |
| Roadmap | `ROADMAP-*` |

Qualquer família nova exige justificativa arquitetural registrada (ADR ou RFC), não criação ad hoc.

### 4. Família EXEC para componentes executáveis

A família `EXEC-*` é oficialmente adotada para os Execution Components já catalogados em `SPEC-001`, substituindo qualquer proposta anterior de usar `SPEC-00X` para especificar um componente individual (`SPEC-00X` permanece reservado para categorias inteiras — Domain Services, Application Services, Business Rules — não componentes isolados). `EXEC-001` (Order Manager) e `EXEC-002` (Position Manager), já criados por este mesmo raciocínio antes deste ADR, ficam retroativamente confirmados sob esta família.

### 5. Architecture Baseline v1.0 reafirmada

`ADR-007` permanece integralmente em vigor. Nenhum documento pode alterar Architecture, Canonical Component Catalog, Dependency Graph ou Layer Model sem aprovação explícita (novo ADR ou RFC aprovada).

### 6. Prioridade do projeto: Primeira Execução

A prioridade absoluta do projeto passa a ser a Primeira Execução da plataforma. Toda decisão de escopo deve responder: *"Esta mudança aproxima ou afasta a Primeira Execução?"* Se afastar, é registrada como backlog — não implementada nesta fase.

### 7. Sequência de entrega travada

```
EXEC-001 Order Manager
↓
EXEC-002 Position Manager
↓
EXEC-003 Risk Service
↓
EXEC-004 Signal Builder
↓
EXEC-005 MT5 Adapter
↓
Sprint 1
↓
Primeira Execução
```

Esta sequência não será alterada, salvo impossibilidade estrutural comprovada.

### 8. Critério de reabertura de discussão arquitetural (pós-aprovação de RFC-006/RFC-007)

Após a aprovação de `RFC-006` e `RFC-007` (Post-Execution Architecture Review), qualquer discussão arquitetural só poderá ser reaberta mediante **evidência obtida durante a implementação, testes ou Primeira Execução** — não por hipótese ou preferência conceitual levantada em discussão.

Hipóteses e melhorias conceituais identificadas a partir deste ponto são registradas automaticamente como backlog da Release 2.0, sem interromper a implementação em curso.

---

## Observações (achados na Validação Prévia — não bloqueiam esta decisão)

**Nomenclatura**: o brief de origem referenciava `EXEC-004` como "Signal Engine". O nome canônico em `SPEC-001` (Execution Components) é **`Signal Builder`** — não existe "Signal Engine" no Canonical Component Catalog. Corrigido acima para `Signal Builder`, mantendo a posição e o número de sequência (`EXEC-004`) inalterados.

**Categorização — Risk Service**: `SPEC-001` cataloga `Risk Service` como **Core Domain Service** (junto de Opportunity Service, Decision Service, Confidence Service), não como Execution Component. A sequência de entrega travada acima usa `EXEC-003` para `Risk Service` como um **rótulo de sequenciamento de roadmap** ("terceira entrega rumo à Primeira Execução"), não como uma reclassificação de Bounded Context — `Risk Service` continua pertencendo ao Core Domain, conforme `SPEC-001`/`SPEC-003`, e sua futura especificação detalhada deverá deixar isso explícito (o documento poderá, inclusive, adotar um prefixo diferente de `EXEC-` quando for escrito, sem violar a sequência travada, que se refere à ordem de entrega, não ao prefixo documental). Esta observação não altera a sequência nem exige ação agora — é registrada para que a futura especificação de `Risk Service` não implique, por engano, que ele migrou para o Bounded Context de Execution.

Nenhuma das duas observações é tratada como inconsistência bloqueante — ambas são compatíveis com a decisão tomada e não exigem revisão da sequência ou das famílias documentais acima.

---

## Consequências

- Toda futura criação de documento deve consultar `DOCUMENT_INDEX.md` primeiro, sem exceção.
- `EXEC-003`, `EXEC-004`, `EXEC-005` são ids pré-reservados pela sequência acima — futuras entregas devem usá-los exatamente nesta ordem, sem renumeração.
- Sugestões de melhoria estrutural, quando identificadas, serão registradas (RFC ou nota em `TRACEABILITY.md`), nunca aplicadas de forma automática.
- Este ADR não será revisitado até a conclusão da Primeira Execução, conforme instrução explícita do Product Owner.
- A partir da aprovação de `RFC-006`/`RFC-007`, novas ideias arquiteturais sem evidência de implementação/teste vão automaticamente para o backlog da Release 2.0 — nenhuma delas pausa ou reabre a implementação em curso.
