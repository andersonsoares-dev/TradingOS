# AGENTS.md

## TradingOS Universal AI Protocol

Este documento define as regras obrigatórias para qualquer agente de IA que participe do desenvolvimento do TradingOS.

Inclui:

- Claude
- ChatGPT
- Codex
- Gemini
- Cursor
- Copilot
- qualquer outro agente futuro.

---

# Objetivo

Garantir que qualquer IA produza exatamente o mesmo padrão de engenharia.

Nenhuma IA possui autoridade para modificar a arquitetura do projeto.

A arquitetura pertence ao repositório.

---

# Single Source of Truth

A única fonte oficial da verdade é o repositório Git.

Nunca utilize memória da conversa como referência principal.

Sempre consultar os documentos oficiais.

---

# Ordem de precedência

1. .project-rules/DOCUMENT_CONTROL.md

2. docs/00-governance/CONST-001.md

3. ADR

4. DOMAIN

5. ARCH

6. SPEC

7. Código

Em caso de conflito seguir exatamente essa ordem.

---

# Responsabilidades dos agentes

Os agentes podem:

- Implementar
- Refatorar
- Escrever documentação
- Escrever testes
- Corrigir bugs
- Atualizar índices
- Criar ADR
- Criar RFC

Os agentes não podem:

- Inventar arquitetura
- Modificar domínio sem ADR
- Ignorar documentação
- Alterar contratos públicos sem aprovação
- Excluir documentação

---

# Documentação

Toda alteração deverá atualizar a documentação correspondente.

Nunca permitir divergência entre documentação e código.

---

# Persistência do conhecimento

Toda decisão aprovada, alteração arquitetural, regra de negócio consolidada ou conhecimento definitivo deverá resultar na criação ou atualização de documentos do repositório.

Discussões exploratórias, brainstorms, análises comparativas e revisões arquiteturais podem permanecer apenas na conversa até que uma decisão seja aprovada.

---

# Estrutura oficial

Esta passa a ser a **única estrutura oficial** do projeto (ver Docs/CHANGELOG.md — Repository Structure Stabilization).

docs/

├── 00-governance/

├── 01-requirements/

├── 02-domain/

├── 03-architecture/

├── 04-specifications/

├── 05-decisions/

├── 06-validation/

├── 07-testing/

├── 08-reference/

├── 09-roadmap/

└── 10-rfc/

knowledge/

├── meeting-notes/

├── brainstorm/

├── experiments/

├── benchmarks/

├── lessons-learned/

├── papers/

└── articles/

---

# Identificação de Documentos

Todo documento deverá ser referenciado pelo seu `id` (exemplo: `DOMAIN-003`, `ARCH-001`, `ADR-005`), nunca pelo caminho físico do arquivo.

Caminhos físicos podem mudar em reorganizações futuras de diretórios. A identidade lógica (`id`) nunca muda.

Referências cruzadas (`depends_on`, `related`, menções em outros documentos) deverão sempre usar o `id`, não o caminho.

`DOCUMENT_INDEX.md` é o único lugar responsável por mapear cada `id` ao seu caminho físico atual.

---

## Canonical Naming

Antes de criar qualquer novo documento, verificar obrigatoriamente o SPEC-001.

É proibido introduzir novos nomes para componentes existentes.

Qualquer novo componente deverá ser registrado primeiro em SPEC-001.

---

# Documentation Validation Pipeline

Antes de criar QUALQUER documento novo o agente deverá obrigatoriamente executar a seguinte sequência.

PASSO 1

Ler:

DOMAIN-002-Ubiquitous-Language

Validar:

• nenhum termo novo

• nenhuma alteração semântica

PASSO 2

Ler:

SPEC-001 Component Model

Validar:

• componente já existe?

• categoria correta?

• responsabilidade correta?

É proibido criar componente novo sem atualizar previamente o SPEC-001.

PASSO 3

Ler:

ARCH-001

Validar:

• dependências

• bounded contexts

• fluxo arquitetural

PASSO 4

Ler:

TRACEABILITY

Validar:

• rastreabilidade

• referências

• dependências

PASSO 5

Somente após as quatro validações o novo documento poderá ser criado.

---

# Fluxo obrigatório

Antes de implementar:

1. Ler DOCUMENT_CONTROL.

2. Ler Constituição.

3. Ler ADRs.

4. Ler DOMAIN.

5. Ler ARCH.

6. Ler SPEC.

7. Implementar.

8. Atualizar documentação.

9. Atualizar testes.

10. Atualizar CHANGELOG.

11. Atualizar DOCUMENT_INDEX.

12. Atualizar TRACEABILITY.

---

# Domain Driven Design

Respeitar rigorosamente:

Entities

Value Objects

Aggregates

Domain Services

Application Services

Infrastructure Services

Ports

Adapters

Repositories

Factories

Policies

Events

Nunca misturar responsabilidades.

---

# Arquitetura

Sempre respeitar:

REQ

↓

DOMAIN

↓

ARCH

↓

SPEC

↓

SOURCE

↓

TEST

↓

VALIDATION

Nunca inverter esse fluxo.

---

# Implementação

O domínio nunca poderá conhecer:

MT5

MetaTrader

Broker

REST

FIX

Banco de Dados

Sistema Operacional

Toda integração deverá ocorrer através de Adapters.

---

# Testes

Toda funcionalidade nova deverá possuir:

Testes Unitários

Testes de Integração

quando aplicável.

---

# ADR

Toda decisão arquitetural gera um ADR.

Nunca modificar arquitetura silenciosamente.

---

# RFC

Toda ideia ainda não aprovada gera um RFC.

---

# Commits

Sempre sugerir commits semânticos.

Exemplos:

docs(domain): add DOMAIN-005

docs(spec): update SPEC-003

feat(core): implement ContextBuilder

refactor(domain): simplify OpportunityAggregate

test(core): add Context tests

---

# Qualidade

Antes de concluir qualquer tarefa verificar:

Arquitetura preservada

Baixo acoplamento

Alta coesão

Código limpo

Documentação atualizada

Testes atualizados

Rastreabilidade preservada

Sem duplicação de conhecimento

---

# Regra Suprema

O projeto pertence ao repositório.

Nunca à memória de uma IA.

Nunca à memória de um desenvolvedor.

Toda informação produzida deverá permanecer permanentemente armazenada em arquivos versionados.

O conhecimento deve sobreviver à troca de qualquer agente de IA.
