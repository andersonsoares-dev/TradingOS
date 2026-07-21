---
id: RFC-004
title: Legacy Indicator Mapping Ambiguity (Indicator Provider vs Evidence Builder)
version: 1.0.0
status: Open
owner: Product Owner
depends_on:
  - SPEC-001
  - SPEC-003
  - INFRA-003
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-004: Legacy Indicator Mapping Ambiguity

## Classificação

Requires Architectural Decision

## Contexto

Durante a Validação Prévia (Document Validation Pipeline) de `Docs/03-architecture/INFRA-003-Indicator-Provider.md` (Fase 2, Entrega 03), foi identificada uma divergência entre dois documentos da Baseline v1.0 congelada (`ADR-007`) quanto ao papel-alvo dos serviços de indicador da Legacy Baseline:

- `SPEC-001` (Component Lifecycle, categoria Infrastructure Providers) atribui `TrendService`, `ATRService`, `RSIService` e `ADXService` ao papel de **`Indicator Provider`**: *"Informal — cada serviço (TrendService, ATRService etc.) chama iMA/iRSI/iATR/iADX diretamente, sem abstração separada."*
- `SPEC-003` (Domain Services, seção Legacy Baseline) atribui os mesmos quatro serviços a **`Evidence Builder`**: *"TrendService, RSIService, ATRService e ADXService correspondem a Evidence Builder — ver SPEC-001, não Domain Service."*

`Indicator Provider` (Infrastructure Providers, `SPEC-001`) e `Evidence Builder` (Core Domain Builders, `SPEC-001`) são componentes distintos, em camadas arquiteturais distintas (Infrastructure vs. Core Domain). Os dois documentos, portanto, apontam a mesma Legacy Baseline para dois destinos diferentes na arquitetura-alvo.

Ambos os documentos (`SPEC-001`, `SPEC-003`) pertencem à Baseline congelada por `ADR-007` e não podem ser alterados para resolver a divergência dentro desta entrega.

## Proposta em aberto

Esta RFC não decide qual mapeamento está correto. Duas leituras são possíveis, ambas plausíveis dado que a Legacy Baseline é monolítica (cada serviço hoje busca o dado bruto via `iMA`/`iRSI`/`iATR`/`iADX` **e** já produz um resultado que se aproxima de uma leitura de mercado, sem separação formal entre as duas responsabilidades):

1. A migração futura separa cada serviço em duas partes: uma parte técnica (`Indicator Provider`, fornece o valor bruto do indicador) e uma parte de domínio (`Evidence Builder`, converte o valor em `Evidence` com Category/Confidence/Weight). Neste caso, ambos os SPECs estão parcialmente corretos, cada um descrevendo metade do papel legado.
2. Um dos dois documentos simplesmente está desatualizado ou impreciso quanto à categorização, e deveria ser corrigido para apontar consistentemente para o mesmo componente.

## Encaminhamento

`INFRA-003` seguiu o mapeamento de `SPEC-001` (Indicator Provider) por ser o Canonical Component Catalog — fonte única de nomenclatura de componentes (`AGENTS.md`). Esta escolha é operacional, não uma resolução da divergência.

Uma decisão formal (ADR ou RFC aprovada) deverá esclarecer se a Legacy Baseline migra para `Indicator Provider`, para `Evidence Builder`, ou se divide-se entre os dois — antes que qualquer especificação futura (`INFRA-00X` ou atualização de `SPEC-003`) assuma um dos dois mapeamentos como definitivo.

## Status

Open — aguardando decisão do Product Owner / Chief Architect.
