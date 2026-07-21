---
id: AUDIT-001
title: Architecture Baseline Audit
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOCUMENT_CONTROL
  - CONST-001
  - DOMAIN-001
  - DOMAIN-002
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - SPEC-003
  - SPEC-004
  - SPEC-005
  - SPEC-006
  - ADR-001
  - ADR-002
  - ADR-003
  - ADR-004
  - ADR-005
  - ADR-006
related:
  - TRACEABILITY.md
  - DOCUMENT_INDEX.md
last_updated: 2026-07-21
---

# AUDIT-001 — Architecture Baseline Audit

Auditoria documental completa do repositório TradingOS, realizada exclusivamente por leitura dos documentos oficiais do repositório (nenhum conhecimento externo utilizado). Esta auditoria não cria conceitos, não altera arquitetura e não modifica código-fonte ou documentos existentes — é estritamente um relatório de consistência.

---

# 1. Executive Summary

O repositório TradingOS possui hoje uma governança documental completa (Constituição, Visão, Requisitos, Handbook de Engenharia), um modelo de domínio-alvo coerente (Opportunity, Evidence, Market Context, Decision), uma arquitetura formal (ARCH-001), um catálogo canônico de componentes (SPEC-001) e seis especificações técnicas (SPEC-001 a SPEC-006), além de 6 ADRs que resolveram, de forma rastreável, todas as divergências arquiteturais identificadas ao longo do processo (incluindo o realinhamento do ciclo de vida da Opportunity via ADR-006, concluído imediatamente antes desta auditoria).

O núcleo do domínio (DOMAIN-001 a 005 + ARCH-001 + SPEC-001 a 006) está internamente consistente após o ADR-006. As inconsistências reais encontradas nesta auditoria concentram-se em três áreas: (1) os documentos de protocolo operacional para agentes de IA (`CLAUDE.md` e `AGENTS.md`) contradizem-se entre si em pontos estruturais; (2) o documento de maior precedência declarada (`DOCUMENT_CONTROL.md`) referencia uma estrutura de pastas que não corresponde à estrutura real e estabilizada; (3) alguns conceitos de domínio (Risk Profile) e de arquitetura (Strategy Bounded Context) são mencionados repetidamente mas nunca formalmente especificados.

Nenhuma inconsistência encontrada invalida o modelo de domínio ou a arquitetura-alvo. Nenhuma delas bloqueia o início da implementação da Fase 2 (Infrastructure/MT5 Integration) na parte já totalmente especificada do pipeline (Evidence → Market Context → Opportunity → Decision). Recomenda-se corrigir os itens Críticos e Altos antes de expandir significativamente o trabalho assistido por IA, para eliminar o risco de um agente seguir instruções conflitantes.

**Total de documentos auditados**: 36
**Total de inconsistências encontradas**: 14
**Distribuição por severidade**: 2 Críticas · 3 Altas · 5 Médias · 4 Baixas
**Maturidade estimada do repositório**: ~55% (governança/domínio/arquitetura/especificação maduros; infraestrutura/execução/implementação-alvo/testes ainda não iniciados — esperado nesta fase)
**Recomendação final**: **Aprovar com ressalvas**

---

# 2. Document Inventory

36 arquivos Markdown identificados no repositório.

## Governance (raiz + 00-governance)

| Documento | Caminho | Versão | Status |
|---|---|---|---|
| Document Control Protocol | .project-rules/DOCUMENT_CONTROL.md | 1.0.0 | Approved |
| Claude AI Development Protocol | CLAUDE.md | — (sem frontmatter) | Approved (implícito) |
| Universal AI Protocol | AGENTS.md | — (sem frontmatter) | Approved (implícito) |
| ENG-000 Engineering Handbook | Docs/00-governance/ENG-000-Engineering-Handbook.md | 1.0.0 | Approved |
| CONST-001 Constitution | Docs/00-governance/CONST-001-Constitution.md | 1.0.0 | Approved |
| VISION-001 Product Vision | Docs/00-governance/VISION-001-Product-Vision.md | 1.0.0 | Approved |

## Requirements

| REQ-001 Requirements Specification | Docs/01-requirements/REQ-001-Requirements-Specification.md | 1.0.0 | Approved |

## Domain

| Documento | Versão | Status |
|---|---|---|
| DOMAIN-001 Opportunity | 1.1.0 | Approved |
| DOMAIN-002 Ubiquitous Language | 1.3.0 | Approved |
| DOMAIN-003 Evidence | 1.0.0 | Approved |
| DOMAIN-004 Market Context | 1.1.0 | Approved |
| DOMAIN-005 Decision | 1.1.0 | Approved |

## Architecture

| ARCH-001 Architecture Blueprint | 1.2.0 | Approved |

## Specifications

| Documento | Versão | Status |
|---|---|---|
| SPEC-001 Component Model | 1.4.0 | Approved |
| SPEC-002 Interface Contracts | 1.1.0 | Approved |
| SPEC-003 Domain Services | 1.1.0 | Approved |
| SPEC-004 Application Services | 1.0.0 | Approved |
| SPEC-005 Domain Lifecycle | 1.0.0 | Approved |
| SPEC-006 Business Rules | 1.0.0 | Approved |

## ADRs (05-decisions)

| ADR-001 Legacy Baseline · ADR-002 Domain Evolution · ADR-003 Product Scope · ADR-004 Validation Strategy · ADR-005 Ubiquitous Language Refinement · ADR-006 Opportunity Lifecycle Alignment | todas 1.0.0 | todas Accepted |

## Reference / Legacy (documentam a V1 real; `08-reference/` formal está vazio)

| Documento | Caminho | Observação |
|---|---|---|
| Architecture (V1 congelada) | Docs/ARCHITECTURE.md | Estado real do código, Sprint 0 |
| Backlog e Ordem de Sprints | Docs/BACKLOG.md | Roadmap V1 congelado (Sprint 0.5) |
| Technical Debt | Docs/TECH_DEBT.md | Dívida técnica de código, não de documentação |
| Docs README | Docs/README.md | Guia de estrutura de pastas |

## Traceability / Meta

| Documento | Caminho |
|---|---|
| Document Index | DOCUMENT_INDEX.md |
| Changelog | CHANGELOG.md |
| Traceability Matrix | TRACEABILITY.md |
| Root README | README.md |

## Stubs vazios (0 bytes)

Docs/CHANGELOG.md · Docs/ROADMAP.md · Docs/VERSION.md — já reconhecidos como dívida em TECH_DEBT.md e DOCUMENT_INDEX.md.

## Pastas oficiais vazias (sem arquivo, git não rastreia diretório vazio)

`06-validation/` (agora recebe este próprio AUDIT-001), `07-testing/`, `08-reference/`, `09-roadmap/`, `10-rfc/`, e todas as subpastas de `knowledge/`.

---

# 3. Consistency Report (Fase 1)

## 3.1 IDs, versões, títulos, owner

Nenhum `id` duplicado encontrado. Todas as versões seguem SemVer. Todos os documentos com frontmatter usam `owner: Product Owner` — uniformemente, mesmo em documentos de natureza arquitetural que, por `ENG-000` (papéis: Product Owner / Chief Architect / Software Engineer / AI Agents), poderiam ser atribuídos a outro papel (ver Finding #12).

`CLAUDE.md`, `AGENTS.md` e `README.md` (raiz) não possuem frontmatter (`id`/`version`) — consistente com o restante do documento, mas significa que a regra "referenciar sempre por `id`" (AGENTS.md) não pode ser aplicada a esses três documentos nem ao próprio `DOCUMENT_CONTROL.md`.

## 3.2 depends_on / related — referências cruzadas

Todas as referências (`depends_on`/`related`) apontam para documentos que existem, com uma exceção conhecida e já sinalizada: `SPEC-006.related → SPEC-007` (não existe ainda; já registrado como pendência em `DOCUMENT_INDEX.md`).

Gap real encontrado: documentos cujo conteúdo foi alterado por um ADR posterior não tiveram o ADR adicionado ao seu próprio `depends_on` — ver Finding #10.

## 3.3 Duplicidade

Nenhuma duplicidade de conteúdo entre documentos ativos. Duplicidade apenas nos stubs vazios já conhecidos (`Docs/CHANGELOG.md`/`ROADMAP.md`/`VERSION.md` vs. raiz).

## 3.4 Documentos órfãos / nunca referenciados

`Docs/README.md` existe mas não está listado na tabela de `DOCUMENT_INDEX.md` (que se declara "índice oficial de **todos** os documentos"). Os três stubs vazios de `Docs/` também não aparecem na tabela — apenas na seção prosaica "Pendências conhecidas". Ver Finding #14.

## 3.5 Referências quebradas / estruturais

Três documentos descrevem três estruturas de pastas **diferentes** para o mesmo conceito (ADR/RFC), e nenhuma delas corresponde exatamente à estrutura real e estabilizada. Este é o achado mais importante da auditoria — ver Finding #1 e #2 na Seção 10.

---

# 4. Architecture Compliance (Fase 3)

Verificação contra ARCH-001 (autoridade única para camadas, bounded contexts, dependências e fluxos).

- **Nenhuma violação nova** de dependência proibida (Core Domain → MT5/Broker/Logger/File System/Indicators/APIs/Network) foi encontrada em nenhum documento SPEC/DOMAIN além das já conhecidas e explicitamente aceitas na Legacy Baseline (ADR-001), documentadas de forma consistente em ARCH-001, DOMAIN-003, SPEC-001 e TRACEABILITY.md.
- SPEC-003 (Domain Services) e SPEC-004 (Application Services) declaram corretamente suas dependências permitidas/proibidas, alinhadas a ARCH-001.
- **Achado real**: ARCH-001 define 4 Bounded Contexts (Core Domain, Infrastructure, **Strategy**, Execution), mas o Strategy Bounded Context não possui nenhum componente catalogado em SPEC-001 (que só define 6 categorias, nenhuma "Strategy Components"). Ver Finding #4.
- **Achado real**: ARCH-001 lista, como exemplo de Infrastructure, "Indicator Adapter" — mas SPEC-001 (catálogo canônico) nomeia o componente equivalente "Indicator Provider". DOMAIN-002 define Adapters e Providers como categorias distintas ("Adapters integram plataformas externas" vs. "Providers obtêm dados externos"), portanto não é apenas uma variação de escrita. Ver Finding #9.
- O fluxo oficial (`Indicators → Evidence → Market Context → Opportunity → Decision → Signal → Execution → Order`) é citado de forma idêntica em ARCH-001, ADR-005 e DOMAIN-001 — consistente.

---

# 5. Domain Compliance (Fase 2)

Verificação contra DOMAIN-002 (fonte oficial de vocabulário).

- Nenhum termo do vocabulário oficial foi redefinido de forma contraditória em outro documento. As definições de Opportunity, Market Context, Evidence, Decision, Confidence, Strategy, Signal, Indicator, Adapter, Domain Service e Infrastructure Service são consistentes entre DOMAIN-002 e os documentos DOMAIN-001/003/004/005 que as utilizam.
- O único estado contraditório identificado no projeto (ciclo de vida da Opportunity, DOMAIN-001 vs. SPEC-005 v1.0) já foi resolvido pelo ADR-006 antes desta auditoria — nenhum documento remanescente contém `Opportunity Executed`, `Opportunity Closed` ou `Opportunity Archived` (validado por busca completa em `Docs/`).
- **Achado real — Value Object implícito**: "Risk Profile" é citado em DOMAIN-001 (atributo `Risk`), DOMAIN-002 (vocabulário), SPEC-001 e SPEC-003 (saída do Risk Service), mas não possui um documento DOMAIN-00X próprio — é o único conceito de domínio citado repetidamente sem especificação formal (atributos, BR, invariantes). Ver Finding #3.
- **Achado real — sinônimos não unificados**: "Evidence Set" (DOMAIN-001, atributo de Opportunity) e "Evidence Collection" (DOMAIN-004, atributo de Market Context) descrevem o mesmo conceito (uma coleção de Evidence) com nomes diferentes; nenhum dos dois está definido em DOMAIN-002. Ver Finding #7.
- **Achado real — classificação DDD implícita**: nenhum documento declara explicitamente se Opportunity, Evidence e Decision são Entities, Value Objects ou Aggregates — apenas Market Context é explicitamente rotulado "Aggregate Root" (DOMAIN-004). Evidence e Decision usam a frase "objeto de domínio imutável" (sugerindo Value Object), enquanto Opportunity é chamada de "entidade central do domínio" (Entity), mas também é declarada imutável após aprovação (BR-006) — uma característica mais típica de Value Object. `CLAUDE.md`/`AGENTS.md` exigem "respeitar rigorosamente" essa classificação DDD, mas ela nunca é feita de forma explícita.

---

# 6. Specification Compliance (Fase 4 e 5)

## 6.1 Matriz de Componentes (SPEC-001)

| Categoria | Componentes | Duplicados | Não definidos mas usados | Definidos mas nunca usados |
|---|---|---|---|---|
| Core Domain Builders | Evidence Builder, Market Context Builder | Nenhum | Nenhum | Nenhum |
| Core Domain Services | Opportunity Service, Decision Service, Confidence Service, Risk Service | Nenhum | Nenhum | Nenhum |
| Domain Policies | Context Validation Policy, Evidence Validation Policy | Nenhum | Nenhum | Nenhum |
| Application Services | 5 Use Cases (Analyze Market, Validate Context, Evaluate Opportunity, Generate Decision, Publish Signal) | Nenhum | Nenhum | Nenhum |
| Infrastructure Providers | Data, Indicator, Configuration, Time, Persistence Provider, Logger | Nenhum | Nenhum | Time Provider, Persistence Provider (Future — sem consumidor definido, esperado) |
| Execution Components | Signal Builder, Order Manager, Position Manager, Broker Adapter, MT5 Adapter | Nenhum | Nenhum | Position Manager, Broker Adapter (Future — sem contrato SPEC-002, esperado) |

Nenhum componente duplicado ou "usado mas nunca definido" foi encontrado — a estabilização de taxonomia (SPEC-001/002/003) realizada anteriormente nesta sessão se mostrou efetiva.

## 6.2 Cobertura de contratos (SPEC-002)

SPEC-002 define contratos formais para 8 dos ~20 componentes do catálogo (Data Provider, Indicator Provider, Evidence Builder, Market Context Builder, Opportunity Service, Decision Service, Signal Builder, Order Manager). Confidence Service e Risk Service (Core Domain Services) e as 5 Application Services não possuem um contrato formal equivalente em SPEC-002 — aceitável para componentes `Planned`/`Future`, mas Confidence Service já está listado como `Implemented` (informal) em SPEC-001 sem contrato correspondente.

## 6.3 Responsabilidade única

Cada Domain Service (SPEC-003) e Application Service (SPEC-004) possui responsabilidade única e não sobreposta.

**Achado real (confiança baixa/média)**: SPEC-003 declara a entrada do Confidence Service como `Evidence Collection, Market Context`; o fluxo do Generate Decision Use Case em SPEC-004 desenha `Opportunity → Confidence Service → Risk Service → Decision Service`, sugerindo que Confidence Service consome uma Opportunity. Pode ser apenas notação informal de ordem de orquestração (mesmo estilo usado em todos os diagramas de fluxo do projeto), não necessariamente uma contradição de contrato — sinalizado para esclarecimento, não como defeito confirmado.

## 6.4 Sobreposição/redundância entre Specifications

Nenhuma Specification redundante. A sobreposição aparente entre SPEC-001 (catálogo) e SPEC-003 (detalhamento dos 4 Domain Services) é intencional e declarada explicitamente em ambos os documentos. SPEC-004 e SPEC-005 reutilizam os mesmos 5 Use Cases sem redefini-los.

---

# 7. ADR Compliance (Fase 6)

Todas as 6 ADRs continuam válidas; nenhuma foi revogada implicitamente; nenhum conflito direto entre ADRs foi encontrado.

**Achado real**: ADR-004 (Validation Strategy) substitui a exigência de "testes unitários obrigatórios" por um pipeline de validação de 7 níveis, e nomeia explicitamente `ENG-000` como documento que deve ser lido em conjunto. Porém `CLAUDE.md` e `AGENTS.md` — os dois protocolos operacionais que instruem agentes de IA diretamente — continuam a exigir literalmente "Testes Unitários"/"Testes de Integração" em suas seções de Testes, sem qualquer referência ao ADR-004. Ver Finding #5.

Nenhum documento viola ADR-001 (nenhuma refatoração retroativa foi proposta ou realizada) nem ADR-002/003 (nenhuma tentativa de renomear `MarketAssessment`/`TradingSignal` na V1, nenhuma alteração da configuração intraday).

---

# 8. Traceability Report (Fase 7)

| Verificação | Resultado |
|---|---|
| Todo DOMAIN está referenciado | ✔ Sim (DOMAIN-001 a 005 referenciados em ARCH-001, SPEC-00X e TRACEABILITY.md) |
| Todo SPEC possui origem | ✔ Sim (SPEC-001 a 006 rastreiam a ARCH-001/DOMAIN via `depends_on` e narrativa em TRACEABILITY.md) |
| Todo ADR possui impacto documentado | ~ Parcial — ADR-001, 002, 003, 005, 006 têm narrativa própria em TRACEABILITY.md; **ADR-004 não possui nenhuma entrada narrativa em TRACEABILITY.md**, aparecendo apenas na tabela do DOCUMENT_INDEX.md. |
| Todo componente possui origem documental | ✔ Sim, via tabela "Component Lifecycle" do SPEC-001 |
| Toda regra possui responsável | ~ Parcial — todo documento usa `owner: Product Owner` uniformemente, mesmo onde ENG-000 sugere outro papel (Chief Architect para arquitetura) |
| Toda entidade possui documentação | ~ Parcial — Opportunity/Market Context/Evidence/Decision sim; Risk Profile não (Finding #3) |

---

# 9. Coverage Matrix (Fase 8)

Estimativas baseadas exclusivamente em evidência documental (não em suposições externas).

| Categoria | Concluído | Parcial | Ausente | Observação |
|---|---|---|---|---|
| Governance | 100% | 0% | 0% | ENG-000/CONST-001/VISION-001/DOCUMENT_CONTROL completos como documentos (inconsistências entre si tratadas como Debt, não como lacuna de cobertura) |
| Requirements | 100% | 0% | 0% | REQ-001 cobre 12 REQ + 8 NFR |
| Domain | 85% | 15% | 0% | Risk Profile sem DOMAIN-00X próprio |
| Architecture | 100% | 0% | 0% | ARCH-001 completo como documento (gap do Strategy Bounded Context tratado na Seção 6 como Debt) |
| Specifications | 60% | 30% | 10% | Contratos (SPEC-002) cobrem ~8 de ~20 componentes; Strategy sem categoria no catálogo |
| Infrastructure | 20% | 20% | 60% | Providers hoje informais/acoplados; Time/Persistence Provider sem modelo concreto |
| Execution | 20% | 0% | 80% | Só Signal Builder implementado (informal); Order/Position Manager e Broker Adapter não implementados |
| MT5 | 0% | 20% | 80% | Sem MT5 Adapter isolado; acesso disperso em cada serviço (violação já aceita via ADR-001) |
| Implementation (arquitetura-alvo) | 0% | 0% | 100% | Nenhum componente do modelo-alvo (Opportunity/Decision/Market Context Aggregate/Application Services/Policies) foi implementado em código MQL5 — apenas documentado. A V1 Legacy (Trend/ATR/RSI/ADX/Session/Pivot/MarketAssessment/SignalBuilder/Dashboard) está 100% implementada, mas é um modelo à parte (ADR-001/002) |
| Testing | 15% | 15% | 70% | Apenas o estágio "Compilation" (MetaEditor CLI) é aplicado sistematicamente; "Strategy Tester" tocado parcialmente no RC1 (validação visual manual); Walk Forward/Demo/Production não iniciados |

**Maturidade global estimada**: ~55%, refletindo um projeto com base de governança/domínio/arquitetura/especificação madura, mas com a Fase 2 (Infrastructure/Execution/Implementation/Testing) integralmente à frente — consistente com o momento declarado do projeto.

---

# 10. Technical Debt (Fase 9)

Apenas problemas reais, verificados por leitura direta. Nenhuma melhoria hipotética.

## Crítico

**#1 — CLAUDE.md e AGENTS.md contradizem-se na ordem de precedência documental.**
Documento: `CLAUDE.md` (seção "Prioridade dos documentos") vs. `AGENTS.md` (seção "Ordem de precedência").
Descrição: CLAUDE.md ordena `... 3. ADRs → 4. ARCH → 5. DOMAIN → 6. SPEC ...`; AGENTS.md ordena `... 3. ADR → 4. DOMAIN → 5. ARCH → 6. SPEC ...`. A posição de ARCH e DOMAIN está invertida entre os dois documentos.
Impacto: um agente seguindo CLAUDE.md resolveria um conflito DOMAIN-vs-ARCH de forma oposta a um agente seguindo AGENTS.md — exatamente o cenário que uma ordem de precedência existe para prevenir.
Recomendação: unificar a ordem em ambos os documentos (registrar a escolha, já que AGENTS.md é o mais recentemente mantido) — requer atualização de documento, não código.

**#2 — DOCUMENT_CONTROL.md (maior precedência declarada) referencia uma estrutura de pastas que não existe.**
Documento: `.project-rules/DOCUMENT_CONTROL.md` (Regra 14, Regra 15) vs. `AGENTS.md`/`DOCUMENT_INDEX.md` (estrutura real).
Descrição: Regra 14 diz que toda decisão arquitetural vai em `docs/adr/`; Regra 15 diz que toda RFC vai em `docs/rfc/`. A estrutura real e estabilizada usa `05-decisions/` e `10-rfc/`. `CLAUDE.md` tem uma **terceira** variante (`08-adr/`, `09-rfc/`, e nem sequer lista `01-requirements/`) — três documentos, três estruturas diferentes.
Impacto: o documento com autoridade declarada como suprema sobre gestão documental (`DOCUMENT_CONTROL.md`, item 1 na ordem de precedência de ambos CLAUDE.md e AGENTS.md) instrui a criar arquivos em pastas que não existem.
Recomendação: atualizar Regra 13-15 de DOCUMENT_CONTROL.md e a seção "Estrutura oficial" de CLAUDE.md para refletir exatamente a estrutura já vigente em AGENTS.md/DOCUMENT_INDEX.md.

## Alto

**#3 — "Risk Profile" é um Value Object implícito, sem documento DOMAIN-00X próprio.**
Documento: citado em DOMAIN-001, DOMAIN-002, SPEC-001, SPEC-003 — nunca especificado.
Impacto: Risk Service (REQ-009, hoje não atendido) não tem contrato formal de saída para orientar sua futura implementação, diferente de todo outro conceito de domínio (Evidence/Market Context/Decision, cada um com seu DOMAIN-00X).
Recomendação: criar um documento DOMAIN dedicado a Risk Profile antes de mover Risk Service de `Planned` para implementação.

**Status: Architectural Gap** (registrado em RC-001). Risk Profile ainda não possui classificação definitiva (Entity, Value Object ou Aggregate) nem documento DOMAIN-00X próprio. Item formalmente rastreado em `Docs/10-rfc/RFC-001-Risk-Profile-Classification.md`, classificado **Requires Architectural Decision**. Nenhum DOMAIN ou SPEC novo foi criado para preencher esta lacuna — por decisão explícita do RC-001, a lacuna é registrada e adiada para decisão futura do Product Owner/Chief Architect, não resolvida unilateralmente.

**#4 — O Bounded Context "Strategy" (ARCH-001) não possui nenhum componente catalogado em SPEC-001.**
Documento: ARCH-001 (seção "Strategy") vs. SPEC-001 (Organização — 6 categorias, nenhuma "Strategy").
Impacto: um quarto da arquitetura oficial não tem componentes rastreáveis, nem status no Component Lifecycle.
Recomendação: adicionar categoria "Strategy Components" ao SPEC-001, ou formalizar via ADR que Strategy vive dentro de Application Services/Configuration sem componentes próprios.

**#5 — ADR-004 (Validation Strategy) não está referenciado em CLAUDE.md/AGENTS.md.**
Documento: ADR-004 vs. `CLAUDE.md`/`AGENTS.md` (seções "Testes").
Impacto: os dois protocolos que instruem agentes de IA diretamente continuam exigindo "Testes Unitários"/"Testes de Integração" literalmente, contradizendo a reinterpretação já aceita pelo ADR-004 (pipeline de validação substituto, dado que MQL5 não possui framework de teste unitário).
Recomendação: adicionar uma referência a ADR-004 nas seções "Testes" de CLAUDE.md e AGENTS.md.

## Médio

**#6 — Numeração de Business Rules duplicada sem mapeamento.** SPEC-006 (`BR-1xx`...`BR-5xx`, global) coexiste com DOMAIN-001/005 (`BR-001`...`BR-006`, local por entidade) sem tabela de correspondência declarada (já autoidentificado no momento da criação do SPEC-006, registrado em TRACEABILITY.md).

**#7 — "Evidence Set" (DOMAIN-001) vs. "Evidence Collection" (DOMAIN-004)**: dois nomes para o mesmo conceito (coleção de Evidence), nenhum definido em DOMAIN-002.

**#8 — Ambiguidade no fluxo do Confidence Service** entre SPEC-003 (entrada declarada: Evidence Collection + Market Context) e o diagrama de fluxo do SPEC-004 (sugere consumo de Opportunity). Provavelmente apenas notação informal de ordem, não contradição de contrato — recomenda-se apenas uma nota de esclarecimento.

**#9 — "Indicator Adapter" (ARCH-001) vs. "Indicator Provider" (SPEC-001)**: nomes diferentes para o mesmo componente, e DOMAIN-002 trata Adapter e Provider como categorias distintas — não é apenas variação de escrita.

**#10 — `depends_on` desatualizado após ADRs recentes.** DOMAIN-001 (alterado pelo ADR-006) ainda lista apenas `[REQ-001, ADR-002]`; DOMAIN-002 (alterado por ADR-005 e ADR-006) lista apenas `[REQ-001, DOMAIN-001]`; ARCH-001 (alterado por ADR-006) não lista nenhum ADR em `depends_on`.

## Baixo

**#11** — `SPEC-006.related → SPEC-007` aponta para documento inexistente — já rastreado como pendência conhecida em DOCUMENT_INDEX.md, não é uma quebra silenciosa.

**#12** — `owner: Product Owner` uniforme em todos os documentos, mesmo onde ENG-000 sugere outro papel (ex.: Chief Architect para ARCH-001/SPEC-00X).

**#13** — Root `README.md` ainda descreve a árvore "planejada" original (pastas `Decision/`/`Execution/`, `SignalService.mqh`, `Dashboard/DashboardService.mqh`) divergente do código real — já reconhecido e superado explicitamente por `Docs/ARCHITECTURE.md` (Sprint 0); não é um achado novo, apenas confirmado.

**#14** — `DOCUMENT_INDEX.md` se declara "índice oficial de todos os documentos", mas sua tabela não lista `Docs/README.md` nem os três stubs vazios de `Docs/` (aparecem só na prosa de "Pendências conhecidas").

---

# 11. Risks

- **Risco de execução inconsistente por agentes de IA** (decorre de #1 e #2): enquanto CLAUDE.md/AGENTS.md/DOCUMENT_CONTROL.md discordarem entre si, diferentes agentes (ou o mesmo agente em sessões diferentes) podem tomar decisões de resolução de conflito documental diferentes. É o risco mais alto identificado nesta auditoria.
- **Risco de retrabalho em Risk Service**: implementar Risk Service sem um DOMAIN-00X formal (#3) tende a gerar um modelo ad-hoc que precisará ser revisado quando a especificação for eventualmente escrita.
- **Risco de escopo invisível em Strategy**: sem componentes catalogados (#4), decisões de parametrização/estratégia podem acabar implementadas informalmente dentro de Application Services ou Config, sem rastreabilidade — repetindo o mesmo padrão que já gerou a Legacy Baseline (ADR-001).
- **Risco baixo, mas presente, de teste insuficiente**: a lacuna entre ADR-004 e CLAUDE.md/AGENTS.md (#5) pode levar um agente a pular etapas do pipeline de validação por desconhecê-lo, ou a exigir testes unitários inexistentes/inviáveis em MQL5.

Nenhum risco de perda de dados, nenhum risco de segurança, nenhum risco que comprometa a Legacy Baseline (V1) foi identificado — o congelamento arquitetural (ADR-001, Sprint 0.5) continua integralmente respeitado por toda a documentação.

---

# 12. Recommended Next Phase

Conforme já orientado pelo Product Owner: após o congelamento desta auditoria (Fase 1 documental),

1. Corrigir apenas as inconsistências Críticas (#1, #2) e Altas (#3, #4, #5) listadas na Seção 10.
2. Gerar `AUDIT-001-CLOSURE.md` registrando exatamente quais correções foram efetuadas.
3. Criar uma tag no repositório (ex.: `architecture-baseline-v1.0`) marcando este ponto como baseline arquitetural.
4. Só então iniciar a Fase 2 (Infrastructure e MT5 Integration), que hoje está 0-20% coberta (Seção 9) e é o próximo passo natural do roadmap.

Os itens Médios e Baixos (#6 a #14) não bloqueiam a Fase 2 e podem ser corrigidos em paralelo ou posteriormente, sem urgência.

---

# 13. Checklist Final

| Item | Status |
|---|---|
| Governança completa (ENG-000/CONST-001/VISION-001/DOCUMENT_CONTROL) | ✔ |
| Requisitos completos (REQ-001) | ✔ |
| Domínio completo e sem estados contraditórios (DOMAIN-001 a 005) | ✔ (após ADR-006) |
| Arquitetura completa e sem violação de dependência não aceita (ARCH-001) | ✔ |
| Catálogo de componentes sem duplicidade (SPEC-001) | ✔ |
| Todas as Specifications sem redundância (SPEC-001 a 006) | ✔ |
| Todas as ADRs válidas, sem conflito entre si (ADR-001 a 006) | ✔ |
| Rastreabilidade REQ→DOMAIN→ARCH→SPEC íntegra | ✔ |
| Protocolos de agente de IA (CLAUDE.md/AGENTS.md) consistentes entre si | ✘ (Finding #1) |
| Estrutura de pastas consistente entre todos os documentos que a descrevem | ✘ (Finding #2) |
| Todos os conceitos de domínio citados possuem especificação própria | ~ (Finding #3 — Risk Profile) |
| Todos os Bounded Contexts possuem componentes catalogados | ~ (Finding #4 — Strategy) |
| Zero inconsistência crítica ou alta pendente | ✘ (2 críticas + 3 altas pendentes) |

**Recomendação final: Aprovar com ressalvas.** O núcleo do domínio e da arquitetura está pronto para orientar a implementação da Fase 2. As correções Críticas e Altas devem ser feitas antes de ampliar o trabalho assistido por IA, para eliminar o risco de instruções conflitantes entre os próprios documentos de protocolo.
