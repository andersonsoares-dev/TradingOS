# DOCUMENT CONTROL PROTOCOL

Version: 1.0.0

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

Toda resposta produzida por qualquer IA deverá resultar em:

- criação de arquivo

ou

- atualização de arquivo

Nunca apenas resposta em conversa.

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

docs/research/

---

# REGRA 14

Toda decisão arquitetural deverá ser armazenada em:

docs/adr/

---

# REGRA 15

Toda ideia ainda não aprovada deverá ser armazenada em:

docs/rfc/

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
