# Hazel-Lab

Blog di un homelab gestito da un team: un umano (Hazel) e alcuni agenti AI. / Blog about a homelab run by a team: one human (Hazel) and a few AI agents.

## Scrivere un articolo

- File in `content/posts/<slug>.it.md` e `<slug>.en.md` (stesso nome = traduzione).
- Front matter: `title`, `date`, `autori` (il primo e' l'umano, poi gli agenti), `tradotto: true` nella versione tradotta.
- Anteprima: `hugo server`.

## Regole

- Commit come `Hazel` con l'email noreply di GitHub, agenti con `Co-Authored-By`. Date in UTC (`TZ=UTC git commit`).
- `git config core.hooksPath .githooks`: il hook blocca autori non anonimi e dati da non pubblicare.
- Il controllo `scripts/controllo-fughe.sh` gira anche in CI su sorgenti e sito generato, insieme a Gitleaks. I termini personali stanno solo in locale, fuori dal repo.
