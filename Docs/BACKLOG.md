# TradingOS — Backlog e Ordem de Sprints

> Base: `Docs/ARCHITECTURE.md`. Atualizado no **Sprint 0.5 — Congelamento da Arquitetura**, que substitui a recomendação de migração proposta no Sprint 0.

---

## Decisão registrada — Sprint 0.5 (Chief Architect)

A arquitetura atual foi **congelada** para permitir o desenvolvimento da V1 sem retrabalho de base. Isto substitui a recomendação anterior (adotar `IAnalyzer`) registrada no Sprint 0.

**Componentes oficiais até a entrega da V1:**
- `Indicators/TrendService.mqh` (`CTrendService`, `ENUM_TREND`) — implementação oficial de tendência.
- `Services/MarketService.mqh` (`CMarketService`) — orquestrador oficial.
- `Models/MarketContext.mqh` — modelo de dados oficial.
- `UI/Dashboard.mqh` (`CDashboard`) — interface oficial.

**Regras em vigor até a V1:**
1. Nenhum `.mq5`/`.mqh` novo.
2. Nenhum arquivo existente removido.
3. Nenhum arquivo movido entre pastas.
4. Nenhuma classe, struct ou enum renomeada.
5. `TrendAnalyzer` / `IAnalyzer` (e qualquer arquitetura alternativa) não são implementados nem integrados nesta fase.
6. Módulos órfãos (`TrendAnalyzer.mqh`, `IAnalyzer.mqh`, `MarketSnapshot.mqh`, `MarketAnalysis.mqh`, `ATRService.mqh`, `PriceService.mqh`) permanecem apenas documentados — não integrados, não removidos.
7. Foco das próximas sprints é **entrega de funcionalidade**, não refatoração de arquitetura.

A avaliação de migrar para o padrão `IAnalyzer` (proposta no Sprint 0) fica **adiada para depois da V1**, não descartada.

---

## Módulos órfãos — status congelado

| Módulo | Ação nesta fase |
|---|---|
| `Analysis/TrendAnalyzer.mqh` | Documentar apenas. Não implementar `Analyze()`. |
| `Interfaces/IAnalyzer.mqh` | Documentar apenas. Não adotar como padrão. |
| `Models/MarketSnapshot.mqh` | Documentar apenas. |
| `Models/MarketAnalysis.mqh` | Documentar apenas. |
| `Indicators/ATRService.mqh` | Documentar apenas. Não plugar em `MarketService`. |
| `Services/PriceService.mqh` | Documentar apenas (vazio — ver `TECH_DEBT.md`). Não recriar conteúdo nesta fase. |

---

## Roadmap de sprints V1 (entrega de funcionalidade sobre a arquitetura congelada)

> Qualquer indicador novo daqui pra frente segue o **padrão `TrendService`/`MarketService`** (classe de serviço com método público, integrada diretamente em `MarketService`/`MarketContext`) — não o padrão `IAnalyzer`. Isso vale mesmo que um indicador novo cubra a mesma função de um módulo órfão hoje existente (ex.: ATR); a decisão de reaproveitar o arquivo órfão ou criar um novo será tomada na sprint correspondente, não agora.

### Sprint 1 — ATR no pipeline oficial
- Expor ATR em `MarketContext`/`Dashboard` seguindo o padrão `TrendService`.

### Sprint 2 — RSI, ADX, Market Score
- Como planejado no `README.md`, no padrão `TrendService`/`MarketService` (não `IAnalyzer`).

### Sprint 3 — Session Service, Pivot Service

### Sprint 4 — Decision Engine
- Consome `MarketContext` (não `MarketAnalysis`) para gerar recomendação operacional.

### Sprint 5 — Risk Manager

### Sprint 6 — Trade Manager

### Sprint 7 — Backtesting

---

## Fora de escopo até a V1
- Migração para `IAnalyzer`/`TrendAnalyzer` (reavaliar após a V1).
- Reconciliação dos órfãos (`ATRService`, `PriceService`) — apenas documentados, não integrados nem removidos.
- Sincronizar `README.md` com a árvore real de pastas.
- Preencher `Docs/CHANGELOG.md`, `Docs/ROADMAP.md`, `Docs/VERSION.md`.

---

## Technical Debt

### Normalizar sessões para UTC/GMT

**Descrição**: Atualmente o `SessionService` utiliza a hora do servidor do MetaTrader para identificar a sessão de mercado. Esta decisão foi intencional para a V1, visando simplicidade e estabilidade da arquitetura.

**Objetivo**: Na V2 deverá ser avaliada a implementação de uma camada de normalização de tempo contemplando:
- Server Time
- UTC
- Daylight Saving Time (DST)
- Holiday Calendar
- Trading Calendar

Desacoplar a identificação das sessões do horário do servidor e permitir maior precisão em diferentes corretoras e fusos horários.

**Status**: Postergado para V2.

**Origem**: Sprint 5.1 – SessionService.

**Prioridade**: Baixa.

**Justificativa**: Não impacta a compilação nem o funcionamento da V1 e não bloqueia nenhuma sprint atual.

### Parametrizar timeframe do PivotService

**Descrição**: Na V1 o `PivotService` utiliza exclusivamente o candle diário fechado (`PERIOD_D1`, shift 1).

**Objetivo**: Na V2 avaliar:
- D1
- W1
- MN1

configuráveis via `Config`.

**Status**: Postergado para V2.

**Origem**: Sprint 5.2 – PivotService.

**Prioridade**: Baixa.

**Justificativa**: Não impacta a compilação nem o funcionamento da V1 e não bloqueia nenhuma sprint atual.

---

## RC1 — Release Candidate 1 (Sprint 5.3)

**Status**: RC1 APROVADO COM RESSALVAS.

Validado: compilação (0 errors/0 warnings), Dashboard funcional em EURUSD e USDJPY, matemática do `PivotService` confirmada por reconstrução manual de High/Low/Close a partir dos valores exibidos nas duas capturas de tela.

Pendências registradas (não bloqueantes): Journal não inspecionado, atualização em tempo real não confirmada por evidência dupla, GBPUSD/XAUUSD não testados, M15/H1/H4 não testados especificamente (o `Pivot` é timeframe-independente por construção, já que `MarketService` sempre lê `PERIOD_D1` fixo, independente do timeframe do gráfico), performance não monitorada.

Candidato a defeito (não corrigido, aguardando confirmação): possível sobreposição visual entre a linha nativa de Bid/Ask do gráfico e o texto do Dashboard (`Comment()`), observada em EURUSD/M1 e não reproduzida em USDJPY/Daily — hipótese é a linha de preço do próprio MetaTrader cruzando a área do texto, não um bug do `Comment()`.

---

## Melhorias Sugeridas (UI/UX)

### Mover Dashboard para painel lateral direito

**Descrição**: Hoje o Dashboard é ancorado via `Comment()` no canto superior esquerdo do gráfico, mesma região onde o MetaTrader desenha suas próprias linhas de preço nativas, o que pode gerar sobreposição visual (ver RC1 acima).

**Objetivo**: Avaliar mover a exibição para um painel fixo no lado direito do gráfico.

**Origem**: RC1 (Sprint 5.3).

**Prioridade**: Baixa (estética/UX, não funcional).

### Converter níveis de Pivot em linhas no gráfico

**Descrição**: Hoje Pivot/R1-R3/S1-S3 são exibidos apenas como texto no painel do Dashboard.

**Objetivo**: Avaliar desenhar os níveis como linhas horizontais sobre o gráfico (objetos gráficos nativos do MQL5), mantendo o texto do painel como complemento, não substituto.

**Origem**: RC1 (Sprint 5.3).

**Prioridade**: Baixa (estética/UX, não funcional).

---

## Próxima direção confirmada

A Sprint seguinte à V1 concluída (Trend/ATR/RSI/ADX/Session/Pivot) é a **Decision Engine** (já listada acima como "Sprint 4"), evoluindo de exibição de números crus para interpretação de leitura de mercado (força de tendência, contexto, recomendação operacional), consumindo `MarketContext` — confirmado nesta conversa como o próximo passo após a aprovação do RC1.
