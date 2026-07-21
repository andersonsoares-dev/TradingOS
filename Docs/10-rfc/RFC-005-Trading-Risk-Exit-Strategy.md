---
id: RFC-005
title: Trading Risk & Exit Strategy
version: 1.0.0
status: Open
owner: Product Owner
depends_on:
  - VALIDATION-001
  - ADR-008
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-005: Trading Risk & Exit Strategy

**Nota de numeração**: este documento foi solicitado originalmente como `RFC-004-Trading-Risk-Exit-Strategy.md`. O id `RFC-004` já está em uso (`Legacy Indicator Mapping Ambiguity`, criado durante `INFRA-003`) — sem sobreposição de conteúdo, apenas colisão de numeração. Renumerado para `RFC-005`.

## Classificação

Requires Architectural Decision (análise apenas — nenhuma decisão tomada neste documento)

## Status

Open — análise para futura aprovação via ADR.

---

## Objetivo

Identificar e comparar alternativas de gerenciamento de risco e saída de posição que permitam executar o primeiro ciclo completo de Backtest e Forward Test (`VALIDATION-001`). Este documento **não decide** — apresenta alternativas, comparativo e uma recomendação, que deverá ser aprovada por ADR próprio antes de se tornar decisão arquitetural ou ser incorporada a `DOMAIN`/`SPEC`.

---

## Contexto

O fluxo atual cobre exclusivamente a Entrada (`Opportunity → Decision → Signal`, conforme `ARCH-001`/`DOMAIN-001`/`DOMAIN-005`). Não existe, em nenhum documento da Baseline, definição formal para:

- Stop Loss;
- Take Profit;
- Position Sizing;
- Break-even;
- Trailing Stop;
- Time Exit.

`VALIDATION-001` (Trilha 2 — Validation, `ADR-008`) depende dessas definições para poder executar `BACKTEST-001`: sem uma regra de saída, não é possível simular o resultado de uma operação, apenas o sinal de entrada.

`Risk Service` (`SPEC-001`, status `Planned`) e `REQ-009` (avaliação de risco, não atendido) são os pontos de ancoragem arquitetural onde uma decisão futura, se aprovada, deverá ser implementada — este documento não altera nenhum dos dois.

---

## Alternativas de Saída (Exit Strategy)

| Alternativa | Vantagens | Desvantagens | Complexidade | Impacto em Backtest | Impacto na Arquitetura |
|---|---|---|---|---|---|
| **1. Stop Loss Fixo** (distância fixa em pontos/pips) | Extremamente simples; determinístico; fácil de auditar e explicar | Não se adapta à volatilidade — mesmo stop é largo demais em mercado calmo e apertado demais em mercado volátil | Baixa | Mínimo — um único parâmetro, fácil de simular | Nenhum componente novo; um parâmetro em `Configuration Provider` |
| **2. Stop baseado em ATR** (múltiplo do ATR atual) | Adapta-se à volatilidade do momento; reaproveita `Indicator Provider` (`GetATR()`, já especificado em `INFRA-003`) | Exige escolher um multiplicador (ex.: 1.5×ATR), risco de overfit ao período testado | Média | Recalcula ATR por barra simulada — dependência adicional de `Indicator Provider` no backtest, mas já disponível | Nenhum componente novo — reaproveita `Indicator Provider` |
| **3. Stop por Estrutura de Mercado** (swing high/low, suporte/resistência) | Mais alinhado a price action; potencialmente melhor razão risco/retorno | Exige lógica de detecção de estrutura inexistente hoje; definição de "estrutura" pode ser ambígua, prejudicando reprodutibilidade | Alta | Difícil de tornar determinístico sem regras muito específicas; maior risco de resultado de backtest não reproduzível | Poderia exigir um Provider/Service novo (não catalogado em `SPEC-001` hoje) — qualquer materialização exigiria RFC própria |
| **4. Stop Temporal** (encerrar após N barras/horas) | Simples, determinístico; elimina posições presas indefinidamente | Ignora o movimento de preço isoladamente — pode fechar operação vencedora cedo ou perdedora tarde | Baixa | Trivial de simular (contagem de barras) | Nenhum componente novo — usa `Time Provider` já catalogado |
| **5. Trailing Stop** | Protege lucro conforme o preço avança a favor; não exige prever o topo/fundo do movimento | Pode encerrar prematuramente em pull-backs normais; exige atualização contínua | Média a Alta (maior se combinado com ATR) | Exige simulação mais fiel (intrabar/tick) para não superestimar resultado | Nenhum componente novo obrigatório, mas mais exigente sobre granularidade do `Data Provider` (`INFRA-002`) |
| **6. Break-even** (mover stop para entrada após certo avanço) | Elimina risco de perda após avanço favorável; combina com qualquer stop acima | Pode transformar operações levemente vencedoras em resultado zero que seriam lucrativas se deixadas correr | Baixa a Média | Fácil de simular como regra adicional sobre qualquer stop | Nenhum componente novo — regra a aplicar dentro de um futuro `Risk Service` |

---

## Position Sizing

| Alternativa | Vantagens | Desvantagens |
|---|---|---|
| **Lote Fixo** | Extremamente simples; fácil de auditar | Não escala com capital nem com o risco real da operação — mesmo lote em stop apertado e largo representa risco monetário muito diferente |
| **Percentual de Capital** | Escala com o capital total | Não considera a distância do stop — risco monetário real ainda varia conforme o stop escolhido |
| **Percentual por Risco** (sizing calculado a partir da distância do stop, para que a perda máxima equivalha a X% do capital) | Risco monetário constante e controlado por operação — abordagem padrão em gestão de risco discricionária e sistemática | Mais complexo de calcular (depende de valor de pip/tick, distância do stop, capital atual) |
| **Volatilidade (ATR)** | Normaliza risco entre ativos e períodos de volatilidade distintos; dimensiona posição inversamente à volatilidade | Camada de cálculo adicional; depende de ATR já disponível (`Indicator Provider`, `INFRA-003`) |

---

## Critérios de Avaliação (para seleção futura)

Estes critérios não decidem a alternativa — servem para orientar a decisão que será tomada em ADR próprio:

- **Simplicidade** — quão direto é entender e auditar a regra.
- **Reprodutibilidade** — mesmo histórico e parâmetros devem sempre produzir o mesmo resultado de backtest.
- **Baixa complexidade** — menor número de componentes/dependências novas necessárias.
- **Compatibilidade com MT5** — viável de implementar com os dados e o Strategy Tester do MT5, sem depender de infraestrutura ainda não especificada.
- **Facilidade de Backtest** — quão bem a alternativa se presta a uma primeira rodada de validação (`BACKTEST-001`) sem exigir dados de altíssima granularidade (tick a tick) logo de início.

---

## Recomendação para a Release 1.0 (MVP)

**Esta é uma recomendação, não uma decisão arquitetural.** Deverá ser aprovada por ADR próprio antes de influenciar `DOMAIN`, `SPEC` ou qualquer implementação de `Risk Service`.

Para viabilizar o primeiro ciclo completo de Backtest/Forward Test com o menor custo de complexidade:

- **Saída**: **Stop baseado em ATR** (item 2) como regra primária, combinado com **Stop Temporal** (item 4) como salvaguarda contra posições presas indefinidamente. **Break-even** (item 6) pode ser avaliado como refinamento opcional após o primeiro backtest. **Stop por Estrutura de Mercado** (item 3) e **Trailing Stop** (item 5) ficam para depois do MVP — ambos exigem mais infraestrutura/dados do que o disponível hoje (`INFRA-002`/`INFRA-003` atuais).
- **Position Sizing**: **Percentual por Risco**, combinado com o Stop baseado em ATR (a distância do stop, em unidades de ATR, determina o tamanho da posição para manter o risco percentual constante por operação).

Justificativa frente aos Critérios de Avaliação: ambas as escolhas reaproveitam componentes já especificados (`Indicator Provider`/`Time Provider`, `INFRA-002`/`INFRA-003`), têm complexidade média (não exigem componente novo), são determinísticas/reproduzíveis, e são compatíveis com o Strategy Tester do MT5 sem exigir dados de tick.

---

## Encaminhamento

Esta recomendação, se aceita, deverá gerar um ADR próprio definindo formalmente a regra de saída e de position sizing da Release 1.0, e sua futura formalização em `Risk Service` (`SPEC-001`, hoje `Planned`) e em `DOMAIN` (atributos de risco da `Opportunity`/`Decision`). Nenhuma dessas alterações é feita por este documento.

## Status

Open — aguardando aprovação do Product Owner / Chief Architect antes de gerar o ADR de formalização.
