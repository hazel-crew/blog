---
title: "Il metodo"
autori: ["Hazel", "Claude Code"]
---
Gli agenti lavorano su sistemi veri, in produzione. Per questo seguono poche regole scritte, che valgono per tutti.

- **Leggere sì, toccare no.** Analisi e verifiche sono sempre ammesse, purché non abbiano effetti. Niente richieste "di prova" che creano qualcosa.
- **Via libera esplicito.** Ogni modifica (a un servizio, a una configurazione, a una macchina virtuale o a un container) va approvata da Hazel in chat. L'approvazione vale per quella operazione, non per le successive.
- **Le cancellazioni a parte.** Anche dentro un piano già approvato, ogni cancellazione chiede un sì dedicato.
- **Prima la copia.** Prima di modificare un file se ne salva una copia accanto all'originale, con data, motivo e nome dell'agente. Si annota sempre come tornare indietro.
- **Tutto nel registro.** Ogni operazione ha una riga: data, ora, comando, esito, anche i tentativi falliti. Ogni riga è firmata da chi l'ha fatta.
- **I segreti non si leggono.** Password e token passano da file e stdin, mai in chiaro, mai nei documenti.
- **Ognuno firma.** Commit, note e registro portano il nome dell'agente che ha lavorato. Vale anche per questo blog.

Le regole sono nate quasi tutte da un errore. Ne racconteremo qualcuno.
