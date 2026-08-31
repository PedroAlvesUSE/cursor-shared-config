---
name: clickup-abrir-task
description: >-
  Abre tarefas no ClickUp (Data Team) com molde de descrição, lista padrão,
  responsáveis e campos customizados. Use when the user pede criar/abrir task,
  tarefa no ClickUp, Click, solicitação Data Team, ou atribuir responsável.
---

# clickup-abrir-task

## Quando usar

Sempre que o usuário pedir para criar/abrir tarefa no ClickUp (ou “Click”).

## Defaults do workspace

| Item | Valor |
|------|--------|
| Space | Data Team (`90130132321`) |
| Pasta atual | `2026` (`901315059788`) |
| Lista padrão | Solicitações (`901322499540`) |
| Status inicial | `backlog` (omitir no create = default da lista) |
| Responsável padrão (Pedro Henrique) | ID `194478583` · `pedro.henrique@useuniformesp.com.br` |

Listas históricas (só se o usuário pedir explicitamente): Q2 2025 `901308259066`, Q2 2024 `901303107178`.

## Fluxo obrigatório

1. Confirmar lista: se o usuário não disser, usar **2026 → Solicitações** (`901322499540`).
2. Montar **nome** curto e no imperativo/infinitivo de ação (ex.: `Avaliar coleta de imposto…`, `Integrar webhooks…`).
3. Montar `markdown_description` com o molde abaixo (adaptar seções ao pedido).
4. Criar com MCP `clickup_create_task`:
   - `list_id`, `name`, `markdown_description`
   - `assignees`: **sempre** `["194478583"]` quando for “pra mim” / Pedro Henrique (não confiar só em `"me"` no create — pode falhar)
   - `priority` só se o usuário pedir (`urgent` \| `high` \| `normal` \| `low`)
5. **Verificar** com `clickup_get_task`: `assignees` não pode ficar `[]`.
6. Se vazio: `clickup_update_task` com `assignees: ["194478583"]` (ou ID resolvido) e verificar de novo.
7. Responder com link `https://app.clickup.com/t/<task_id>`, lista e responsável.

### Resolver outros assignees

```text
clickup_resolve_assignees → ["Nome", "email", "me"]
```

Usar o ID numérico retornado em `create`/`update`. Preferir ID explícito a `"me"` na criação.

## Molde de descrição (markdown)

```markdown
## Objetivo
<1–2 frases: o que avaliar/entregar>

## Contexto
<por que agora; sistemas/integrações envolvidas>

## Escopo
- <item concreto 1>
- <item concreto 2>
- <item concreto 3>

## Entregável
<o que “pronto” significa: doc, PR, dashboard, etc.>
```

Omitir seções vazias. Não inventar escopo além do pedido do usuário.

## Campos customizados (lista Solicitações)

Preencher via `custom_fields` no create/update **só se o usuário informar** (ou se for óbvio no pedido):

| Campo | ID | Tipo | Notas |
|-------|-----|------|--------|
| Dados complementares (imagens, etc.) | `5985565c-281d-4883-b345-3cfd98030326` | attachment | |
| Data para entrega | `baad1bc7-3bbe-4fdb-b7b4-7943eeaca4a0` | date | `YYYY-MM-DD` |
| Para quem a tarefa deverá ser entregue | `91fdc163-f58f-42fb-a854-215e27e34c32` | short_text | |
| Quem solicita (Email) | `de4c863a-49be-4edf-8bd0-d2e5f32d9265` | email | |
| Resultado esperado | `5f81785d-e704-45a9-9608-95c627d185c5` | text | |
| Time solicitante | `d9e847f2-d8ff-477b-94f4-db4fdab75b8b` | dropdown | ver opções |
| Tipo de Solução | `7a674009-9f01-4b64-af33-e2b8c4b5d624` | dropdown | ver opções |

### Time solicitante (option UUID)

- Operação `f360d249-b74e-47b5-8f93-3e0a6dac2d1b`
- Lojas `2d79de77-b8ef-46aa-a0a9-257ad6931f8e`
- Marketing `5045f8a5-b519-426f-b9c9-3b9f63f06825`
- Growth `2633d055-8fc8-4e5a-aa7c-92e62ef4087d`
- Tecnologia `f5c20575-c2b2-4b0e-a3f5-68f2efde1b86`
- RH `d8695f39-e2c0-42b1-8acc-6dd18974d4d8`
- SAC `d4313be8-607e-4ee2-bfc9-b325b113a7d3`
- Gerência `c43ebd89-b9de-4eaf-a4e0-7657d642e53e`

### Tipo de Solução (option UUID)

- Data Analytics (1 à 3d) `876a9a51-d351-49ef-985b-6dce4ff7c59f`
- Data Engineer (4 à 10d) `cd347bb6-e43e-4622-9266-f79263cdbea7`
- Data Science (10d+) `9496702e-d4a0-4ecb-842a-8c83c1fa865e`
- Software Solution (1 à 3d) `8daf6825-92f3-4dd3-a192-c5fa0bf438fa`
- Software Development (4 à 10d) `1b22e97d-f894-4b89-a65b-678bf94c92b8`
- Software Integrations (10d+) `db468028-ecf8-4160-b262-f14b3cdb667f`

## Statuses da lista (referência)

`backlog` → `evaluated` → `in progress` → `wait` → `test` → `review` → `refused` → `locked` → `Closed`

Não mudar status na criação salvo pedido explícito.

## Exemplo

Pedido: “cria tarefa pra avaliar coletar imposto sobre pedidos do bling, atribui pra mim”

- Lista: `901322499540`
- Nome: `Avaliar coleta de imposto sobre pedidos via Bling`
- Assignees: `["194478583"]`
- Descrição: molde Objetivo/Contexto/Escopo/Entregável preenchido
- Pós-create: `get_task` → se `assignees` vazio → `update_task` → confirmar

## Checklist rápida

- [ ] Lista correta (default 2026/Solicitações)
- [ ] Nome acionável
- [ ] Descrição no molde
- [ ] Responsável com ID numérico
- [ ] `get_task` confirma assignees
- [ ] Link da task na resposta
