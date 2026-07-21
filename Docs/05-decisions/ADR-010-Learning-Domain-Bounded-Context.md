---
id: ADR-010
title: Learning Domain — New Bounded Context
version: 1.1.0
status: Accepted
owner: Product Owner
depends_on:
  - ARCH-001
  - ADR-008
  - ADR-009
related:
  - RFC-007
last_updated: 2026-07-21
---

# ADR-010: Learning Domain — New Bounded Context

## Status

Accepted.

## Contexto

O TradingOS foi redefinido para operar em duas trilhas evolutivas permanentes: Execução e Conhecimento, esta última já estruturada pelo `ADR-008` em Platform (constrói capacidade operacional) → Validation (produz evidências por meio de experimentos, backtests e resultados operacionais) → Learning (transforma essas evidências em conhecimento reutilizável).

Ao planejar `DOMAIN-006 — Knowledge Model`, identificou-se que `Knowledge` não está listado entre os componentes do Core Domain em `ARCH-001` (`Evidence`, `Market Context`, `Opportunity`, `Decision`), nem catalogado em `SPEC-001`. O próprio `ADR-008` já havia registrado essa lacuna explicitamente (seção "Escopo desta decisão"): `Knowledge Repository`/Learning Engine permanecem "sem posição definida em nenhum Bounded Context até que uma decisão arquitetural própria seja tomada."

**Nota de correção**: a versão 1.0.0 deste ADR citava `ADR-009` como fonte dessa frase — incorreto. A frase pertence a `ADR-008`; `ADR-009` nunca tratou do posicionamento de `Knowledge`/Learning Engine. Corrigido nesta versão.

Escrever `DOMAIN-006` sem resolver essa lacuna primeiro incorreria em decidir implicitamente, por meio de um documento de domínio, que `Knowledge` pertence ao Core Domain — uma decisão arquitetural real, não uma formalização documental. Este ADR resolve essa lacuna explicitamente, antes de qualquer documento de domínio ser escrito.

## Decisão

1. **O Core Domain permanece inalterado**, exatamente conforme `ARCH-001`: `Evidence`, `Market Context`, `Opportunity`, `Decision`. Nenhum componente é adicionado, removido ou renomeado nele.

2. **`Knowledge` não é incorporado ao Core Domain.**

3. **Um novo Bounded Context é criado: `Learning Domain`** — o quinto Bounded Context da arquitetura do TradingOS, ao lado de Core Domain, Infrastructure, Strategy e Execution (`ARCH-001`).

4. **Responsabilidade do Learning Domain**: consolidar evidências produzidas pela Validation (Trilha 2, `ADR-008`) e gerar conhecimento reutilizável para futuras evoluções do sistema.

5. **Limites do Learning Domain**:
   - não participa da execução operacional da Release 1.0;
   - não depende de, nem é dependido por, nenhum componente de Execution (`EXEC-001` a `EXEC-005`) para a Release 1.0;
   - não altera, não substitui e não se sobrepõe a nenhum componente do Core Domain;
   - consome evidências/resultados já produzidos pela Validation (Trilha 2) como sua entrada natural — sem acesso direto a `Infrastructure` ou `Execution`.

6. **`DOMAIN-006` será o primeiro documento formal do Learning Domain**, elaborado somente após a aprovação deste ADR, assumindo o Bounded Context aqui estabelecido sem rediscutir seu posicionamento arquitetural.

## Não Responsabilidades do Learning Domain

O Learning Domain **não**:

- toma decisões operacionais (isso permanece exclusivo do Core Domain/Execution);
- executa ordens ou acessa `MT5 Adapter`/`Order Manager`/`Position Manager` diretamente;
- calcula indicadores (isso permanece exclusivo de `Indicator Provider`);
- altera, substitui ou se sobrepõe a `Evidence`, `Market Context`, `Opportunity` ou `Decision`;
- introduz Inteligência Artificial ou Machine Learning nesta decisão — este ADR formaliza apenas o **posicionamento arquitetural** (o Bounded Context), não a técnica de aprendizado a ser usada. Qualquer proposta de IA/ML é uma decisão distinta, futura, e exigirá seu próprio ADR/RFC.

## Relação com Platform

O Learning Domain não se comunica com a Platform (Trilha 1 — Infrastructure/Execution/MT5). Não há dependência em nenhuma direção: a Platform desconhece o Learning Domain, e o Learning Domain não invoca componentes de Execution.

## Relação com Validation

O Learning Domain consome os artefatos já produzidos pela Validation (Trilha 2 — `VALIDATION-001`, `BACKTEST-001`, futuros `WALKFORWARD-001`/`FORWARDTEST-001`/`EDGE-REPORT-001`, armazenados conforme `DATA-001`). Essa é sua única fonte de entrada — o Learning Domain não gera evidências por conta própria, apenas consolida as que a Validation já produziu.

## Relação com Core Domain

Nenhuma. O Learning Domain não depende do Core Domain (`Evidence`/`Market Context`/`Opportunity`/`Decision`) nem é dependido por ele nesta decisão. Uma eventual integração (ex.: o Core Domain vindo a consumir conhecimento do Learning Domain no futuro) exigirá uma decisão arquitetural própria, não antecipada aqui.

## Relação com Futuras Implementações

O Learning Domain é o Bounded Context onde `Knowledge Repository`, `Learning Engine` e `Recommendation Engine` (já citados como "Futura Evolução" em `INFRA-001`/`INFRA-002`, e como Trilha 3 em `ADR-008`) encontrarão, quando implementados, sua posição arquitetural formal. Este ADR não os especifica — apenas lhes dá um Bounded Context para existir.

## Impacto em ARCH-001

Aditivo apenas: uma nova subseção `## Learning Domain` sob `# Bounded Contexts`, análoga às quatro já existentes (Core Domain/Infrastructure/Strategy/Execution). Nenhuma seção existente de `ARCH-001` é reescrita ou removida.

## Impacto em SPEC-001

Nenhum nesta decisão. `SPEC-001` (Canonical Component Catalog) não ganha nenhuma categoria ou componente novo agora — isso só ocorrerá quando (e se) `DOMAIN-006`/futuras especificações do Learning Domain exigirem componentes concretos, por registro próprio e posterior.

## Compatibilidade com ADR-009

Total. `ADR-009` (Baseline Lock v1.1) já previa exatamente esta situação: "`Learning Engine`/`Knowledge Repository`/`Recommendation Engine` seguem exatamente como itens de Futura Evolução... sem posição definida em nenhum Bounded Context até que uma decisão arquitetural própria seja tomada." Este ADR-010 é essa decisão. Não conflita com a sequência travada (`EXEC-001` a `EXEC-005`, `ROADMAP-001` a `005`), com o critério de reabertura de discussão arquitetural (`ADR-009` §8 — esta é uma decisão nova, não uma reabertura de `RFC-006`/`RFC-007`), nem com nenhuma família documental congelada (`DOMAIN-*` já existe; nenhuma família nova é criada).

## Critérios de Aceite

Esta decisão está corretamente formalizada quando:

- `ARCH-001` listar `Learning Domain` como Bounded Context, sem alteração de nenhuma outra seção;
- `DOMAIN-006` puder ser escrito referenciando este ADR, sem reabrir a discussão de posicionamento;
- nenhum componente do Core Domain ou de Execution (`EXEC-001` a `EXEC-005`) tiver sido movido, renomeado ou alterado;
- nenhuma dependência circular existir entre Learning Domain e Platform/Core Domain.

## Consequências

- `ARCH-001` precisará de uma atualização futura (após aprovação deste ADR) para registrar `Learning Domain` como um quinto Bounded Context na seção "Bounded Contexts" — atualização mínima, aditiva, sem alterar nenhuma seção referente a Core Domain, Infrastructure, Strategy ou Execution.
- `DOMAIN-006 — Knowledge Model` passa a ser especificado como parte do `Learning Domain`, não do Core Domain — sua numeração na família `DOMAIN-*` identifica que é um documento de modelo de domínio, não que pertence ao mesmo Bounded Context de `DOMAIN-001` a `DOMAIN-005`.
- Nenhum componente do Canonical Component Catalog (`SPEC-001`) é alterado por este ADR. Uma futura categoria de componentes do Learning Domain (se necessária) exigirá seu próprio registro em `SPEC-001`, por decisão separada.
- A Release 1.0 (sequência `EXEC-001` a `EXEC-005`, `ROADMAP-001` a `005`) não é afetada — o Learning Domain é, por definição, posterior e paralelo, não um pré-requisito.
