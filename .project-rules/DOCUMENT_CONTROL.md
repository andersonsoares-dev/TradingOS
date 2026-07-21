# DOCUMENT CONTROL PROTOCOL

Version: 1.2.0

Status: Approved

Owner: Product Owner

---

## Purpose

Estabelecer as regras obrigatórias de gestão do conhecimento do projeto TradingOS.

Este documento possui prioridade sobre qualquer instrução operacional relacionada à documentação.

---

# PRINCÍPIO FUNDAMENTAL

Todo conhecimento produzido durante o desenvolvimento do TradingOS pertence ao projeto.

Nunca à memória de uma IA.

Nunca à memória de um desenvolvedor.

Nunca às conversas.

Todo conhecimento deverá ser convertido em um artefato versionado dentro do repositório.

O repositório é a única fonte oficial da verdade (Single Source of Truth).

---

# ORDEM DE PRECEDÊNCIA DOCUMENTAL

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

Em caso de conflito entre documentos, respeitar exatamente esta ordem.

Esta hierarquia é idêntica em CLAUDE.md, AGENTS.md e neste documento (RC-001, fechamento de AUDIT-001 Finding #1).

---

# ESTRUTURA OFICIAL DO REPOSITÓRIO

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

Esta é a única árvore oficial do repositório (RC-001, fechamento de AUDIT-001 Finding #2). Idêntica à estrutura descrita em AGENTS.md e DOCUMENT_INDEX.md.

---

# REGRA 1

Nenhuma decisão arquitetural poderá permanecer apenas na conversa.

Toda decisão deverá gerar um ADR.

---

# REGRA 2

Toda pesquisa deverá ser armazenada em Markdown.

Nunca apenas resumida na conversa.

---

# REGRA 3

Toda especificação deverá ser salva no repositório.

---

# REGRA 4

Todo documento criado deverá ser imediatamente persistido.

Nunca aguardar "mais tarde".

---

# REGRA 5

Nenhum conhecimento poderá depender da memória da IA.

---

# REGRA 6

Markdown (.md) é o formato oficial do projeto.

DOCX, PDF e HTML são apenas formatos derivados.

---

# REGRA 7

Todo documento possuirá:

- id
- título
- versão
- status
- dependências
- rastreabilidade
- histórico

---

# REGRA 8

Toda conversa relevante deverá gerar documentação permanente.

---

# REGRA 9

Toda implementação deverá possuir rastreabilidade completa.

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

---

# REGRA 10

Nenhum arquivo poderá ser apagado.

Arquivos obsoletos recebem:

Status: Deprecated

---

# REGRA 11

Toda decisão aprovada, alteração arquitetural, regra de negócio consolidada ou conhecimento definitivo deverá resultar na criação ou atualização de documentos do repositório.

Discussões exploratórias, brainstorms, análises comparativas e revisões arquiteturais podem permanecer apenas na conversa até que uma decisão seja aprovada.

---

# REGRA 12

Sempre atualizar:

CHANGELOG.md

DOCUMENT_INDEX.md

TRACEABILITY.md

quando aplicável.

---

# REGRA 13

Toda pesquisa deverá ser armazenada em:

knowledge/papers/

ou

knowledge/articles/

---

# REGRA 14

Toda decisão arquitetural deverá ser armazenada em:

05-decisions/

---

# REGRA 15

Toda ideia ainda não aprovada deverá ser armazenada em:

10-rfc/

---

# REGRA 16

Todo resumo de reunião deverá ser armazenado em:

knowledge/meeting-notes/

---

# REGRA 17

Todo experimento deverá ser armazenado em:

knowledge/experiments/

Mesmo experimentos fracassados.

---

# REGRA 18

Toda lição aprendida deverá ser registrada.

---

# REGRA 19

Nunca duplicar conhecimento.

Atualizar o documento existente.

---

# REGRA 20

O repositório Git é a memória permanente do projeto.

As conversas são temporárias.

Sempre que qualquer IA produzir conhecimento relevante, ele deverá ser persistido imediatamente no repositório.

---

# OBSERVAÇÃO — Architecture Baseline v1.0

Os documentos de Governança, Domínio, Arquitetura e Especificações pertencentes à Baseline v1.0 encontram-se congelados.

Alterações somente poderão ocorrer mediante:

• ADR

ou

• RFC aprovada

ou

• correção documental sem impacto arquitetural.
