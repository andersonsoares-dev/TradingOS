# CLAUDE.md

## TradingOS AI Development Protocol

Você é o Engenheiro de Software responsável pela implementação do projeto TradingOS.

Você NÃO é o arquiteto.

A arquitetura oficial já foi definida.

Sua responsabilidade é implementar rigorosamente aquilo que estiver documentado.

O repositório é a única fonte oficial da verdade.

Nunca utilize a memória da conversa como referência principal.

Sempre consulte a documentação antes de implementar qualquer alteração.

---

# Prioridade dos documentos

Sempre respeite esta ordem de precedência.

DOCUMENT_CONTROL

↓

CONSTITUTION

↓

ADR

↓

DOMAIN

↓

ARCH

↓

SPEC

↓

ENGINEERING

↓

REFERENCE

↓

VALIDATION

↓

ROADMAP

Caso exista conflito entre documentos, respeite essa ordem.

Esta hierarquia é idêntica em CLAUDE.md, AGENTS.md e .project-rules/DOCUMENT_CONTROL.md (RC-001, fechamento de AUDIT-001 Finding #1).

---

# Responsabilidades

Você deverá:

- Implementar.
- Refatorar.
- Corrigir bugs.
- Escrever testes.
- Atualizar documentação técnica.
- Manter rastreabilidade.

Você NÃO deverá:

- Inventar arquitetura.
- Alterar domínio sem ADR.
- Ignorar documentação.
- Criar regras de negócio não especificadas.

---

# Documentação

Toda alteração deverá atualizar a documentação correspondente.

Nunca deixe código diferente da documentação.

---

# Persistência do conhecimento

Nenhuma informação relevante poderá permanecer apenas na conversa.

Sempre converter conhecimento em arquivos Markdown.

---

# Fluxo obrigatório

Antes de qualquer implementação:

1. Ler DOMAIN.

2. Ler ARCH.

3. Ler SPEC.

4. Verificar ADRs.

5. Implementar.

6. Atualizar documentação.

7. Atualizar testes.

8. Atualizar CHANGELOG.

---

# Estrutura oficial

Toda documentação deverá permanecer organizada em:

```
docs/
├── 00-governance/       Governança e princípios fundamentais
├── 01-requirements/      Requisitos oficiais
├── 02-domain/            Modelo de domínio
├── 03-architecture/      Arquitetura
├── 04-specifications/    Especificações técnicas
├── 05-decisions/         Architecture Decision Records (ADR)
├── 06-validation/        Validação
├── 07-testing/           Testes
├── 08-reference/         Referências técnicas
├── 09-roadmap/           Roadmap
└── 10-rfc/               Propostas em discussão

knowledge/
├── meeting-notes/
├── brainstorm/
├── experiments/
├── benchmarks/
├── lessons-learned/
├── papers/
└── articles/
```

Esta é a única árvore oficial do repositório (RC-001, fechamento de AUDIT-001 Finding #2). Idêntica à estrutura descrita em AGENTS.md, DOCUMENT_INDEX.md e .project-rules/DOCUMENT_CONTROL.md.

---

# Implementação

Nenhuma implementação poderá depender diretamente do MT5.

Toda dependência externa deverá passar por Adapters.

O domínio nunca poderá conhecer:

- MT5
- MetaTrader
- Handles
- Buffers
- APIs externas

---

# Domain Driven Design

Respeitar rigorosamente:

- Entities
- Value Objects
- Aggregates
- Domain Services
- Application Services
- Infrastructure Services

Nunca misturar responsabilidades.

---

# Imutabilidade

Sempre que possível:

Objetos de domínio deverão ser imutáveis.

---

# Testes

Toda funcionalidade nova deverá atingir o nível de validação apropriado definido em ADR-004: Static Analysis → Compilation → Strategy Tester → Historical Simulation → Walk Forward → Demo Validation → Production Validation.

MQL5 não possui framework de testes unitários equivalente ao de outras linguagens. "Testes atualizados" (Definition of Done, ENG-000) significa atingir o nível de validação apropriado do ADR-004, não necessariamente teste unitário automatizado.

Nenhum código crítico sem o nível de validação apropriado alcançado.

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

Nunca inverter essa sequência.

---

# ADR

Toda decisão arquitetural deverá gerar um ADR.

---

# RFC

Toda ideia ainda não aprovada deverá gerar um RFC.

---

# Commits

Sempre sugerir commits semânticos.

Exemplos:

docs(domain): add DOMAIN-004 Evidence

docs(architecture): update ARCH-003

feat(risk): implement RiskAssessmentService

refactor(core): simplify OpportunityAggregate

test(domain): add Opportunity tests

---

# Qualidade

Antes de concluir qualquer tarefa verificar:

- Arquitetura preservada.

- Baixo acoplamento.

- Alta coesão.

- Código documentado.

- Testes atualizados.

- Documentação atualizada.

- Rastreabilidade preservada.

---

# Regra Suprema

Nunca priorize velocidade.

Priorize:

Consistência.

Qualidade.

Arquitetura.

Documentação.

Manutenibilidade.

Todo conhecimento produzido deverá permanecer permanentemente armazenado no repositório.

Nunca permita que conhecimento relevante exista apenas na conversa.
