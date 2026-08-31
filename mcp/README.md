# MCP MySQL

Servidor: [benborla/mcp-server-mysql](https://github.com/benborla/mcp-server-mysql)  
Pacote npm: `@benborla29/mcp-server-mysql`

Permite ao Cursor inspecionar schema e executar queries MySQL via tool `mysql_query`. Escrita desabilitada por padrão.

## Requisitos

- Node.js 20+
- MySQL 5.7+ (8.0+ recomendado)
- Usuário MySQL com privilégios adequados

## Configuração no Cursor (`~/.cursor/mcp.json`)

### Opção recomendada: NPX

```json
{
  "mcpServers": {
    "mcp_server_mysql": {
      "command": "npx",
      "args": ["-y", "@benborla29/mcp-server-mysql"],
      "env": {
        "MYSQL_HOST": "127.0.0.1",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASS": "YOUR_MYSQL_PASSWORD",
        "MYSQL_DB": "seu_banco",
        "ALLOW_INSERT_OPERATION": "false",
        "ALLOW_UPDATE_OPERATION": "false",
        "ALLOW_DELETE_OPERATION": "false"
      }
    }
  }
}
```

Templates:

- [`mcp.json.example`](./mcp.json.example) — conexão padrão (sem SSL)
- [`mcp.json.ssl.example`](./mcp.json.ssl.example) — SSL/mTLS

### Opção: clone local

```bash
git clone https://github.com/benborla/mcp-server-mysql.git
cd mcp-server-mysql
pnpm install && pnpm run build
```

```json
{
  "mcpServers": {
    "mcp_server_mysql": {
      "command": "node",
      "args": ["/ABS/PATH/TO/mcp-server-mysql/dist/index.js"],
      "env": {
        "MYSQL_HOST": "127.0.0.1",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASS": "YOUR_MYSQL_PASSWORD",
        "MYSQL_DB": "seu_banco",
        "ALLOW_INSERT_OPERATION": "false",
        "ALLOW_UPDATE_OPERATION": "false",
        "ALLOW_DELETE_OPERATION": "false"
      }
    }
  }
}
```

## Variáveis principais

| Variável | Default | Descrição |
|----------|---------|-----------|
| `MYSQL_HOST` | `127.0.0.1` | Host |
| `MYSQL_PORT` | `3306` | Porta |
| `MYSQL_USER` | `root` | Usuário |
| `MYSQL_PASS` | — | Senha |
| `MYSQL_DB` | — | Banco (omitir = multi-DB) |
| `MYSQL_SSL` | `false` | Liga SSL/TLS |
| `MYSQL_SSL_CA` | — | CA PEM |
| `MYSQL_SSL_CERT` | — | Cert cliente PEM (mTLS) |
| `MYSQL_SSL_KEY` | — | Key cliente PEM (mTLS) |
| `ALLOW_INSERT_OPERATION` | `false` | Libera INSERT |
| `ALLOW_UPDATE_OPERATION` | `false` | Libera UPDATE |
| `ALLOW_DELETE_OPERATION` | `false` | Libera DELETE |
| `ALLOW_DDL_OPERATION` | `false` | Libera DDL |

Referência completa: [docs/CONFIGURATION.md](https://github.com/benborla/mcp-server-mysql/blob/main/docs/CONFIGURATION.md)

## Segurança

- Não versionar senhas, tokens nem `.pem`
- Preferir writes desligados em ambientes compartilhados
- Copiar `mcp.json.example` → `~/.cursor/mcp.json` e preencher localmente

## Docs oficiais

- [README](https://github.com/benborla/mcp-server-mysql)
- [Instalação](https://github.com/benborla/mcp-server-mysql/blob/main/docs/INSTALLATION.md)
- [Smithery (Cursor)](https://smithery.ai/server/@benborla29/mcp-server-mysql)
