---
id: LEARN-001
title: Knowledge Service
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - DOMAIN-006
  - ARCH-001
  - ADR-010
  - SPEC-001
related:
  - SPEC-002
last_updated: 2026-07-22
---

# Knowledge Service

Especificação técnica do `Knowledge Service`, primeiro componente concreto do Learning Domain (`ADR-010`). Implementa tecnicamente `DOMAIN-006`. Não altera arquitetura, ADRs, DOMAINs ou o Ubiquitous Language — define exclusivamente como o serviço será implementado.

**Nota de família/id**: solicitado originalmente como `SPEC-004` — id já em uso (`Application Services`, congelado desde `ADR-007`/`ADR-009`/`ADR-012`). Além disso, `ADR-009 §4` reserva `SPEC-00X` para categorias inteiras (Domain Services, Application Services, Business Rules), não componentes isolados — mesma razão pela qual `Order Manager`/`Position Manager` viraram `EXEC-001`/`EXEC-002` em vez de `SPEC-00X`. Por analogia com `INFRA-*`/`EXEC-*` (componentes individuais de um Bounded Context, em `Docs/03-architecture/`), criado como `LEARN-001`, inaugurando a família `LEARN-*` para componentes do Learning Domain. `Knowledge Service` registrado em `SPEC-001` (v1.5.0) como parte desta mesma entrega, conforme `ADR-010` já previa ("por registro próprio e posterior").

---

# Objetivo

Definir a especificação técnica do `Knowledge Service`, responsável por gerenciar o conhecimento do Learning Domain.

---

# Escopo

Especifica:

- responsabilidades do serviço;
- interfaces públicas;
- contratos;
- dependências;
- fluxo operacional;
- persistência;
- versionamento;
- critérios de validação.

Não escreve código.

---

# Responsabilidades

O Knowledge Service deverá ser responsável por:

- armazenar objetos de Knowledge;
- recuperar Knowledge por critérios;
- registrar novas versões;
- manter rastreabilidade;
- disponibilizar consultas para consumidores autorizados.

## Não Responsabilidades

O serviço NÃO realiza aprendizado.

O serviço NÃO executa decisões.

O serviço NÃO produz Evidence.

---

# Entradas

- Knowledge Object
- Knowledge Identifier
- Categoria
- Origem
- Versão
- Metadados

---

# Saídas

- Knowledge
- Knowledge Collection
- Knowledge Metadata
- Status

---

# Interfaces

Operações públicas (assinaturas conceituais, não código):

- `CreateKnowledge()`
- `UpdateKnowledge()`
- `GetKnowledge()`
- `FindKnowledge()`
- `ListKnowledge()`
- `ArchiveKnowledge()`

---

# Regras

O Knowledge Service deve garantir:

- **Imutabilidade**: uma versão publicada de Knowledge nunca é alterada em memória — apenas superseded por uma nova versão (`DOMAIN-006`, ciclo de vida `Proposed → Validated → Published → Superseded`).
- **Versionamento**: cada alteração a um Knowledge existente cria uma nova versão rastreável; nenhuma versão anterior é sobrescrita.
- **Unicidade**: cada `Knowledge Identifier` referencia exatamente um objeto de Knowledge (e seu histórico de versões).
- **Rastreabilidade**: toda operação de escrita (`CreateKnowledge`/`UpdateKnowledge`/`ArchiveKnowledge`) preserva origem e histórico.
- **Integridade**: nenhum Knowledge é aceito sem os atributos mínimos exigidos por `DOMAIN-006`.

---

# Dependências

## Permitido

- `DOMAIN-006`
- `ARCH-001`
- `ADR-010`
- `SPEC-001`

## Proibido

- Execution
- Broker
- Infrastructure específica

---

# Fluxo

```
Receber objeto
↓
Validar
↓
Persistir
↓
Versionar
↓
Disponibilizar
```

---

# Persistência

Requisitos apenas — nenhuma tecnologia escolhida:

- suporte a versionamento;
- histórico;
- auditoria;
- recuperação.

---

# Critérios de Qualidade

- compatibilidade com `DOMAIN-006`;
- compatibilidade com `ARCH-001`;
- ausência de dependências indevidas;
- contratos consistentes;
- rastreabilidade completa.

---

# Fora de Escopo

- banco de dados;
- formato físico de armazenamento;
- API REST;
- implementação;
- geração de código.

---

# Rastreabilidade

`DOMAIN-006` · `ARCH-001` · `ADR-010` · `SPEC-001` (v1.5.0 — Learning Domain Components) · `SPEC-002`
