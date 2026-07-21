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

Nenhum conhecimento poderá permanecer apenas na conversa.

Toda informação relevante deverá ser salva em Markdown.

---

# Estrutura oficial

docs/

00-governance/

01-domain/

02-architecture/

03-specifications/

04-validation/

05-development/

06-research/

07-knowledge/

08-adr/

09-rfc/

10-roadmap/

knowledge/

meeting-notes/

brainstorm/

experiments/

benchmarks/

lessons-learned/

papers/

articles/

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
