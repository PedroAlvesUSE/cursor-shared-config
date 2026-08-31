#!/usr/bin/env bash
# Instala configs do time no Cursor do usuário (~/.cursor)
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CURSOR_HOME="${CURSOR_HOME:-$HOME/.cursor}"

mkdir -p "$CURSOR_HOME/rules" "$CURSOR_HOME/skills"

echo "→ Rules (user) → $CURSOR_HOME/rules"
cp "$REPO_ROOT/rules/user/"*.mdc "$CURSOR_HOME/rules/"

echo "→ Rules (global .mdc) → $CURSOR_HOME/"
cp -n "$REPO_ROOT/rules/global/"*.mdc "$CURSOR_HOME/" 2>/dev/null || true

echo "→ Skills → $CURSOR_HOME/skills"
rsync -a "$REPO_ROOT/skills/" "$CURSOR_HOME/skills/"

if [ -f "$REPO_ROOT/hooks/hooks.json" ]; then
  echo "→ Hooks → $CURSOR_HOME/hooks.json"
  if [ -f "$CURSOR_HOME/hooks.json" ]; then
    echo "  (já existe hooks.json; não sobrescrevi. Compare com hooks/hooks.json)"
  else
    cp "$REPO_ROOT/hooks/hooks.json" "$CURSOR_HOME/hooks.json"
  fi
fi

if [ ! -f "$CURSOR_HOME/mcp.json" ]; then
  echo "→ MCP → $CURSOR_HOME/mcp.json (a partir do example; edite os secrets)"
  cp "$REPO_ROOT/mcp/mcp.json.example" "$CURSOR_HOME/mcp.json"
  echo "  ATENÇÃO: preencha senhas/tokens em mcp.json (não versionado)."
else
  echo "→ MCP: mcp.json já existe; use mcp/mcp.json.example como referência."
fi

echo "Pronto. Reinicie o Cursor. User Rules: cole os arquivos de user-rules/ nas Settings."
