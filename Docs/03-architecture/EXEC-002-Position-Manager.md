---
id: EXEC-002
title: Position Manager
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ARCH-001
  - SPEC-001
  - EXEC-001
related:
  - RFC-001
last_updated: 2026-07-21
---

# Position Manager

Especifica o componente `Position Manager`, já catalogado em `SPEC-001` (Execution Components, status `Future`). Este documento **não altera** `DOMAIN`, `ARCH`, `SPEC`, `ADR` ou `RFC` — apenas detalha, em nível de contrato funcional, um componente já existente no Canonical Component Catalog.

**Nota de numeração/prefixo**: solicitado originalmente como `SPEC-007-Position-Manager.md`. Seguindo o mesmo raciocínio já aplicado a `EXEC-001` (`Order Manager`) — documentos `SPEC-00X` descrevem categorias inteiras de componentes, enquanto o detalhamento de um componente único segue o padrão `INFRA-00X`/`EXEC-00X` — este documento é `EXEC-002`, em `Docs/03-architecture/`, dando continuidade ao prefixo já estabelecido para Execution Components.

---

## Validação Prévia (Document Validation Pipeline)

- **SPEC-001**: `Position Manager` já catalogado (Execution Components, status `Future`) — nenhum componente novo criado.
- **ARCH-001**: `Position Manager` pertence ao Bounded Context Execution; dependências permitidas/proibidas aplicadas sem exceção.
- **EXEC-001**: `Position Manager` consome as saídas do `Order Manager` (`Order Accepted`) como um de seus gatilhos de entrada — consistente com "Consumidores" já declarado em `EXEC-001`.
- **RFC-001** (Risk Profile Classification, Open): `Position Manager` é consumido por `Risk Service` — mesma observação de dependência pendente já registrada em `EXEC-001`.

---

# Objetivo

Especificar o componente responsável pelo gerenciamento do ciclo de vida das posições abertas.

---

# Responsabilidades

`Position Manager` deve:

- registrar posições abertas;
- atualizar estado das posições;
- monitorar alterações;
- detectar encerramento;
- publicar eventos;
- disponibilizar consulta de posições.

---

# Não Responsabilidades

`Position Manager` **não** deve:

- gerar sinais;
- calcular risco;
- enviar ordens;
- calcular indicadores;
- tomar decisões estratégicas.

Envio de ordens é responsabilidade exclusiva de `Order Manager` (`EXEC-001`). Cálculo de risco é responsabilidade de `Risk Service` (`SPEC-001`, status `Planned`).

---

# Entradas

`Position Manager` recebe:

- `Order Accepted` (de `Order Manager`, `EXEC-001`);
- `Order Filled`;
- `Order Modified`;
- `Order Closed`;
- Broker Updates (via `MT5 Adapter`).

---

# Saídas

`Position Manager` produz:

- `Position Opened`;
- `Position Updated`;
- `Position Closed`;
- `Position Error`.

---

# Estados

Máquina de estados do ciclo de vida de uma posição:

```
No Position
↓
Pending
↓
Open
↓
Modified
↓
Closing
↓
Closed
↓
Archived
```

## Transições e condições

| De | Para | Condição |
|---|---|---|
| No Position | Pending | `Order Accepted` recebido de `Order Manager`, aguardando confirmação de preenchimento (`Order Filled`) |
| Pending | Open | `Order Filled` recebido — posição registrada com Ticket, Entry Price, Volume |
| Open | Modified | `Order Modified` recebido (alteração de Stop Loss/Take Profit/Volume) ou Broker Update relevante |
| Modified | Open | Alteração processada e consolidada — retorna ao estado estável Open |
| Open, Modified | Closing | `Order Closed` recebido ou encerramento detectado via Broker Update, aguardando confirmação final |
| Closing | Closed | Encerramento confirmado — Close Time e Profit final registrados |
| Closed | Archived | Posição consolidada, retida apenas para consulta histórica/auditoria |

---

# Atributos da Posição

Informações mínimas mantidas por posição:

- Ticket;
- Symbol;
- Direction;
- Volume;
- Entry Price;
- Current Price;
- Stop Loss;
- Take Profit;
- Open Time;
- Close Time;
- Profit;
- Status.

---

# Validações

`Position Manager` deve validar:

- duplicidade (mesmo Ticket registrado mais de uma vez);
- consistência do Ticket (Ticket recebido corresponde a uma posição conhecida ou a uma nova abertura legítima);
- estado válido (transição solicitada é permitida a partir do estado atual — ver "Estados");
- dados obrigatórios (todos os "Atributos da Posição" mínimos presentes antes de transicionar para Open).

---

# Eventos

`Position Manager` publica:

- `PositionOpened`;
- `PositionUpdated`;
- `PositionClosed`;
- `PositionError`.

---

# Consultas

Interface de consulta, sem implementação:

- `GetOpenPositions()`;
- `GetPosition()`;
- `HasOpenPosition()`.

---

# Dependências

## Permitidas

- `Order Manager` (`EXEC-001`);
- `MT5 Adapter` (`SPEC-001`, Execution Components, status `Planned`).

## Proibidas

- Core Domain (`Position Manager` nunca gera `Opportunity`/`Decision`, apenas reflete o estado de ordens já processadas por `Order Manager`);
- cálculo de indicadores ou acesso direto a `Data Provider`/`Indicator Provider`.

---

# Consumidores

`Position Manager` é consumido por:

- `Risk Service` (`SPEC-001`, status `Planned`) — **observação de dependência não satisfeita hoje**: assim como em `EXEC-001`, o formato exato do que `Risk Service` consome de `Position Manager` depende da classificação de `Risk Profile`, ainda `Open` em `RFC-001`;
- Logging;
- Dashboard;
- Auditoria.

---

# Casos de Teste

Cenários mínimos a documentar/implementar:

1. Primeira posição aberta;
2. Atualização de Stop;
3. Atualização de Volume;
4. Encerramento;
5. Erro de sincronização;
6. Ticket inexistente;
7. Duplicidade.

---

# Critérios de Aceitação

O componente deve:

- ser determinístico;
- ser independente do broker;
- não perder estado;
- permitir reconstrução após reinicialização (a partir de Broker Updates / consulta ao `MT5 Adapter`, sem depender de estado em memória sobrevivendo a um restart).

---

# Limitações

`Position Manager` não implementa:

- estratégia;
- gestão financeira;
- gestão de risco.

---

# Traceability

- Architecture Baseline v1.0 (`ADR-007`) — nenhum documento congelado alterado.
- `SPEC-001` (Position Manager catalogado, Execution Components).
- `EXEC-001` (Order Manager — origem de `Order Accepted`/`Order Filled`/`Order Modified`/`Order Closed`).
- `RFC-001` (dependência não satisfeita — Risk Profile Classification, Open).
- `DOCUMENT_INDEX.md`, `TRACEABILITY.md` — atualizados nesta entrega.

---

# Definition of Done

O documento estará concluído quando qualquer desenvolvedor puder implementar o `Position Manager` sem necessidade de decisões adicionais sobre seu comportamento funcional — exceto a resolução de `RFC-001`, explicitamente sinalizada como pendência externa a este documento.

---

# Próxima Entrega

A definir — Trilha 1 (Platform) segue com `INFRA-004 — Configuration Provider` ou continuidade de Execution Components (`Broker Adapter`, `MT5 Adapter`), conforme priorização do Product Owner.
