---
id: RFC-006
title: Risk Service Contract Divergence (SPEC-003 vs EXEC-003)
version: 2.0.0
status: Approved
owner: Product Owner
depends_on:
  - SPEC-001
  - SPEC-003
  - EXEC-003
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-006: Risk Service Contract Divergence

## Classificação

Requires Architectural Decision

## Contexto

Durante a Validação Prévia de `Docs/03-architecture/EXEC-003-Risk-Service.md`, foi identificado que dois documentos da Baseline/roadmap definem contratos diferentes para um componente chamado `Risk Service`:

**`SPEC-003` (Domain Services, congelado)**:
> Responsabilidade: Avaliar o risco da Opportunity. Entrada: Opportunity, Market Context. Saída: Risk Profile.

Este é um Core Domain Service — avalia o risco de uma `Opportunity` ainda no domínio, antes de qualquer `Decision`/`Signal`.

**`EXEC-003` (esta entrega, brief de origem)**:
> Entrada: Signal Result, Symbol Information, Account Information, Current Exposure, Configuration. Saída: Risk Approved / Risk Rejected / Risk Warning / Risk Error / Risk Evaluation Result.

Este é um gate operacional pré-envio de ordem — avalia um `Signal Result` já produzido, no contexto de conta e exposição atual, imediatamente antes de `Order Manager` (`EXEC-001`) enviar a ordem.

Ambos usam o nome "Risk Service", mas descrevem responsabilidades, entradas e saídas incompatíveis entre si — não é a mesma interface em dois níveis de abstração, são dois papéis funcionalmente diferentes (um avalia uma hipótese de domínio; o outro audita uma operação prestes a ser executada).

Adicionalmente, `EXEC-003` declara depender de um `Account Provider`, que **não consta** no Canonical Component Catalog (`SPEC-001`).

## Proposta em aberto

Esta RFC não decide qual contrato é o correto, nem inventa uma reconciliação. Alternativas possíveis, apenas para registro:

1. São de fato **dois componentes distintos** que hoje compartilham o mesmo nome por acidente — o Core Domain Service de `SPEC-003` precisaria manter o nome `Risk Service`, e o gate operacional de `EXEC-003` precisaria de um nome próprio (ex.: "Pre-Order Risk Gate", já usado como subtítulo neste documento de forma provisória).
2. São o **mesmo componente com dois modos de operação** (avaliação de Opportunity no domínio + gate final antes do envio), e `SPEC-003` precisaria ser atualizado para refletir ambos os contratos — o que exigiria uma alteração à Baseline congelada (`SPEC-003`), fora do escopo desta RFC.
3. O gate operacional de `EXEC-003` é, na verdade, responsabilidade de `Order Manager` (`EXEC-001`) e não deveria existir como componente separado — outra hipótese a avaliar.

Adicionalmente, esta RFC registra que `Account Provider` (dependência citada em `EXEC-003`) precisa ser formalmente catalogado em `SPEC-001` (categoria Infrastructure Providers, por analogia a `Data Provider`/`Configuration Provider`) antes de ser tratado como dependência aprovada.

## Encaminhamento

Uma decisão formal (ADR ou RFC aprovada) deverá escolher entre as alternativas acima (ou outra), antes que qualquer implementação de `Risk Service`/`EXEC-003` comece, e antes que `Account Provider` seja usado por qualquer outro documento como se já fosse canônico.

---

## Post-Execution Architecture Review — Risk Service Classification (Prioridade 2)

Revisão realizada **após** a decisão do `RFC-007` (Prioridade 1), à qual esta decisão deve estar alinhada, conforme instruído.

### Pergunta

O `Risk Service` é:

A) um Domain Service; ou
B) um Gate Operacional entre Opportunity/Decision e Order Manager.

### Decisão

**Opção B — Risk Service é o Gate Operacional especificado em `EXEC-003`, para a Release 1.0.**

Justificativa: `RFC-007` adotou a Alternativa B (`Indicators → Decision → Risk Service → Order Manager`) como pipeline normativo da Release 1.0. Nessa alternativa, `Risk Service` atua exatamente como `EXEC-003` já o especifica — um gate pré-envio de ordem, avaliando `Signal Result`/exposição/conta imediatamente antes de `Order Manager`, não uma avaliação de `Opportunity` no Core Domain.

`EXEC-003`, tal como já especificado, está correto e **não precisa de nenhuma alteração**.

O contrato de `Risk Service` como Core Domain Service, definido em `SPEC-003` (Entrada `Opportunity`/`Market Context`, Saída `Risk Profile`), **não é revogado nem alterado** — `SPEC-003` permanece congelado e válido como parte da arquitetura-alvo de longo prazo (Alternativa A de `RFC-007`), para uso quando o Core Domain for implementado em uma release futura. Para a Release 1.0, apenas o papel de Gate Operacional (`EXEC-003`) é normativo.

**Recomendação para Release 2.0** (registrada, não aplicada agora): quando `Opportunity Service`/`Decision Service` forem implementados, avaliar se os dois papéis de "Risk Service" devem receber nomes distintos no Canonical Component Catalog (ex.: manter `Risk Service` para o Core Domain Service de `SPEC-003`, e nomear o gate operacional como `Pre-Order Risk Gate` — nome já usado como subtítulo em `EXEC-003`), evitando a ambiguidade de nome encontrada nesta RFC. Isso exigiria atualização de `SPEC-001`, fora do escopo desta decisão.

**Account Provider**: sua resolução foi formalizada por `ADR-014`. Para a Release 1.0, `EXEC-003` consome diretamente o `Account Snapshot` produzido por `EXEC-005.GetAccount()`. Nenhum `Account Provider` independente é catalogado em `SPEC-001`.

### Resolução da dependência Account Provider

O gap de proveniência de `Account Information` foi encerrado sem criação de componente novo. A decisão normativa está no `ADR-014`; a reconciliação do contrato Risk Service Core Domain versus gate operacional permanece conforme já aprovada nesta RFC.

### Status

**Approved** — decisão normativa para a Release 1.0, alinhada a `RFC-007` e complementada por `ADR-014` quanto à origem de Account Information.
