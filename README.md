# cursor-team-config

Configurações compartilháveis do Cursor para o time: **MCPs**, **rules**, **skills**, **hooks** e **user rules**.

## Conteúdo

| Pasta | Destino no Cursor |
|-------|-------------------|
| `mcp/mcp.json.example` | `~/.cursor/mcp.json` (preencher secrets) |
| `rules/user/` | `~/.cursor/rules/` |
| `rules/global/` | `~/.cursor/*.mdc` |
| `skills/` | `~/.cursor/skills/` |
| `hooks/hooks.json` | `~/.cursor/hooks.json` |
| `user-rules/` | Cursor Settings → Rules → User Rules |
| `.cursor/rules/` | Cópia pronta para uso em projetos |

## Instalação rápida

```bash
git clone <URL_DESTE_REPO>
cd cursor-team-config
./scripts/install.sh
```

Depois:

1. Edite `~/.cursor/mcp.json` com host, usuário, senha e tokens reais.
2. Cole o conteúdo de `user-rules/*.md` em **Settings → Rules**.
3. Reinicie o Cursor.

## Segurança

- **Nunca** commite `mcp.json` com senhas ou tokens.
- O arquivo versionado é só `mcp/mcp.json.example` com placeholders.
- Certificados SSL (`.pem`) ficam fora do repositório.

## Notas

- `skills-cursor/` (skills gerenciadas pelo Cursor) não entram neste repo.
- `rules/user/10x-tool-calls.mdc` é opcional/pessoal; o time pode omitir.
