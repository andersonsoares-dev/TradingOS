---
id: LEARN-002
title: Learning Service
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-006
  - ARCH-001
  - ADR-010
  - SPEC-001
  - LEARN-001
related:
  - VALIDATION-001
last_updated: 2026-07-22
---

# Learning Service

Especificação técnica do `Learning Service`, responsável por processar resultados operacionais e gerar novos objetos de `Knowledge` para o Learning Domain. Implementa tecnicamente `ADR-010` e `DOMAIN-006`. Não altera arquitetura, ADRs, DOMAINs, Ubiquitous Language ou Core Domain — define exclusivamente como o serviço será implementado.

**Nota de família/id**: solicitado originalmente como `SPEC-005` — id já em uso (`Domain Lifecycle`, congelado desde `ADR-007`/`ADR-009`/`ADR-012`). Mesma razão do `LEARN-001`: `ADR-009 §4` reserva `SPEC-00X` para categorias inteiras, não componentes isolados. Criado como `LEARN-002`, continuando a família inaugurada por `LEARN-001` para componentes do Learning Domain.

**Nota de correção — entrada "Execution Result"**: a brief de origem listava `Execution Result` como entrada suportada. Removida: `ADR-010` estabelece que *"o Learning Domain não invoca componentes de Execution"* e opera *"sem acesso direto a Infrastructure ou Execution"*; `DOMAIN-006` reforça que `Knowledge` só pode ser criado a partir de `Outcome` produzido pela `Validation` — nunca diretamente da Platform/Execution. As entradas abaixo refletem exclusivamente resultados já processados pela Validation (Trilha 2).

**Nota de correção — dependência "SPEC-004"**: a brief de origem listava `SPEC-004` (Application Services) como dependência permitida. Substituída por `LEARN-001` (Knowledge Service) — o Learning Service encaminha objetos ao Knowledge Service (`## Responsabilidades`), não a Application Services, que não tem relação com este fluxo.

---

# Objetivo

Especificar tecnicamente o `Learning Service`.

---

# Escopo

Especifica:

- responsabilidades;
- contratos;
- interfaces;
- entradas;
- saídas;
- fluxo operacional;
- regras de processamento;
- critérios de validação.

Não escreve código.

---

# Responsabilidades

O Learning Service deverá ser responsável por:

- receber resultados operacionais já processados pela Validation (`Outcome`);
- analisar padrões;
- gerar propostas de novo Knowledge;
- atualizar métricas históricas;
- registrar histórico de aprendizado;
- encaminhar objetos para o Knowledge Service (`LEARN-001`).

## Não Responsabilidades

O serviço NÃO executa operações.

O serviço NÃO toma decisões de mercado.

O serviço NÃO produz Evidence.

O serviço NÃO altera objetos existentes diretamente.

O serviço NÃO acessa Execution ou Infrastructure diretamente (`ADR-010`).

---

# Entradas

- Outcome
- Performance Metrics
- Validation Result
- Learning Event

Todas as entradas têm origem exclusiva na Validation (Trilha 2, `ADR-008`) — nenhuma entrada é consumida diretamente de Execution ou Infrastructure.

---

# Saídas

- Learning Result
- Knowledge Proposal
- Updated Metrics
- Learning Metadata
- Status

---

# Interfaces

Operações públicas (assinaturas conceituais, não código):

- `ProcessOutcome()`
- `GenerateKnowledge()`
- `EvaluateLearning()`
- `UpdateMetrics()`
- `RegisterLearning()`
- `GetLearningHistory()`

---

# Regras

O Learning Service deve garantir:

- **Rastreabilidade**: todo `Knowledge Proposal` gerado referencia o(s) `Outcome` que o originaram.
- **Reprodutibilidade**: o mesmo conjunto de `Outcome` processado novamente produz o mesmo `Knowledge Proposal` (`DOMAIN-006`).
- **Versionamento**: cada geração de proposta é registrada como evento distinto, sem sobrescrever histórico anterior.
- **Auditabilidade**: todo processamento é reconstituível a partir do histórico de aprendizado.
- **Consistência temporal**: métricas históricas são atualizadas de forma incremental, sem invalidar registros anteriores.
- **Não destruição do histórico**: nenhum registro de aprendizado é apagado — apenas superseded, mesmo princípio de retenção de `DOCUMENT_CONTROL` (Regra 10) e do ciclo de vida de `Knowledge` (`DOMAIN-006`).

---

# Dependências

## Permitido

- `DOMAIN-006`
- `ARCH-001`
- `ADR-010`
- `SPEC-001`
- `LEARN-001`

## Proibido

- Execution
- Broker
- Infrastructure específica
- Banco de dados
- LLM
- API REST

---

# Fluxo Operacional

```
Receber resultado (Outcome)
↓
Validar
↓
Processar
↓
Gerar proposta de Knowledge
↓
Registrar histórico
↓
Encaminhar ao Knowledge Service
```

---

# Persistência

Requisitos apenas — nenhuma tecnologia escolhida:

- histórico completo;
- auditoria;
- versionamento;
- rastreabilidade;
- recuperação.

---

# Critérios de Qualidade

- compatibilidade com `ADR-010`;
- compatibilidade com `DOMAIN-006`;
- compatibilidade com `LEARN-001`;
- ausência de dependência do Core Domain;
- ausência de dependência de infraestrutura;
- contratos consistentes.

---

# Fora de Escopo

- banco de dados;
- API;
- formato físico;
- implementação;
- código;
- novos conceitos arquiteturais.

---

# Rastreabilidade

`DOMAIN-006` · `ARCH-001` · `ADR-010` · `SPEC-001` (v1.5.0) · `LEARN-001` · `VALIDATION-001` (fonte indireta de `Outcome`, via Validation)
