---
id: EXEC-005
title: MT5 Adapter
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - EXEC-001
  - EXEC-002
last_updated: 2026-07-21
---

# MT5 Adapter

Quinto e último documento da sequência travada de entrega (`ADR-009`). Detalha o componente `MT5 Adapter`, já catalogado em `SPEC-001` (Execution Components, status `Planned`). Este documento **não altera** `ARCH`, `DOMAIN`, `ADR`, `RFC` ou `SPEC` — apenas detalha, em nível de contrato funcional, um componente já existente no Canonical Component Catalog.

---

## Validação Prévia (Document Validation Pipeline)

- **SPEC-001**: `MT5 Adapter` já catalogado (Execution Components, status `Planned`) — nenhum componente novo criado.
- **ARCH-001**: `MT5 Adapter` pertence ao Bounded Context Execution; depende apenas de sistemas externos (API MT5), consistente com "Dependências Permitidas" (`Execution → Core Domain` é a única direção permitida para Execution, e este componente sequer depende de Core Domain).
- **EXEC-001**/**EXEC-002**: consistente — ambos já citavam `MT5 Adapter` como dependência permitida; este documento formaliza o contrato que ambos consomem.
- Nenhuma divergência nova encontrada nesta entrega (diferente de `EXEC-003`/`RFC-006` e `EXEC-004`/`RFC-007`).

**Observação de rastreabilidade (não uma inconsistência)**: `GetAccount()` → `Account Snapshot`, definidos aqui, podem ser exatamente a fonte de dado que `EXEC-003` (Risk Service) esperava obter de um "Account Provider" ainda não catalogado (`RFC-006`). Este documento não decide isso — apenas registra a conexão para quando `RFC-006` for resolvida: é possível que "Account Provider" não precise existir como componente novo, e sim que `Risk Service` deva consumir `Account Snapshot` indiretamente (via `Position Manager` ou outro intermediário), com origem real em `MT5 Adapter`.

---

# Objetivo

Definir o contrato do componente responsável por isolar toda a comunicação entre o TradingOS e a plataforma MetaTrader 5. Nenhum outro componente da aplicação pode acessar diretamente funções da API do MT5.

---

# Responsabilidades

- receber requisições do `Order Manager`;
- converter modelos internos para estruturas do MT5;
- enviar ordens;
- consultar posições;
- consultar ordens;
- consultar informações da conta;
- consultar informações do símbolo;
- receber respostas do MT5;
- converter respostas para modelos internos;
- publicar eventos de integração.

---

# Não Responsabilidades

`MT5 Adapter` **não** deve:

- gerar sinais;
- calcular indicadores;
- calcular risco;
- tomar decisões de negócio;
- gerenciar posições;
- aplicar regras comerciais.

---

# Entradas

- `Order Request` (de `Order Manager`, `EXEC-001`);
- `Position Request`;
- `Account Request`;
- `Symbol Request`.

---

# Saídas

- `Order Response`;
- `Position Response`;
- `Account Snapshot`;
- `Symbol Snapshot`;
- `Execution Error`.

---

# Conversões

O componente realiza exclusivamente a tradução entre:

```
Modelos internos do TradingOS
↓
Estruturas da API MT5
↓
Modelos internos do TradingOS
```

Nenhum componente externo a `MT5 Adapter` pode conhecer tipos da API MT5 — isolamento total.

---

# Operações

Contratos conceituais, sem implementação:

- `SendOrder()`;
- `ModifyOrder()`;
- `CancelOrder()`;
- `GetPositions()`;
- `GetOrders()`;
- `GetAccount()`;
- `GetSymbol()`;
- `GetHistory()`.

---

# Tratamento de Erros

| Cenário | Tratamento |
|---|---|
| Falha de conexão | `AdapterError` publicado, sem propagar exceção não tratada |
| Timeout | `Execution Error`, registrado via `Logger` |
| Requisição inválida | Rejeitada antes de qualquer chamada à API MT5 |
| Resposta inválida | Convertida em `Execution Error`, nunca repassada como dado válido |
| Código de erro MT5 | Traduzido para o vocabulário interno (`Order Response`/`Execution Error`), nunca exposto cru ao consumidor |
| Exceções inesperadas | Capturadas, convertidas em `AdapterError`, nunca propagadas |

---

# Eventos

- `OrderSent`;
- `OrderExecuted`;
- `OrderRejected`;
- `ConnectionLost`;
- `ConnectionRecovered`;
- `AdapterError`.

---

# Dependências

## Permitidas

- API do MetaTrader 5 (única dependência externa).

## Proibidas

- qualquer componente de negócio (Core Domain, Application Services, Domain Policies);
- `Indicator Provider`, `Data Provider` (não são consumidos por `MT5 Adapter` — a relação é a inversa: esses Providers, quando implementados sobre MT5, é que dependerão de `MT5 Adapter`, não o contrário, nesta especificação de Execution).

---

# Consumidores

- `Order Manager` (`EXEC-001`);
- `Position Manager` (`EXEC-002`).

---

# Casos de Teste

1. Ordem enviada com sucesso;
2. Ordem rejeitada pelo broker;
3. Timeout;
4. Reconexão;
5. Consulta de posições;
6. Consulta da conta;
7. Erro inesperado da API.

---

# Critérios de Aceitação

- isolar completamente a API do MT5;
- ser substituível futuramente por outro Adapter (ex.: um adapter de simulação/replay, se algum dia decidido — sem antecipar essa decisão aqui);
- não conter regras de negócio;
- converter corretamente todos os modelos;
- ser completamente testável.

---

# Limitações

Não implementa:

- estratégia;
- gestão de risco;
- gestão de posições;
- indicadores;
- regras de negócio.

---

# Traceability

- Architecture Baseline v1.0/v1.1 (`ADR-007`, `ADR-009`) — nenhum documento congelado alterado.
- Canonical Component Catalog (`SPEC-001`) — `MT5 Adapter` catalogado, Execution Components, status `Planned`.
- `EXEC-001` (Order Manager — consumidor, origem de Order Request).
- `EXEC-002` (Position Manager — consumidor, origem de Broker Updates via este Adapter).
- `EXEC-003`/`RFC-006` — observação de rastreabilidade sobre `Account Snapshot`/"Account Provider" (ver "Validação Prévia"), não uma decisão.
- `DOCUMENT_INDEX.md`, `TRACEABILITY.md` — atualizados nesta entrega.

---

# Definition of Done

O documento estará concluído quando qualquer desenvolvedor puder implementar a integração com MT5 sem tomar decisões arquiteturais adicionais.

---

# Fim da Sequência Travada (ADR-009)

`EXEC-001 → EXEC-002 → EXEC-003 → EXEC-004 → EXEC-005` concluída. Próximo item da sequência: **Sprint 1**, conforme `ADR-009`. Antes de iniciar a implementação, permanecem pendentes as revisões já sinalizadas: `RFC-006` (divergência de contrato do Risk Service) e, principalmente, `RFC-007` (divergência de pipeline do Signal Builder — se a Release 1.0 usará `Opportunity`/`Decision` ou um caminho direto via indicadores).
