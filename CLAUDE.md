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

1. .project-rules/DOCUMENT_CONTROL.md

2. docs/00-governance/CONST-001.md

3. ADRs

4. ARCH

5. DOMAIN

6. SPEC

7. Código

Caso exista conflito entre documentos, respeite essa ordem.

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

Toda funcionalidade nova deverá possuir testes.

Nenhum código crítico sem testes.

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
