# TradingOS — Arquitetura (congelada em Sprint 0)

> Este documento reflete o estado **real** do código em `sprint-2.1-trend-analyzer`, verificado por leitura direta dos arquivos e por compilação real via MetaEditor CLI (0 erros). Não é um plano aspiracional — onde o plano diverge do código, isso é sinalizado explicitamente.

---

## 1. Árvore completa do projeto

```
TradingOS/
├── .gitignore
├── CHANGELOG.md                        (vazio)
├── README.md                           (contém a arquitetura "planejada" original)
├── Docs/
│   ├── ARCHITECTURE.md                 (este arquivo)
│   ├── BACKLOG.md                      (novo — Sprint 0)
│   ├── TECH_DEBT.md                    (novo — Sprint 0)
│   ├── CHANGELOG.md                    (vazio)
│   ├── ROADMAP.md                      (vazio)
│   └── VERSION.md                      (vazio)
└── MQL5/
    ├── experts.dat                     (gerado pelo terminal — ignorado no git)
    ├── logs/                           (gerado pelo terminal — ignorado no git)
    ├── Profiles/                       (gerado pelo terminal — ignorado no git)
    ├── Experts/TradingOS/
    │   ├── TradingOS.mq5               (ENTRY POINT — compila limpo)
    │   └── TradingOS.ex5               (binário compilado)
    └── Include/TradingOS/
        ├── Core/
        │   ├── Config.mqh              (parâmetros estáticos)
        │   └── Logger.mqh              (wrapper de Print)
        ├── Models/
        │   ├── MarketContext.mqh       (usado pelo pipeline ATIVO)
        │   ├── MarketSnapshot.mqh      (usado pelo pipeline NOVO, órfão)
        │   └── MarketAnalysis.mqh      (usado pelo pipeline NOVO, órfão)
        ├── Indicators/
        │   ├── TrendService.mqh        (usado pelo pipeline ATIVO)
        │   └── ATRService.mqh          (ÓRFÃO — não incluído em lugar nenhum)
        ├── Services/
        │   ├── MarketService.mqh       (orquestrador do pipeline ATIVO)
        │   └── PriceService.mqh        (ÓRFÃO — arquivo existe e está VAZIO)
        ├── Interfaces/
        │   └── IAnalyzer.mqh           (novo padrão, órfão)
        ├── Analysis/
        │   └── TrendAnalyzer.mqh       (novo padrão, órfão, `Analyze()` é stub)
        └── UI/
            └── Dashboard.mqh           (usado pelo pipeline ATIVO)
```

---

## 2. Grafo de dependências real (via `#include`)

### 2.1 Pipeline ATIVO (o que roda de fato hoje)

```
TradingOS.mq5
 ├─ Core/Config.mqh
 ├─ Core/Logger.mqh
 ├─ Services/MarketService.mqh
 │   ├─ Models/MarketContext.mqh
 │   │   └─ Indicators/TrendService.mqh
 │   └─ Indicators/TrendService.mqh        (include duplicado — já vem via MarketContext)
 ├─ Models/MarketContext.mqh               (include duplicado — já vem via MarketService)
 └─ UI/Dashboard.mqh
     └─ Models/MarketContext.mqh           (include duplicado — 3ª vez)
```

Fluxo de execução real (`OnTimer`):
`Market.Update(Context)` → `CTrendService.GetTrend()` (EMA 20/50/200, enum `ENUM_TREND`) → grava em `MarketContext` → `Dashboard.Update(Context)` → `Comment()` na tela.

### 2.2 Pipeline NOVO, desconectado (Sprint 2.1 em andamento)

```
Interfaces/IAnalyzer.mqh
 ├─ Models/MarketSnapshot.mqh
 └─ Models/MarketAnalysis.mqh

Analysis/TrendAnalyzer.mqh (implementa IAnalyzer)
 └─ Interfaces/IAnalyzer.mqh
```

Nenhum arquivo do pipeline ativo (`TradingOS.mq5`, `MarketService.mqh`, `MarketContext.mqh`) inclui ou referencia `IAnalyzer`, `TrendAnalyzer`, `MarketSnapshot` ou `MarketAnalysis`. Este cluster compila isoladamente, mas **não é chamado por nada** — é código morto do ponto de vista do EA em execução.

### 2.3 Módulos completamente isolados

- **`ATRService.mqh`** (`CATRService`): implementado, funcional, mas não instanciado nem incluído por nenhum outro arquivo.
- **`PriceService.mqh`**: arquivo existe no disco mas está **vazio (0 bytes)**, apesar do commit `1b4fbad feat(price): create price service` indicar que algo foi implementado ali. Conteúdo original provavelmente perdido (ver TECH_DEBT.md).

---

## 3. Módulos órfãos (não referenciados pelo pipeline ativo)

| Módulo | Estado | Motivo |
|---|---|---|
| `Indicators/ATRService.mqh` | Completo, funcional | Nunca foi incluído em `MarketService`/`MarketContext`/`Dashboard` |
| `Services/PriceService.mqh` | Vazio | Sem conteúdo — stub esquecido ou conteúdo perdido |
| `Interfaces/IAnalyzer.mqh` | Completo | Novo padrão ainda não adotado pelo pipeline ativo |
| `Models/MarketSnapshot.mqh` | Completo | Só usado pelo cluster novo (2.2) |
| `Models/MarketAnalysis.mqh` | Completo | Só usado pelo cluster novo (2.2) |
| `Analysis/TrendAnalyzer.mqh` | **Stub** (`Analyze()` retorna `true` sem lógica) | Implementação prometida "na próxima etapa" (comentário no próprio código) |

---

## 4. Conflito arquitetural pendente (o achado mais importante deste Sprint 0)

Existem **dois modelos de "tendência" concorrentes e incompatíveis** no código:

| | Modelo Antigo (ativo) | Modelo Novo (órfão) |
|---|---|---|
| Onde | `Indicators/TrendService.mqh` | `Analysis/TrendAnalyzer.mqh` |
| Enum | `ENUM_TREND` (`TREND_UP/DOWN/SIDE`) | `TrendType` (`TREND_BULLISH/BEARISH/RANGE/TRANSITION/UNKNOWN`) |
| Entrada | `(symbol, timeframe)` direto, chama `iMA` internamente | `MarketSnapshot` (dados já coletados) |
| Saída | valor de enum simples | `struct MarketAnalysis` (trend + força + confiança + resumo) |
| Extensível para RSI/ADX (Sprint 3)? | Não — cada indicador teria que duplicar esse padrão ad-hoc | Sim — é exatamente para isso que `IAnalyzer` existe |

**Isso precisa de uma decisão explícita antes de qualquer nova sprint**, porque o Roadmap original (README.md) planeja RSI e ADX na Sprint 3 sem prever esse padrão de interface — se a decisão for adotar `IAnalyzer`, RSI/ADX/Score devem nascer como `IAnalyzer`, não como serviços soltos tipo `TrendService`/`ATRService`. Ver recomendação em `BACKLOG.md`.

---

## 5. Divergência entre README (arquitetura planejada) e código real

O `README.md` descreve uma árvore com pastas que ainda não existem: `Decision/`, `Execution/`, além de `Indicators/RSIService.mqh`, `ADXService.mqh`, `PivotService.mqh`, `Services/SessionService.mqh`, `SignalService.mqh`, e uma pasta `Dashboard/DashboardService.mqh` (o código real usa `UI/Dashboard.mqh`, nome e local diferentes). Isso é esperado para um roadmap — não é um bug — mas os documentos `Docs/*.md` (todos vazios) nunca foram sincronizados com essa visão, o que motivou este Sprint 0.

---

## 6. Estado de compilação (verificado nesta sessão)

```
MetaEditor64.exe /compile:TradingOS.mq5
Result: 0 errors, 0 warnings, 394 ms elapsed
```
Verificado após correção do bug do `Dashboard.mqh` (arquivo estava presente como duplicata `Dashboard(3).mqh` por um acidente de cópia manual entre duas pastas do projeto no disco — resolvido nesta sessão).
