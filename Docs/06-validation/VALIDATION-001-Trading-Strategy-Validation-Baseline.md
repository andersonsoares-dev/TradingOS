---
id: VALIDATION-001
title: Trading Strategy Validation Baseline
version: 2.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-004
  - ADR-008
  - RFC-005
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# Trading Strategy Validation Baseline

Documento oficial da Trilha 2 — Validation (`ADR-008`). Estabelece o protocolo oficial para validar quantitativamente a estratégia de trading da Release 1.0, garantindo reprodutibilidade, rastreabilidade e comparabilidade dos resultados. **Não altera** `DOMAIN`, `ARCH`, `SPEC` ou `ADR`.

As recomendações de gerenciamento de risco da `RFC-005` são utilizadas aqui como **hipótese inicial de validação**, não como decisão arquitetural definitiva — ver "Hipótese de Risco".

**Nota de versão**: este documento substitui e expande a v1.0.0 (`Trading Strategy Baseline`), renomeado para refletir seu escopo ampliado. Histórico preservado via `git mv`.

---

# Objetivo

Definir o processo oficial para validar quantitativamente a estratégia de trading da Release 1.0, antes de qualquer escala adicional da plataforma.

---

# Hipótese Principal

**H1**: "A estratégia TradingOS apresenta expectativa matemática positiva quando executada conforme as regras definidas para a Release 1.0."

**H0 (hipótese nula)**: "A estratégia não apresenta expectativa matemática positiva."

Toda execução de validação (`BACKTEST-00X`, `WALKFORWARD-00X`, `FORWARDTEST-00X`) existe para testar H1 contra H0 — nunca para confirmar H1 por padrão.

---

# Hipóteses Secundárias

Avaliadas em conjunto com H1/H0:

- Robustez entre ativos;
- Robustez entre timeframes;
- Robustez entre diferentes períodos históricos;
- Robustez em diferentes regimes de mercado;
- Sensibilidade aos parâmetros.

---

# Escopo

Esta validação compreende:

- Backtest;
- Walk Forward;
- Forward Test (Conta Demo).

Exclui explicitamente:

- Machine Learning;
- Auto Optimization;
- Multi Strategy;
- Multi Broker.

Estes itens excluídos pertencem à Trilha 3 — Learning (`ADR-008`), fora do escopo da Release 1.0.

---

# Estratégia Inicial a Validar

A única estratégia hoje implementada e executável é a da **Legacy Baseline (V1)**, congelada desde o Sprint 0.5 (`ADR-001`, `Docs/BACKLOG.md`): `MarketService` (Trend/ATR/RSI/ADX/Session/Pivot) → `MarketAssessmentService` (Score/Bias/Confidence) → `SignalBuilderService` (`TradingSignal`).

Nenhum componente do modelo-alvo (`Opportunity`/`Decision`/`Market Context` formal) está implementado — esta validação incide exclusivamente sobre a V1.

## Critérios de Entrada (já existentes — referência, não nova regra)

Conforme `SignalBuilderService` (código já implementado):

- **BUY/SELL**: exige as 4 confirmações (`TrendConfirmed`, `ADXConfirmed`, `RSIConfirmed`, `SessionConfirmed`) e `ConfidenceLevel` = HIGH.
- **WAIT**: exige bias definido e ao menos 2 das 4 confirmações.
- **NO_TRADE**: qualquer outro caso.

---

# Universo de Teste

Registro obrigatório para cada execução:

| Campo | Valor |
|---|---|
| Ativos | EURUSD, USDJPY (primeira rodada); GBPUSD, XAUUSD (segunda rodada) — **(proposto)**, base: RC1 (`Docs/BACKLOG.md`) |
| Timeframes | H4, H1, M15 — mesmos já consumidos internamente por `MarketContext`/`MarketService` |
| Sessões | Asian, London, NY, Overlap — mesmas já classificadas por `SessionService` |
| Período histórico | Mínimo 2–3 anos, cobrindo diferentes regimes de volatilidade — **(proposto, pendente de confirmação e disponibilidade de dados no MT5)** |
| Quantidade mínima de operações | ≥ 100 operações por combinação ativo/timeframe, para significância estatística mínima — **(proposto)** |
| Fonte dos dados | `Data Provider` (`INFRA-002`), via `MT5 Adapter` |
| Versão do histórico | Registrada por execução (ver "Reprodutibilidade") |

---

# Protocolo de Teste

Cada execução deve seguir exatamente esta sequência, sem omitir etapas:

1. Selecionar versão do código (hash do commit Git).
2. Selecionar versão da estratégia.
3. Selecionar conjunto de parâmetros.
4. Executar Backtest.
5. Registrar resultados.
6. Validar critérios mínimos.
7. Emitir relatório.

---

# Hipótese de Risco

Enquanto não existir ADR específico aprovando a gestão de risco definitiva, esta validação utiliza como **hipótese de teste** (não decisão) a recomendação da `RFC-005`:

**Saída**:
- Stop baseado em ATR;
- Stop Temporal.

**Position Sizing**:
- Percentual por Risco.

Esta configuração poderá ser alterada após aprovação de ADR futuro formalizando a gestão de risco da Release 1.0. Nenhum resultado de validação obtido sob esta hipótese deve ser interpretado como validação da regra de risco em si — apenas da estratégia de entrada, sob esta hipótese de saída.

---

# Pipeline de Validação

Mapeamento direto aos estágios já definidos em `ADR-004`:

| Estágio (ADR-004) | Documento futuro desta trilha |
|---|---|
| Strategy Tester / Historical Simulation | `BACKTEST-001` |
| Walk Forward | `WALKFORWARD-001` |
| Demo Validation | `FORWARDTEST-001` |
| — (consolidação) | `EDGE-REPORT-001` |
| Production Validation | fora do escopo desta trilha, até edge comprovado |

---

# Métricas Obrigatórias

Toda execução deve registrar:

- Profit Factor;
- Expectancy;
- Win Rate;
- Average Win;
- Average Loss;
- Payoff Ratio;
- Maximum Drawdown;
- Recovery Factor;
- Número de Trades;
- Tempo Médio em Operação.

---

# Critérios de Aprovação

Os valores numéricos serão definidos futuramente e parametrizados (por ADR ou atualização deste documento). Categorias mínimas a prever:

- Profit Factor mínimo;
- Drawdown máximo;
- Expectancy positiva;
- Quantidade mínima de operações;
- Consistência entre períodos.

---

# Critérios de Reprovação

Reprovação automática quando houver:

- Dados incompletos;
- Histórico inconsistente;
- Número insuficiente de operações;
- Expectativa negativa;
- Drawdown superior ao permitido;
- Erro de execução.

---

# Reprodutibilidade

Todo teste deve registrar:

- Hash do commit Git;
- Versão da estratégia;
- Data;
- Operador;
- Ativo;
- Timeframe;
- Fonte dos dados;
- Configuração utilizada.

---

# Evidências Obrigatórias

Cada execução deve gerar:

- Relatório em PDF;
- Arquivo bruto de resultados;
- Logs;
- Configuração utilizada;
- Capturas do Strategy Tester (quando aplicável).

---

# Modelo de Relatório

Todo relatório (`BACKTEST-00X`, `WALKFORWARD-00X`, `FORWARDTEST-00X`, `EDGE-REPORT-00X`) deve conter:

1. Resumo Executivo;
2. Ambiente de Teste;
3. Configuração;
4. Resultados;
5. Métricas;
6. Análise;
7. Conclusão;
8. Próximas Ações.

---

# Dependências

Este protocolo depende da existência de:

- `Data Provider` (`INFRA-002` — especificado);
- `Indicator Provider` (`INFRA-003` — especificado);
- `Risk Service` (mínimo) — `SPEC-001`, status `Planned`, **não implementado** (gap real: a hipótese de risco acima cobre a lacuna documental, não a de código);
- capacidade mínima de execução de ordens — `SPEC-001` cataloga `Order Manager`/`Position Manager` (Execution Components, status `Future`), **não implementado**. Este documento não usa o termo "Execution Engine" (citado no brief de origem) por não constar no Canonical Component Catalog — referenciados aqui os componentes já catalogados;
- `MT5 Adapter` — `SPEC-001`, status `Planned`.

**Nenhuma dessas dependências de implementação está satisfeita hoje** — o Backtest inicial (`BACKTEST-001`) poderá, na prática, rodar sobre a lógica da Legacy Baseline (já implementada) usando o Strategy Tester nativo do MT5, sem exigir que `Risk Service`/`Order Manager` do modelo-alvo estejam prontos primeiro. Esta observação não altera o protocolo — apenas registra a lacuna de implementação.

---

# Limitações

Esta validação **não certifica**:

- rentabilidade futura;
- robustez para todos os mercados;
- aprendizado automático;
- estratégias adicionais.

---

# Definition of Done

`VALIDATION-001` será considerado concluído quando qualquer membro da equipe conseguir reproduzir exatamente o mesmo experimento e obter resultados comparáveis, utilizando as mesmas entradas.

---

# Fora de Escopo

Confirmado da v1.0.0: gestão de risco definitiva e critérios de saída definitivos **não** são decididos aqui — apenas usados como hipótese de teste (ver "Hipótese de Risco"), remetidos para ADR próprio quando aprovados.

---

# Rastreabilidade

- `ADR-004` (Validation Strategy — pipeline oficial de validação, mapeado acima).
- `ADR-008` (Roadmap Restructuring — origem desta trilha).
- `RFC-005` (Trading Risk & Exit Strategy — origem da Hipótese de Risco).
- `AUDIT-001` (Coverage Matrix — Testing, ponto de partida ~15%).
- `SPEC-001` (Risk Service, Order Manager, Position Manager, MT5 Adapter — todos status Planned/Future, dependências não satisfeitas).

---

# Próximos Documentos

`BACKTEST-001`, `WALKFORWARD-001`, `FORWARDTEST-001`, `EDGE-REPORT-001` — conforme "Pipeline de Validação" acima.
