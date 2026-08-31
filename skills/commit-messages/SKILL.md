---
name: commit-messages
description: >-
  Escreve e cria commits no padrão Conventional Commits em português (imperativo,
  tipo/escopo, HEREDOC, sem secrets). Use when the user pede commit, mensagem de
  commit, git commit, ou para padronizar histórico git.
---

# commit-messages

## Quando usar

Antes de redigir ou executar `git commit` pedido pelo usuário. Só commit quando o usuário pedir explicitamente.

## Formato

```text
<tipo>(<escopo opcional>): <descrição curta no imperativo>

<corpo opcional — o quê/por quê, não o como linha a linha>
```

- Subject ≤ ~72 caracteres; **sem ponto final**
- Imperativo: `adiciona`, `corrige`, `move`, `unifica` (não “adicionado” / “fixei”)
- Escopo em minúsculas quando ajudar: `domain`, `api`, `auth`, `reports`, `ci`, `cursor`
- Um commit = uma intenção; se misturar temas, preferir 2+ commits
- Nunca commitar secrets: `.env`, `config.json`, `Certs/`, `*.pem` / `*.key`, credenciais
- Passar a mensagem via HEREDOC:

```bash
git commit -m "$(cat <<'EOF'
tipo(escopo): descrição no imperativo

EOF
)"
```

## Tipos

| Tipo | Quando usar |
|------|-------------|
| `feat` | Nova capacidade / comportamento observável |
| `fix` | Corrige bug |
| `refactor` | Mudança interna sem mudar contrato de propósito |
| `docs` | Só documentação (README, `docs/`, comentários de contrato) |
| `test` | Só testes |
| `perf` | Melhoria de performance |
| `ci` | Workflows GitHub Actions / pipeline |
| `chore` | Manutenção (deps, ignore, tooling) sem lógica de produto |
| `style` | Formatação sem mudança de comportamento |

Evitar `update:` genérico — preferir `feat`, `fix` ou `refactor`.

## Fluxo obrigatório

1. Em paralelo: `git status`, `git diff` (staged + unstaged), `git log -n 10 --oneline` (alinhar estilo do repo)
2. Separar o que entra no commit; não incluir arquivos de secret
3. Redigir mensagem focada no **porquê** / efeito
4. `git add` só dos paths relevantes → `git commit` com HEREDOC → `git status` para confirmar
5. Se o hook rejeitar, corrigir e criar **novo** commit (não `--amend`, salvo regras de amend do usuário)
6. Não push a menos que o usuário peça

## Exemplos (bom)

```text
feat(domain): encapsula estado financeiro com MarkPaid e SoftDelete

fix(auth): remove middleware duplicado e mantém PermissionHandler

perf(reports): agrega totais no SQL e evita stampede no cache

docs: documenta date_basis cash|competence no contrato front

ci: sincroniza staging automaticamente a cada push em main
```

## Exemplos (ruim)

```text
update: mudanças várias
fix: ajustes
feat: WIP
Adiciona coisa nova.
```

## Notas por repo

- Se existir regra do projeto (ex.: `.cursor/rules/commits.mdc`), seguir essa regra; esta skill é o padrão pessoal quando não houver override.
- Em repos DRE (`use-dre`): após push em `main`, `staging` espelha via workflow — não forçar push em `staging` à mão salvo exceção.
