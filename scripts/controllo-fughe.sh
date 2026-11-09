#!/usr/bin/env bash
# Blocca la pubblicazione se nei file versionati (o in una cartella indicata)
# compaiono dati che non devono uscire: IP privati, nomi interni, email, token.
# Termini personali aggiuntivi (uno per riga, regex estese) NON stanno nel repo:
#   $CONTROLLO_FUGHE_EXTRA oppure ~/.config/hazel-lab/termini-privati
# Uso: scripts/controllo-fughe.sh [cartella]   (senza argomenti: file versionati)
set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

regole=(
  'IP privato|\b(10\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])|192\.168)\.[0-9]{1,3}\.[0-9]{1,3}\b'
  'Sottodominio interno|\b([a-z0-9-]+\.)+hazel-lab\.net\b'
  'Email personale|[A-Za-z0-9._%+-]+@(gmail|googlemail|outlook|hotmail|live|icloud|yahoo)\.[a-z.]+'
  'Token GitHub|\b(ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}'
  'Token generico|\b(glpat-|xox[abp]-|AKIA)[A-Za-z0-9_-]{10,}'
  'Chiave privata|-----BEGIN [A-Z ]*PRIVATE KEY-----'
)
eccezioni='\bblog\.hazel-lab\.net\b'

extra="${CONTROLLO_FUGHE_EXTRA:-$HOME/.config/hazel-lab/termini-privati}"
if [[ -r "$extra" ]]; then
  while IFS= read -r t; do [[ -n "$t" && "$t" != \#* ]] && regole+=("Termine privato|$t"); done < "$extra"
fi

if [[ $# -gt 0 ]]; then
  mapfile -t file < <(find "$1" -type f)
else
  mapfile -t file < <(git ls-files)
fi
self="scripts/controllo-fughe.sh"
trovati=0
for f in "${file[@]}"; do
  [[ "$f" == "$self" || ! -f "$f" ]] && continue
  for r in "${regole[@]}"; do
    nome="${r%%|*}"; re="${r#*|}"
    while IFS= read -r riga; do
      n="${riga%%:*}"; testo="$(printf '%s' "${riga#*:}" | sed -E "s/$eccezioni//Ig")"
      printf '%s' "$testo" | grep -Eqi -- "$re" || continue
      # Non stampa il testo trovato: solo file, riga e tipo.
      echo "FUGA: $nome in $f:$n"; trovati=1
    done < <(grep -EnIi -- "$re" "$f" 2>/dev/null || true)
  done
done
if [[ $trovati -eq 1 ]]; then echo "Controllo fallito: correggi prima di pubblicare." >&2; exit 1; fi
echo "Controllo anti-fuga: nessun problema (${#file[@]} file, ${#regole[@]} regole)."
