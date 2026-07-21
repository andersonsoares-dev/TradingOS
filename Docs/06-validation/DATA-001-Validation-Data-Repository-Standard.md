---
id: DATA-001
title: Validation Data & Evidence Repository Standard
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - VALIDATION-001
  - BACKTEST-001
related:
  - WALKFORWARD-001
  - EDGE-REPORT-001
last_updated: 2026-07-21
---

# Validation Data & Evidence Repository Standard

Documento operacional da Trilha 2 — Validation (`ADR-008`). Define exclusivamente a organização dos artefatos (dados, relatórios, logs, evidências) produzidos durante a validação da Release 1.0. Não altera `DOMAIN`, `ARCH`, `SPEC` ou `ADR`.

**Nota de nomenclatura**: o brief de origem propunha a pasta raiz `Validation/`. Renomeada para `validation-runs/` para evitar colisão de nome com `Docs/06-validation/` — que guarda os documentos `.md` de protocolo (`VALIDATION-001`, `BACKTEST-001`, etc.), conteúdo diferente dos artefatos brutos de execução tratados aqui. Mesma preocupação de nomenclatura já registrada em `ADR-008`.

---

# Objetivo

Padronizar a estrutura de diretórios, nomenclatura de arquivos, versionamento e retenção das evidências de validação, de modo que toda evidência produzida possa ser localizada e reproduzida.

---

# Escopo

Padroniza:

- estrutura de pastas;
- convenção de nomes;
- identificação de campanhas;
- identificação de execuções;
- versionamento;
- arquivamento.

---

# Estrutura

```
validation-runs/
    Campaign-001/
        Test-001/
            Config/
            Reports/
            Logs/
            Raw/
            Screenshots/
        Test-002/
            ...
    Campaign-002/
        ...
```

- **Campaign** — um conjunto de execuções relacionadas a um mesmo objetivo de validação (ex.: primeira rodada de Backtest em EURUSD/USDJPY, conforme `VALIDATION-001`).
- **Test** — uma execução individual dentro de uma Campaign (um Backtest, um Walk Forward, um Forward Test).
- **Config/** — configuração utilizada na execução (parâmetros, `.set`/`.ini`).
- **Reports/** — relatório PDF e HTML do Strategy Tester (`BACKTEST-001`, "Saídas Obrigatórias").
- **Logs/** — Journal e demais logs da execução.
- **Raw/** — arquivos CSV e demais dados brutos exportados.
- **Screenshots/** — capturas de tela exigidas por `BACKTEST-001`.

---

# Convenção de Nomes

| Item | Convenção |
|---|---|
| Campanha | `Campaign-<NNN>` (sequencial, 3 dígitos, ex.: `Campaign-001`) |
| Teste | `Test-<NNN>` (sequencial dentro da campanha, ex.: `Test-001`) |
| Relatório PDF | `<Campaign>_<Test>_Report.pdf` |
| Relatório HTML (Strategy Tester) | `<Campaign>_<Test>_StrategyTester.html` |
| Log/Journal | `<Campaign>_<Test>_Journal.log` |
| Configuração | `<Campaign>_<Test>_Config.set` |
| Captura de tela | `<Campaign>_<Test>_Screenshot_<NN>.png` |

Nenhum arquivo obrigatório (ver `BACKTEST-001`, "Saídas Obrigatórias") pode ser nomeado fora desta convenção.

---

# Metadados

Cada execução (`Test-NNN`) deve registrar, em um arquivo de metadados dentro de `Config/` (ex.: `<Campaign>_<Test>_Metadata.md` ou `.json`):

- Commit Git;
- Estratégia (versão);
- Ativo;
- Timeframe;
- Período;
- Data;
- Operador;
- Fonte dos dados.

Conjunto idêntico ao já exigido por `VALIDATION-001` ("Reprodutibilidade") e `BACKTEST-001` ("Entradas"/"Ambiente") — este documento não duplica a definição, apenas padroniza onde e como esse metadado é fisicamente armazenado.

---

# Retenção

| Categoria | Política |
|---|---|
| Arquivos obrigatórios (`Config/`, `Reports/`) | Retenção permanente — nunca excluídos, conforme Regra 10 do `DOCUMENT_CONTROL` ("nenhum arquivo poderá ser apagado"; obsoletos recebem status Deprecated, não remoção) |
| Arquivos temporários (rascunhos de log intermediários, capturas de depuração não exigidas por `BACKTEST-001`) | Podem ser descartados após a consolidação da execução no `Reports/` |
| Histórico | Toda `Campaign`/`Test` já executada permanece disponível indefinidamente — nenhuma campanha é sobrescrita |
| Backup | Fora do escopo deste documento. **Recomendação** (não decisão): dado o precedente já registrado em `Docs/TECH_DEBT.md` (item 8 — binários no histórico do Git), `Raw/` e `Screenshots/` (potencialmente volumosos) não deveriam ser versionados diretamente no Git principal — avaliar armazenamento externo ou Git LFS antes do primeiro backtest real. `Config/` e `Reports/` (texto/PDF, menores) podem permanecer versionados normalmente. |

---

# Rastreabilidade

Cada execução (`Test-NNN`) deve relacionar-se explicitamente com:

- `VALIDATION-001` (protocolo e Hipótese de Risco vigente);
- `BACKTEST-001` (ou `WALKFORWARD-001`/`FORWARDTEST-001`, conforme o tipo de execução);
- `EDGE-REPORT-001` (quando a execução for consolidada em um relatório de edge);
- Commit Git.

---

# Definition of Done

Toda evidência produzida pelo projeto poderá ser localizada e reproduzida utilizando apenas a estrutura definida neste documento.

---

# Validação

Documento validado contra `VALIDATION-001` e `BACKTEST-001`: reutiliza exatamente os mesmos campos de metadado e as mesmas saídas obrigatórias já definidos em ambos, sem redefini-los — apenas padroniza sua organização física. Nenhum termo novo de domínio, componente ou arquitetura foi introduzido.

---

# Próximo Documento

`WALKFORWARD-001`, seguindo a mesma estrutura `validation-runs/` definida aqui.
