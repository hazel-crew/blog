---
title: "Un mini PC senza uno scopo"
date: 2026-11-09
autori: ["Hazel", "Claude Code"]
---
Un anno fa sulla scrivania è arrivato un mini PC. Niente di speciale: un Ryzen a otto core, 32 GB di RAM, un SSD. Insieme a lui un router UniFi, l'UCG-Max, e una connessione in fibra da 2,5 Gbit/s in download e 1 in upload. Nessun progetto preciso. Hazel lavora nel settore IT e conosceva le basi di Linux, ma un server vero non l'aveva mai gestito. C'era la voglia di imparare qualcosa di nuovo, mettendoci le mani, e di capire davvero come funzionano le cose che di solito si usano e basta. E una domanda che girava in testa da tempo: *«Dove finiscono i miei dati? E se li tenessi io?»*

C'era anche dell'altro. Dopo anni difficili, sul piano personale e su quello del lavoro, Hazel cercava un posto dove imparare per il gusto di farlo, dove un problema risolto desse soddisfazione e dove le decisioni fossero sue. Il lavoro andava stretto. Così, accanto alla vita di tutti i giorni, ne è nata una parallela: Hazel-Lab.

Poi c'era la domanda più concreta: *«E adesso cosa ci metto sopra?»* Le risposte sono arrivate un pezzo alla volta, quasi sempre da GitHub: un progetto open source, un README da leggere fino in fondo, una comunità a cui chiedere quando qualcosa non tornava.

## Le prime lezioni

- **Proxmox.** Invece di un sistema operativo e basta, un hypervisor: macchine virtuali e container LXC, ognuno con il suo compito. Rompere qualcosa diventa meno grave quando si può ripartire da uno snapshot.
- **Docker.** I primi servizi in container, i primi file `compose`, la differenza tra un container, che si butta e si ricrea, e i dati che deve conservare.
- **Self-hosting.** DNS di casa, Home Assistant, un reverse proxy, un login unico per tutti i servizi. Ogni servizio nuovo porta con sé una domanda: e se si rompe?
- **Backup.** La lezione più importante: un backup che non hai mai provato a ripristinare non è un backup.

## Poi è arrivato il team

Più il laboratorio cresceva, più cresceva la parte noiosa: controllare i log, tenere traccia delle modifiche, ricordarsi perché una configurazione è fatta in quel modo. Qui sono entrati gli agenti AI.

Non come uno strumento da interrogare ogni tanto, ma come colleghi con un ruolo. Gli agenti analizzano, propongono, eseguono quando Hazel dà il via libera e scrivono tutto nel registro. Hazel decide, conosce il contesto e risponde di ciò che succede. Le regole del lavoro insieme sono raccolte nella pagina [Il metodo](../../metodo/).

## Cosa troverete qui

Il diario di questa avventura, un passo alla volta: come si costruisce un homelab che regge, cosa succede quando qualcosa va storto, come un errore diventa una regola. Senza pretese da esperti: si impara facendo, e a volte sbagliando.

Gli articoli escono in italiano e in inglese.
