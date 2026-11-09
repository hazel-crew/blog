---
title: "Due Pi-hole, un Unbound e un indirizzo che spariva"
date: 2026-11-09T15:00:00+01:00
autori: ["Hazel", "Claude Code"]
---
Il primo servizio vero di Hazel-Lab è stato il DNS. Non per caso: se la domanda era *«Dove finiscono i miei dati?»*, il DNS è il primo posto dove guardare. Ogni sito aperto, ogni app che si collega, ogni dispositivo che "chiama casa" passa prima da lì. Chi risponde alle richieste DNS sa molto di quello che succede in una rete.

La ricetta, quella che consigliano tanti self-hoster, sembrava semplice: [**Pi-hole**](https://github.com/pi-hole/pi-hole) per bloccare pubblicità e tracciamenti, [**Unbound**](https://github.com/NLnetLabs/unbound) come resolver ricorsivo, così da non affidare le richieste a Google o a Cloudflare.

Sembrava semplice. È diventata la storia dei primi tre errori di Hazel, e di cosa ci hanno insegnato.

## Errore n. 1: una macchina virtuale per ogni cosa

Hazel aveva capito presto una cosa: se il DNS si ferma, per chi è in casa "internet non va". Quindi i Pi-hole sono stati due fin dall'inizio.

Con due DNS, però, arriva subito un problema nuovo: devono dire la stessa cosa. Una blocklist aggiunta su uno solo, un'eccezione dimenticata, un nome locale mancante, e i dispositivi ricevono risposte diverse a seconda di quale server interrogano. Per questo è entrato in gioco [**nebula-sync**](https://github.com/lovelaze/nebula-sync), che copia la configurazione da un Pi-hole all'altro.

La prima versione del DNS di casa era quindi questa: **due macchine virtuali** per i Pi-hole, **una terza macchina virtuale** solo per nebula-sync, e un container LXC per Unbound.

L'intuizione era giusta, la forma no. Ed ecco il primo errore: una VM intera per un servizio così leggero vuol dire un sistema operativo completo da aggiornare, RAM e disco riservati, avvii lenti. Una VM intera per un programma che ogni tanto copia qualche impostazione da un server all'altro, poi, è quasi un monumento allo spreco.

Ci sarebbe voluto un po' per capirlo. Come ne siamo usciti lo raccontiamo nel prossimo articolo.

## Un indirizzo che non cambia mai

Restava la questione dell'indirizzo. I client devono sapere a chi chiedere, e se il server indicato si spegne, non sempre passano al secondo in fretta. La soluzione è stata [**keepalived**](https://github.com/acassen/keepalived): un indirizzo IP virtuale condiviso, che normalmente risponde dal primo Pi-hole e, se questo cade, si sposta sul secondo. Per la rete di casa il DNS era uno solo, e sempre acceso.

*«Due server, sincronizzati, con un indirizzo che non cambia mai. Questa volta è fatto bene.»*

## Errore n. 2: un solo Unbound dietro due Pi-hole

Unbound invece era uno solo, in un suo container LXC dedicato. Entrambi i Pi-hole gli inoltravano le richieste. Hazel aveva reso doppio il pezzo davanti e lasciato singolo quello dietro, senza accorgersene: è stato l'errore più importante.

Il problema si è presentato in un modo strano: il container di Unbound, ogni tanto, **perdeva l'indirizzo IP**. Non importava che fosse assegnato in modo statico da Proxmox o riservato sul router: a un certo punto l'indirizzo spariva e Unbound non era più raggiungibile.

Cercando a posteriori, non siamo i soli. Sui forum di Proxmox e di LXC ci sono diverse segnalazioni di container Debian che perdono l'indirizzo dopo qualche ora, o che all'avvio non lo ricevono proprio. Con Unbound c'è un ingrediente in più: il pacchetto di Debian installa un servizio di supporto, `unbound-resolvconf`, che interviene sulla configurazione DNS del sistema e dentro un container non sempre va d'accordo con il modo in cui viene gestita la rete. Nei casi documentati la soluzione è disattivare quel servizio, oppure gestire la rete del container con `ifupdown` al posto di `systemd-networkd`. Se fosse esattamente il nostro caso non lo sapremo mai: quel container non esiste più.

Qualunque fosse la causa, il risultato era chiarissimo. I due Pi-hole erano accesi, sincronizzati, raggiungibili all'indirizzo virtuale, e non riuscivano a risolvere niente. In casa, per tutti, internet semplicemente non andava. Tutta la ridondanza costruita a monte dipendeva da un unico container a valle. Il sistema sembrava doppio, ma aveva un singolo punto di guasto proprio nel mezzo.

La lezione vale ben oltre il DNS: **la ridondanza conta solo se copre tutta la catena.** Due copie di un pezzo non servono se il pezzo successivo è uno solo.

## Errore n. 3: cinque pezzi per fare una cosa sola

Due Pi-hole, nebula-sync, keepalived, Unbound: per far funzionare il DNS di casa servivano cinque componenti, ognuno con la sua configurazione, i suoi aggiornamenti e i suoi modi di rompersi. Ogni problema era stato risolto aggiungendo un pezzo, e ogni pezzo aggiunto era un punto in più dove qualcosa poteva andare storto. Il terzo errore è stato questo: inseguire i problemi uno alla volta, senza fermarsi a guardare l'insieme.

## La verità che non ci piace dire ad alta voce

C'è un dettaglio che fin qui abbiamo glissato con eleganza. Due Pi-hole, un programma che li tiene sincronizzati, un indirizzo virtuale che salta dall'uno all'altro: tutta questa ridondanza gira sullo **stesso mini PC**. Lo stesso alimentatore, lo stesso disco di sistema, la stessa presa di corrente dietro la scrivania.

Abbiamo costruito un DNS a prova di guasto di un container. Il guasto dell'host, invece, lo gestisce con grande coerenza: si spegne tutto insieme, in perfetta sincronia. Un aggiornamento del kernel con riavvio, un blackout di dieci secondi, un piede che inciampa nel cavo, e la ridondanza diventa un concetto filosofico.

*«Quindi ho due DNS per quando se ne rompe uno… ma non per quando si rompe la casa in cui abitano.»*

Ha comunque senso? Sì, ma per il motivo giusto. Due server sullo stesso host proteggono da un container che si blocca, da un aggiornamento andato male, da un errore di configurazione su uno dei due: tutte cose che in un homelab capitano molto più spesso di un mini PC che muore. Per proteggere anche dal resto servono un secondo nodo e un gruppo di continuità. Sono nella lista dei desideri, insieme a un NAS. Ne riparleremo.

## Cosa ci portiamo dietro

- **Il DNS è infrastruttura critica.** In casa si nota più di qualunque altro servizio, perché quando si ferma sembra che si fermi tutto. E la compagna di Hazel ne sa qualcosa.
- **VM o container?** Per un servizio leggero, un container LXC è quasi sempre la scelta giusta.
- **Ridondanza vuol dire sincronizzazione.** Due server che dicono cose diverse sono un problema nuovo, non una soluzione.
- **Cercare l'anello debole.** Prima di dire "è ridondante", seguire una richiesta dall'inizio alla fine e chiedersi: se si spegne questo pezzo, cosa succede?
- **Sapere da cosa si è protetti.** Due copie sullo stesso host proteggono dai guasti del software, non da quelli dell'hardware. Va benissimo, basta non raccontarsela.
- **Meno pezzi, meno guasti.** A volte la soluzione migliore non è aggiungere un componente, ma toglierne quattro.

*«Cinque pezzi per fare una cosa sola. Ci doveva essere un modo più semplice.»*

C'era. Ma per trovarlo Hazel ha dovuto prima imparare un paio di cose sui container. È la storia del prossimo articolo.
