# TradingOS — Dívida Técnica

> Levantado no Sprint 0, por leitura direta do código e do histórico do git. Atualizado no Sprint 0.5 para refletir o congelamento de arquitetura (decisão do Chief Architect: `TrendService`/`MarketService`/`MarketContext`/`Dashboard` são oficiais até a V1; módulos órfãos permanecem documentados, sem integração ou remoção nesta fase).

---

## Alto impacto

### 1. Duas arquiteturas de análise de tendência coexistindo — CONGELADO até V1
`Indicators/TrendService.mqh` é a implementação **oficial** (decisão Sprint 0.5). `Analysis/TrendAnalyzer.mqh` + `Interfaces/IAnalyzer.mqh` permanecem no repositório como código órfão, **não implementado** (`Analyze()` continua stub) e **não integrado**. Isso deixou de ser um item bloqueante — é uma decisão deliberada, não um problema pendente. Reavaliação da migração para `IAnalyzer` fica para depois da entrega da V1, não antes.

### 2. `PriceService.mqh` vazio apesar de commit dizendo o contrário
O commit `1b4fbad feat(price): create price service` sugere que este arquivo teve conteúdo implementado. Hoje ele existe no disco com **0 bytes**. Mesma classe de acidente que causou o bug do `Dashboard(3).mqh` (cópia manual de pastas entre `C:\Projetos\TradingOS` e uma segunda cópia local do projeto) é a suspeita mais provável.
**Status Sprint 0.5**: por decisão de congelamento, este arquivo **não será recriado nem removido** nesta fase — permanece documentado como órfão vazio. Recuperação de conteúdo (via `git show 1b4fbad:...`) fica para quando a sprint correspondente decidir reativá-lo.

### 3. Duas pastas do mesmo repositório no disco
Existe `C:\Projetos\TradingOS` (a real, ligada ao MetaTrader via junction) e uma segunda cópia manual em `C:\Users\ComercialYadasWTImpo\.claude\Forex\Projetos\TradingOS`, ambas com o mesmo remoto git e o mesmo branch. É a causa mais provável dos arquivos duplicados com sufixo `(3)`. Enquanto as duas pastas existirem, o risco de reintroduzir o mesmo tipo de bug continua.
**Ação sugerida**: escolher uma única pasta de trabalho (recomendado: `C:\Projetos\TradingOS`) e remover ou arquivar a outra. Não afeta código-fonte, portanto não conflita com o congelamento de arquitetura do Sprint 0.5.

---

## Médio impacto

### 4. Includes duplicados no pipeline ativo
`MarketContext.mqh` é incluído três vezes por caminhos diferentes a partir de `TradingOS.mq5` (direto, via `MarketService.mqh`, e via `Dashboard.mqh`). Inofensivo graças aos include guards (`#ifndef`). Corrigir isso seria uma alteração de arquitetura/organização de includes — **fora de escopo até a V1** pelas regras do Sprint 0.5 (nenhum arquivo `.mq5`/`.mqh` deve ser alterado nesta fase).

### 5. `ATRService.mqh` implementado e nunca usado — CONGELADO até V1
Funcional (`CATRService.GetValue`), mas nenhum arquivo o inclui. **Por decisão do Sprint 0.5, permanece órfão nesta fase** — não deve ser integrado nem removido. A Sprint 1 da V1 (roadmap em `BACKLOG.md`) tratará da exposição de ATR no pipeline oficial; se reaproveita este arquivo ou cria um novo seguindo o padrão `TrendService`, é decisão daquela sprint, não desta.

### 6. Convenção de nomenclatura de classes quebrada na Sprint 2.1
Todo o código do pipeline oficial usa prefixo `C` para classes concretas (`CDashboard`, `CMarketService`, `CTrendService`, `CATRService`). O cluster órfão `IAnalyzer`/`TrendAnalyzer` não segue esse padrão. Como esse cluster está congelado e não integrado (Sprint 0.5), isso não é urgente — só voltaria a importar se a migração para `IAnalyzer` for retomada após a V1.

### 7. Documentação em dois lugares, maioria vazia
`Docs/CHANGELOG.md`, `Docs/ROADMAP.md`, `Docs/VERSION.md` existem mas têm 0 bytes; o `CHANGELOG.md` da raiz também está vazio. Toda a informação real de arquitetura estava apenas no `README.md`. `ARCHITECTURE.md`/`BACKLOG.md`/`TECH_DEBT.md` cobrem arquitetura, roadmap e dívida técnica; changelog/versão cronológicos continuam sem dono.

---

## Baixo impacto

### 8. Binários e artefatos de build no histórico do git
`TradingOS.ex5` e `MQL5/experts.dat` foram rastreados antes do commit `e77ea18 chore: ignore MetaTrader generated files`. O `.gitignore` atual está correto para o futuro, mas o histórico já contém esses binários. Não é urgente.

### 9. Logs do terminal em UTF-16
`MQL5/logs/*.log` são gravados pelo MetaTrader em UTF-16 (ilegíveis com ferramentas de texto padrão sem decodificação). Já estão corretamente no `.gitignore` — nota operacional, não dívida de código.
