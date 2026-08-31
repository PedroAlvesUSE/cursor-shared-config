# ia — configs Cursor para o time

Repositório com **MCPs**, **rules**, **skills**, **hooks** e **user rules** para padronizar o Cursor no time.

Repo no GitHub: https://github.com/PedroAlvesUSE/ia

## Conteúdo

| Pasta / arquivo | Destino |
|-----------------|---------|
| `mcp/mcp.json.example` | `~/.cursor/mcp.json` (preencher secrets) |
| `mcp/README.md` | Guia do MCP MySQL |
| `rules/user/` | `~/.cursor/rules/` |
| `rules/global/` | `~/.cursor/*.mdc` |
| `skills/` | `~/.cursor/skills/` |
| `hooks/hooks.json` | `~/.cursor/hooks.json` |
| `user-rules/` | Cursor Settings → Rules → User Rules |
| `.cursor/rules/` | Drop-in para projetos |
| `scripts/install.sh` | Instalação automática |

## Instalação rápida

```bash
git clone https://github.com/PedroAlvesUSE/ia.git
cd ia
./scripts/install.sh
```

Depois:

1. Edite `~/.cursor/mcp.json` com host, usuário, senha e tokens reais.
2. Cole o conteúdo de `user-rules/*.md` em **Settings → Rules**.
3. Reinicie o Cursor.

## MCP MySQL

Servidor oficial usado pelo time: [benborla/mcp-server-mysql](https://github.com/benborla/mcp-server-mysql) (`@benborla29/mcp-server-mysql`).

Setup detalhado: [`mcp/README.md`](./mcp/README.md)

Exemplo mínimo (NPX):

```json
{
  "mcpServers": {
    "mcp_server_mysql": {
      "command": "npx",
      "args": ["-y", "@benborla29/mcp-server-mysql"],
      "env": {
        "MYSQL_HOST": "YOUR_MYSQL_HOST",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "YOUR_MYSQL_USER",
        "MYSQL_PASS": "YOUR_MYSQL_PASSWORD",
        "MYSQL_DB": "YOUR_DATABASE",
        "ALLOW_INSERT_OPERATION": "false",
        "ALLOW_UPDATE_OPERATION": "false",
        "ALLOW_DELETE_OPERATION": "false"
      }
    }
  }
}
```

Requisitos: Node.js 20+, MySQL 5.7+. Escrita desligada por padrão.

Para SSL/mTLS, use [`mcp/mcp.json.ssl.example`](./mcp/mcp.json.ssl.example).

## Outros MCPs no template

- **headroom**: compressão de contexto (`headroom mcp serve`)
- **openobserve**: URL + header `Authorization: Basic …` (preencher localmente)

## Segurança

- Nunca commitar `mcp.json` com senhas ou tokens
- Certificados `.pem` fora do repositório
- Só o `mcp.json.example` é versionado

## Notas

- `skills-cursor/` (skills gerenciadas pelo Cursor) não entram neste repo
- `rules/user/10x-tool-calls.mdc` é opcional/pessoal
