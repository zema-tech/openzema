#!/bin/sh
# verify.sh — controlla l'integrità del fork openzema.
#
# Uso: ./scripts/verify.sh
#
# Non richiede dipendenze oltre a una shell POSIX e sha256sum; se python3 è
# disponibile viene usato per validare la struttura del tema zema.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

errors=0

step() {
	printf '\n==> %s\n' "$1"
}

fail() {
	printf 'ERRORE: %s\n' "$1" >&2
	errors=$((errors + 1))
}

step "1/3 File attesi"
for path in \
	README.md \
	FORK.md \
	MANIFEST.md \
	LICENSE \
	packages/ui/src/theme/themes/zema.json \
	checksums/MANIFEST.sha256
do
	if [ -f "$path" ]; then
		printf '    ok  %s\n' "$path"
	else
		fail "file mancante: $path"
	fi
done

step "2/3 Tema zema: JSON valido e palette coerente"
theme="packages/ui/src/theme/themes/zema.json"
if [ -f "$theme" ]; then
	if command -v python3 >/dev/null 2>&1; then
		if python3 - "$theme" <<'PY'
import json
import re
import sys

path = sys.argv[1]
with open(path, encoding="utf-8") as handle:
    theme = json.load(handle)

problems = []
for key in ("name", "id", "light", "dark"):
    if key not in theme:
        problems.append("chiave radice mancante: " + key)

if not re.fullmatch(r"[a-z0-9-]+", str(theme.get("id", ""))):
    problems.append("id non valido (atteso: minuscole, cifre, trattini)")

required = ("neutral", "ink", "primary", "success", "warning", "error", "info")
hex_color = re.compile(r"#(?:[0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})")

for mode in ("light", "dark"):
    variant = theme.get(mode)
    if not isinstance(variant, dict):
        problems.append(mode + " non è un oggetto")
        continue
    palette = variant.get("palette")
    if not isinstance(palette, dict):
        problems.append(mode + ".palette mancante")
        continue
    for key in required:
        value = palette.get(key)
        if not isinstance(value, str) or not hex_color.fullmatch(value):
            problems.append(mode + ".palette." + key + " non è un colore esadecimale")

for problem in problems:
    print("ERRORE: " + problem, file=sys.stderr)
sys.exit(1 if problems else 0)
PY
		then
			printf '    ok  JSON valido e palette coerente\n'
		else
			fail "validazione del tema fallita"
		fi
	else
		printf '    ATTENZIONE: python3 non disponibile, validazione JSON saltata\n'
	fi
else
	fail "tema mancante: $theme"
fi

step "3/3 Digest dei file tracciati"
if [ -f checksums/MANIFEST.sha256 ]; then
	if sha256sum -c --quiet checksums/MANIFEST.sha256; then
		printf '    ok  tutti i digest corrispondono\n'
	else
		fail "digest non corrispondenti (vedi output sopra)"
	fi
else
	fail "checksums/MANIFEST.sha256 mancante"
fi

if [ "$errors" -ne 0 ]; then
	printf '\nControlli falliti: %d\n' "$errors" >&2
	exit 1
fi

printf '\nTutti i controlli sono passati.\n'
