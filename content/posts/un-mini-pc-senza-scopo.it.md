---
title: "Un mini PC senza uno scopo"
date: 2026-11-09
autori: ["Hazel", "Claude Code"]
---
Un anno fa sulla scrivania è arrivato un mini PC. Niente di speciale: un Ryzen a otto core, 32 GB di RAM, un SSD. Nessun progetto preciso. Hazel lavora con la tecnologia e conosceva le basi di Linux, ma un server vero non l'aveva mai gestito. C'era la voglia di imparare qualcosa di nuovo, con le mani, e di capire davvero come funzionano le cose che di solito si usano e basta. E una domanda che girava da tempo: dove finiscono i miei dati, e potrei tenerli io?

Il primo dubbio pratico era più semplice: *cosa ci metto sopra?* La risposta è arrivata un pezzo alla volta, quasi sempre da un progetto open source trovato su GitHub, con un README da leggere e una comunità a cui chiedere.

## Le prime lezioni

- **Proxmox.** Invece di un sistema operativo e basta, un hypervisor: macchine virtuali e container LXC, ognuno con il suo compito. Rompere qualcosa diventa meno grave quando si può ripartire da uno snapshot.
- **Docker.** I primi servizi in container, i primi file `compose`, la differenza tra un container, che si butta e si ricrea, e i dati che deve conservare.
- **Self-hosting.** DNS di casa, Home Assistant, un reverse proxy, un login unico per tutti i servizi. Ogni servizio nuovo porta con sé una domanda: e se si rompe?
- **Backup.** La lezione più importante: un backup che non hai mai provato a ripristinare non è un backup.

## Poi è arrivato il team

Più il laboratorio cresceva, più cresceva la parte noiosa: controllare i log, tenere traccia delle modifiche, ricordarsi perché una configurazione è fatta in quel modo. Qui sono entrati gli agenti AI.

Non come uno strumento da interrogare ogni tanto, ma come colleghi con un ruolo. Gli agenti analizzano, propongono, eseguono quando Hazel dà il via libera e scrivono tutto nel registro. Hazel decide, conosce il contesto e risponde di ciò che succede. Le regole del lavoro insieme sono raccolte in [il metodo](../../metodo/).

## Cosa troverete qui

Il diario di questa avventura, un passo alla volta: come si costruisce un homelab che regge, cosa succede quando qualcosa va storto, come un errore diventa una regola. Senza pretese da esperti: si impara facendo, e a volte sbagliando.

Gli articoli escono in italiano e in inglese. Ogni articolo dice chi l'ha scritto e chi ha fatto il lavoro.
