---
id: BACKTEST-001
title: Backtest Execution Protocol
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - VALIDATION-001
related:
  - WALKFORWARD-001
last_updated: 2026-07-21
---

# Backtest Execution Protocol

Documento operacional da Trilha 2 — Validation (`ADR-008`). Define exclusivamente o procedimento para execução de Backtests da Release 1.0. **Não registra resultados, não aprova estratégias, não altera regras de negócio.** Não altera `DOMAIN`, `ARCH`, `SPEC` ou `ADR`.

---

# Objetivo

Definir o procedimento oficial para execução de Backtests da Release 1.0, garantindo que qualquer operador execute exatamente o mesmo processo e produza artefatos comparáveis.

---

# Entradas

Cada Backtest deve informar obrigatoriamente:

- Commit Git;
- Versão da Estratégia;
- Ativo;
- Timeframe;
- Período Histórico;
- Fonte dos Dados;
- Parâmetros;
- Versão do MT5.

Conjunto consistente com "Universo de Teste" e "Reprodutibilidade" já definidos em `VALIDATION-001`.

---

# Ambiente

Registro obrigatório do ambiente de execução:

- Sistema Operacional;
- Versão MT5;
- Build;
- Strategy Tester Mode (ex.: Visual, Otimização, Único);
- Tipo de Modelagem (ex.: Every Tick, Every Tick Based on Real Ticks, 1 Minute OHLC, Open Prices Only);
- Timezone.

---

# Sequência Operacional

Cada execução deve seguir exatamente esta sequência, sem omitir etapas:

1. Preparar ambiente.
2. Selecionar estratégia.
3. Selecionar ativo.
4. Selecionar timeframe.
5. Selecionar período.
6. Validar parâmetros.
7. Executar teste.
8. Exportar resultados.
9. Gerar artefatos.
10. Arquivar execução.

---

# Saídas Obrigatórias

Cada execução deve produzir:

- HTML do Strategy Tester;
- Relatório PDF;
- Arquivos CSV;
- Journal;
- Screenshot;
- Configuração utilizada.

---

# Controle de Qualidade

Verificar, antes de considerar a execução válida:

- Dados completos;
- Ausência de erros;
- Consistência dos parâmetros;
- Número de operações;
- Integridade dos artefatos.

---

# Critérios de Invalidação

Invalidar automaticamente a execução quando houver:

- Dados corrompidos;
- Histórico incompleto;
- Erros de execução;
- Configuração divergente;
- Arquivos ausentes.

Uma execução invalidada não deve ser usada para avaliar as Hipóteses H1/H0 de `VALIDATION-001` — deve ser refeita.

---

# Armazenamento

Convenção obrigatória para cada execução arquivada:

| Item | Convenção |
|---|---|
| Nome da pasta | `BACKTEST-001_<Ativo>_<Timeframe>_<AAAAMMDD>_<HashCommitCurto>` |
| Nome dos arquivos | `<mesma_base_da_pasta>.<extensão>` (ex.: `.html`, `.pdf`, `.csv`, `.log`) |
| Versionamento | Uma pasta por execução — nunca sobrescrever uma execução já arquivada |
| Hash do commit | Registrado no nome da pasta e na Configuração utilizada (Saídas Obrigatórias) |
| Timestamp | Data e hora de início e término da execução, registradas na Configuração utilizada |

---

# Rastreabilidade

Cada execução deve referenciar explicitamente:

- `VALIDATION-001` (protocolo de validação e Hipótese de Risco vigente);
- Commit Git;
- Versão da Estratégia;
- Execução correspondente (pasta arquivada, conforme "Armazenamento").

---

# Definition of Done

`BACKTEST-001` estará concluído quando qualquer integrante conseguir executar exatamente o mesmo procedimento e produzir artefatos comparáveis.

---

# Validação

Documento validado contra `VALIDATION-001`: usa exatamente o mesmo Universo de Teste, a mesma Hipótese de Risco (`RFC-005`, via `VALIDATION-001`) e o mesmo Protocolo de Teste de 7 etapas (aqui detalhado em 10 etapas operacionais, sem contradição — as 7 etapas de `VALIDATION-001` descrevem o processo em nível de validação; as 10 etapas aqui descrevem o procedimento operacional dentro do MT5). Nenhum termo novo de domínio ou componente foi introduzido.

---

# Próximo Documento

`EDGE-REPORT-001`, consolidando os resultados de `BACKTEST-001` e `WALKFORWARD-001` frente aos Critérios de Aprovação/Reprovação de `VALIDATION-001`.
