---
id: ADR-008
title: Roadmap Restructuring — Parallel Tracks (Platform, Validation, Learning)
version: 1.1.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-004
  - ADR-007
  - AUDIT-001
related:
  - INFRA-001
  - INFRA-002
  - INFRA-003
last_updated: 2026-07-21
---

# ADR-008: Roadmap Restructuring — Parallel Tracks

## Status

Accepted

## Contexto

A Fase 2 (Platform Foundation) iniciou-se exclusivamente pela trilha de Infrastructure (`INFRA-001`, `INFRA-002`, `INFRA-003`), sem qualquer validação de que a estratégia de trading subjacente possui expectativa positiva (edge). A gestão de risco (REQ-009) segue não atendida; nenhum backtest, walk-forward ou forward test formal foi executado até o momento (ver `AUDIT-001`, Coverage Matrix — Testing ~15% concluído, apenas o estágio "Compilation" do pipeline do `ADR-004`).

Existe o risco de "analysis paralysis": continuar produzindo documentação e arquitetura extensas sem jamais validar a hipótese central do projeto — que a estratégia de trading possui edge real. O objetivo do TradingOS não é ser o sistema mais bem documentado; é operar de forma lucrativa, controlada e auditável.

Adicionalmente, para que um futuro Learning Engine (já citado, sem implementação, em `INFRA-001`/`INFRA-002` — "Princípio de Evolução") tenha material para aprender, é necessário começar a gerar histórico estruturado de operações o quanto antes — mesmo que via replay, backtest, paper trading ou conta demo.

## Decisão

O roadmap do TradingOS passa a ser executado em três trilhas, com as duas primeiras avançando em paralelo a partir de agora:

**Trilha 1 — Platform** (continua sem interrupção): Infrastructure, Execution, MT5, Persistence, Logging, Configuration. Objetivo: disponibilizar uma plataforma estável. As entregas já iniciadas (`INFRA-001`, `INFRA-002`, `INFRA-003`) e as futuras (`INFRA-004` em diante) prosseguem normalmente, sem pausa.

**Trilha 2 — Validation** (inicia agora, em paralelo à Trilha 1): valida a hipótese de que a estratégia de trading possui edge, antes de investir mais esforço de escala na plataforma. Compreende Strategy Baseline, Backtest, Walk Forward, Forward Test, Performance Reports, Edge Validation. Objetivo: produzir evidências quantitativas da estratégia. Documentos desta trilha usam o prefixo `VALIDATION-00X` e residem em `Docs/06-validation/` — a mesma pasta já usada para validação documental (`AUDIT-001`), sem criar nova estrutura de diretório.

**Trilha 3 — Learning** (inicia somente após existir histórico real de operações produzido pela Trilha 2 — replay/backtest/paper/demo): Knowledge, Learning Engine, Recommendation Engine, Optimization, Machine Learning. Objetivo: evolução futura baseada em dados reais. Esta trilha permanece fora do escopo da Release 1.0.

## Release 1.0 — Definition of Done

A Release 1.0 será considerada concluída quando existir um sistema capaz de:

- operar automaticamente uma estratégia;
- executar ordens;
- controlar risco;
- produzir logs;
- executar Backtest;
- executar Forward Test;
- produzir métricas de desempenho.

Nenhum desses itens está implementado hoje (ver `AUDIT-001`, Coverage Matrix). Esta lista é o critério objetivo de conclusão da Release 1.0 — substitui qualquer noção implícita de "pronto" baseada apenas em documentação completa ou arquitetura aprovada.

## Nova Regra de Governança — Milestone Scoping

Toda nova funcionalidade proposta deverá responder, antes de ser aceita no escopo corrente:

*"Esta funcionalidade é necessária para concluir o Milestone atual?"*

Se **não**: a funcionalidade é registrada no backlog (`Docs/09-roadmap/` ou RFC, conforme o caso) e **não** altera o escopo da Release atual.

Esta regra aplica-se às três trilhas e existe para conter o risco de "analysis paralysis" identificado no Contexto — evita que trabalho adicional (documentação, arquitetura ou funcionalidade) seja aceito só por parecer valioso, sem estar a serviço do Milestone em andamento.

## Escopo desta decisão

Esta é uma decisão de **sequenciamento de roadmap/entrega**, não uma alteração da arquitetura definida em `ARCH-001`. Os Bounded Contexts (Core Domain, Infrastructure, Strategy, Execution) permanecem exatamente como definidos em `ARCH-001` — nenhum Bounded Context novo ("Validation", "Learning") é criado por este ADR. `Validation` é tratada como disciplina de verificação transversal (mesmo papel que `06-validation/` já cumpria para `AUDIT-001`); `Learning Engine`/`Knowledge Repository`/`Recommendation Engine` seguem exatamente como itens de "Futura Evolução" já citados em `INFRA-001`/`INFRA-002`, sem posição definida em nenhum Bounded Context até que uma decisão arquitetural própria seja tomada.

## Impactos

**Benefícios**:
- a hipótese central do projeto (a estratégia possui edge?) passa a ser testada em paralelo, não ao final da Fase 2;
- a Trilha 1 (Platform) não perde velocidade nem é interrompida;
- histórico estruturado de operações (via backtest/replay/demo) começa a ser gerado mais cedo, beneficiando a futura Trilha 3 (Learning).

**Riscos mitigados**:
- "analysis paralysis" — investir indefinidamente em documentação/arquitetura sem jamais validar a estratégia;
- descoberta tardia de que a estratégia tem expectativa negativa, após meses de investimento em plataforma;
- expansão de escopo não controlada (mitigada pela regra de Milestone Scoping acima).

**Trade-offs**:
- exige atenção dividida entre duas trilhas simultâneas em vez de uma sequência única;
- `VALIDATION-001` já revela uma lacuna real (ausência de critérios de saída/gestão de risco — ver `VALIDATION-001`, "Fora de Escopo"), que precisará de RFC/ADR próprios antes do primeiro backtest completo.

## Consequências

**Positivas**:
- `VALIDATION-001` (Trading Strategy Baseline) é aberto a partir deste ADR, com escopo limitado à definição da estratégia de validação e dos critérios de aceitação (backtests, walk-forward, forward test, métricas de sucesso);
- o projeto passa a ter um critério objetivo de conclusão (Release 1.0 — Definition of Done, acima), reduzindo ambiguidade sobre "quando estamos prontos";
- a regra de Milestone Scoping passa a se aplicar a toda nova funcionalidade proposta nas três trilhas.

**Negativas / a monitorar**:
- decisões de gestão de risco e critérios de saída (stop loss, take profit, position sizing — hoje inexistentes em qualquer `DOMAIN`/`SPEC`, associadas a `REQ-009`/`Risk Service`, ambos `Planned`) **não** são tratadas dentro de `VALIDATION-001`. Deverão ser objeto de RFC/ADR próprios, preservando a separação entre validação, arquitetura e regras de negócio — até lá, a validação de edge fica incompleta (sem simular saída realista).
- Nenhum documento da Baseline v1.0 (`DOMAIN`, `ARCH`, `SPEC`) é alterado por este ADR.
- A Trilha 1 (Platform) continua seu roadmap já publicado (`INFRA-004 — Configuration Provider`, em diante) sem qualquer pausa.
