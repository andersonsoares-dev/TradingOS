---
id: RFC-006
title: Risk Service Contract Divergence (SPEC-003 vs EXEC-003)
version: 1.0.0
status: Open
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

## Status

Open — aguardando decisão do Product Owner / Chief Architect.
