---
id: DOMAIN-006
title: Knowledge Model
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-010
  - ARCH-001
related:
  - ADR-008
  - DOMAIN-003
  - DOMAIN-004
  - VALIDATION-001
last_updated: 2026-07-21
---

# Knowledge Model

Primeiro documento formal do Learning Domain (Bounded Context criado por `ADR-010`). Este documento **não toma decisões arquiteturais** — modela o conceito de Knowledge dentro do contexto e das fronteiras já aprovadas.

---

# Objetivo

Definir formalmente o conceito de `Knowledge` dentro do Learning Domain. `Knowledge` é modelado aqui como o principal ativo persistente desse domínio — sua definição, princípios, ciclo de vida e relações com os demais conceitos já existentes no TradingOS.

---

# Motivação

O TradingOS opera em duas trilhas evolutivas permanentes — Execução e Conhecimento — sendo a segunda estruturada por `ADR-008` em Platform → Validation → Learning. Até este documento, "Conhecimento" carecia de um modelo formal: sem ele, não há como especificar de forma consistente como o sistema registra, versiona e reutiliza o que aprende com sua própria experiência operacional. Este documento preenche essa lacuna.

---

# Escopo

Este documento define:

- o que é `Knowledge` (definição conceitual);
- seus princípios obrigatórios;
- seu ciclo de vida e estados;
- suas relações com `Validation`, `Evidence`, `Outcome`, `Learning` e `Platform`;
- as regras arquiteturais que preservam o isolamento do Learning Domain.

---

# Fora do Escopo

Este documento **não**:

- define algoritmos de aprendizado, técnicas de Inteligência Artificial ou Machine Learning — `ADR-010` já restringiu isso explicitamente ("Não introduzir IA");
- define a estrutura física de armazenamento do `Knowledge` — decisão de infraestrutura futura, não antecipada aqui;
- altera qualquer componente do Core Domain, Platform ou Execution;
- cria ou registra qualquer componente novo no Canonical Component Catalog (`SPEC-001`).

---

# Definição de Knowledge

`Knowledge` é um objeto de domínio do Learning Domain que representa conhecimento consolidado, obtido a partir de resultados observados e validados pela Validation.

`Knowledge` **não** é uma decisão operacional, **não** é uma `Evidence` (`DOMAIN-003`), e **não** participa da execução. Ele existe para registrar, de forma persistente e reutilizável, o que o sistema aprendeu sobre o comportamento do mercado a partir de experiência real — nunca de especulação.

---

# Princípios

`Knowledge` deve ser:

- **Persistente** — não é descartado após uso;
- **Versionável** — cada revisão é rastreável até a anterior;
- **Auditável** — sua origem (quais `Outcome`/execuções de `Validation` o geraram) é sempre reconstituível;
- **Reproduzível** — o mesmo conjunto de `Outcome` deve sempre produzir o mesmo `Knowledge`;
- **Explicável** — nunca uma "caixa preta"; sempre acompanhado de justificativa;
- **Independente da implementação** — o modelo conceitual não pressupõe uma tecnologia de armazenamento ou aprendizado específica;
- **Baseado exclusivamente em evidências validadas** — nunca em hipótese não testada.

---

# Responsabilidades

`Knowledge` deve:

- consolidar resultados validados (`Outcome`) em conhecimento reutilizável;
- preservar rastreabilidade completa até sua origem;
- permitir versionamento e auditoria;
- estar disponível para consumo pelo `Learning`, para evolução futura dos modelos, sem exigir alteração da Platform.

---

# Não Responsabilidades

`Knowledge` **nunca**:

- executa operações;
- gera ordens;
- altera diretamente o comportamento da Platform;
- substitui `Evidence` (`DOMAIN-003`, Core Domain);
- representa uma `Decision` (`DOMAIN-005`, Core Domain);
- toma qualquer decisão operacional.

---

# Ciclo de Vida

```
Proposed
↓
Validated
↓
Published
↓
Superseded
```

Nem todos os estados precisam existir na implementação inicial. Nenhum `Knowledge` é apagado — quando substituído, transita para `Superseded`, preservado para auditoria (mesmo princípio de retenção já aplicado a documentos pelo `DOCUMENT_CONTROL`, Regra 10).

---

# Estados Possíveis

### Proposed

Candidato a conhecimento, levantado a partir de um ou mais `Outcome`, ainda não consolidado nem confirmado.

---

### Validated

Confirmado como consistente e reproduzível a partir de múltiplos `Outcome`/execuções de `Validation` — deixou de ser hipótese isolada.

---

### Published

Disponibilizado formalmente para consumo pelo `Learning`.

---

### Superseded

Substituído por um `Knowledge` mais recente ou mais preciso — mantido para auditoria, nunca removido.

---

# Fontes de Criação

`Knowledge` só pode ser criado a partir de resultados produzidos pela `Validation` (`Outcome`) — nunca diretamente da Platform, nunca por especulação sem dado observado. Fontes válidas hoje: `BACKTEST-001`; futuramente, `WALKFORWARD-001`, `FORWARDTEST-001`, `EDGE-REPORT-001` (todos sob `VALIDATION-001`).

---

# Relação com Validation

`Knowledge` consome exclusivamente os resultados já produzidos pela Validation (Trilha 2, `ADR-008`). `Outcome` é a unidade de resultado que a Validation produz e que o Learning Domain consome para gerar `Knowledge`. Esta é a única fonte de entrada do Learning Domain, conforme já estabelecido em `ADR-010` ("Relação com Validation").

---

# Relação com Evidence

`Evidence` (`DOMAIN-003`) é um conceito do Core Domain, usado para compor um `Market Context` e avaliado antes de qualquer `Decision`. `Knowledge` **não depende de `Evidence` diretamente e não a substitui**: `Knowledge` é gerado a partir de `Outcome` (resultado já observado e validado), não da `Evidence` bruta que alimentou a decisão original. Qualquer relação entre os dois é indireta, mediada por `Outcome` — nunca uma dependência direta do Learning Domain sobre o Core Domain, conforme `ADR-010` ("Relação com Core Domain: Nenhuma").

---

# Relação com Outcome

`Outcome` representa o resultado observável e validado de uma execução (real, backtest, ou simulação), produzido exclusivamente pela `Validation`. `Outcome` é a matéria-prima do `Knowledge` — sem `Outcome`, não pode existir `Knowledge`. Um `Outcome` isolado não é `Knowledge`; `Knowledge` emerge da consolidação de um ou mais `Outcome` ao longo do tempo.

---

# Relação com Learning

`Learning` (Trilha 3, `ADR-008`) é o processo/mecanismo — ainda não implementado, citado como "Futura Evolução" em `INFRA-001`/`INFRA-002` — que consome `Knowledge` para evoluir os modelos do sistema. `Knowledge` é o ativo que `Learning` consome; `Learning` é quem usaria esse ativo para propor mudanças futuras de comportamento, o que exigirá suas próprias decisões arquiteturais quando chegar o momento — não antecipadas por este documento.

---

# Relação com Platform

Nenhuma direta. Conforme `ADR-010`, o Learning Domain não se comunica com a Platform (Infrastructure/Execution/MT5) em nenhuma direção. `Knowledge` nunca altera diretamente o comportamento da Platform — qualquer influência futura ocorreria por uma camada intermediária (ex.: parametrização revisada por decisão humana), nunca por acesso direto.

---

# Casos de Uso

- Consolidar múltiplos `Outcome` de backtests da mesma estratégia em um `Knowledge` sobre em quais condições de mercado ela performa melhor ou pior.
- Registrar que um determinado parâmetro (ex.: multiplicador de ATR usado no stop) mostrou-se inconsistente entre regimes de mercado diferentes, como `Knowledge` disponível para uma futura revisão de `RFC-005`.
- Preservar auditabilidade: permitir que um `Knowledge` em estado `Published` seja rastreado até os `Outcome`/execuções de `Validation` que o originaram.

---

# Exemplos Conceituais

- *"A estratégia validada em `BACKTEST-001` apresentou Profit Factor > 1.2 em regime de baixa volatilidade e < 1.0 em alta volatilidade"* — um candidato a `Knowledge` (`Proposed`), pendente de mais `Outcome` para se tornar `Validated`.
- *"O parâmetro de Stop ATR recomendado em `RFC-005` (1.5×) não se sustentou em walk-forward"* — `Knowledge` que alimentaria uma futura revisão de `RFC-005`, sem que o Learning Domain tenha autoridade para alterá-la diretamente — isso continua exigindo decisão humana formal (ADR/RFC).

---

# Regras Arquiteturais

- `Knowledge` nunca executa operações.
- `Knowledge` nunca gera ordens.
- `Knowledge` nunca altera diretamente o comportamento da Platform.
- `Knowledge` somente pode ser criado a partir de resultados produzidos pela `Validation` (`Outcome`).
- `Knowledge` pode ser consumido pelo `Learning` para evolução futura dos modelos — `Learning` em si permanece não implementado ("Futura Evolução").
- Nenhuma regra aqui cria dependência do Learning Domain sobre o Core Domain, a Platform ou a Execution.

---

# Dependências

## Permitidas

- `Validation` (Trilha 2, `ADR-008`) — única fonte de `Outcome`.

## Proibidas

- Core Domain (`Evidence`/`Market Context`/`Opportunity`/`Decision`);
- Platform (Infrastructure/Execution/MT5).

Nenhuma dependência direta, em qualquer direção, conforme `ADR-010`.

---

# Impacto Esperado

Nenhum impacto na Release 1.0 (`ROADMAP-001` a `005`, `EXEC-001` a `EXEC-005`) — `Knowledge` é, por definição, posterior e paralelo. O impacto esperado ocorre em releases futuras, quando `Learning Engine`/`Knowledge Repository` (já citados em `INFRA-001`/`INFRA-002` como "Futura Evolução") forem especificados e implementados, consumindo o modelo aqui definido.

---

# Critérios de Aceite

Este documento está corretamente especificado quando:

- `Knowledge` está definido sem depender de nenhum componente do Core Domain, da Platform ou da Execution;
- o ciclo de vida e os estados de `Knowledge` estão claros e não se sobrepõem aos de `Evidence`/`Market Context`/`Decision` (`DOMAIN-003`/`004`/`005`);
- nenhum componente novo foi adicionado ao Canonical Component Catalog (`SPEC-001`);
- a Release 1.0 permanece inteiramente não afetada.

---

# Rastreabilidade

`ADR-010` (Learning Domain — Bounded Context) · `ARCH-001` (seção Learning Domain) · `ADR-008` (Trilhas Platform/Validation/Learning) · `DOMAIN-003` (Evidence — relação indireta) · `DOMAIN-004` (Market Context — contexto de referência) · `VALIDATION-001`/`BACKTEST-001` (fonte de `Outcome`).
