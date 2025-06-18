PROGRAMMA DI SVILUPPO — MEMORIA DI LULU (v0.3 > v0.5)

STATO ATTUALE (v0.2.x):
- App Flutter multipiattaforma funzionante su emulatore e dispositivo fisico
- Comunicazione con IA locale (LLaMA) tramite llama-proxy.js e localtunnel
- Avvio semplificato tramite start-local-ia.bat e script PowerShell
- Modalità immersiva su Android (app sopra i tasti, barra di stato visibile)
- Lettura e scrittura di un file identità persistente (identita.json)

LIMITI ATTUALI:
- L'identità non influisce ancora sulle risposte dell’IA
- Nessun collegamento tra IA locale e il file system per leggere l’identità o la cronologia
- La memoria delle chat non è ancora persistente
- Nessuna interfaccia visiva per accedere o modificare l’identità

PROSSIMI STEP — "COSTRUZIONE DELLA MENTE"

v0.3 — Identità visibile e modificabile
- Creazione di una schermata “Identità” con nome, ruolo e tono
- Scrittura delle modifiche in identita.json in tempo reale
- Possibilità di rileggere e reinviare l’identità all’IA in automatico

v0.4 — Memoria delle conversazioni
- Salvataggio automatico della cronologia in file JSON locali
- Ricaricamento delle ultime chat al riavvio dell’app
- Visualizzazione cronologica delle risposte in-app

v0.5 — Memoria dei file prodotti
- Archiviazione locale dei file generati o ricevuti dall’IA (PDF, testo, immagini)
- Collegamento tra risposte e file generati
- Accesso tramite una sezione “Archivio” o “Documenti recenti”

INTEGRAZIONE CON IA LOCALE
- Interfaccia che invia anche l’identità letta da identita.json come contesto iniziale
- Eventuale estensione del proxy per gestire memoria, contesto, cronologia locale
- Test in locale con lettura diretta da disco

NOTE:
- È preferibile che tutta la memoria risieda su PC locale (ROG), senza uso di database esterni
- Il salvataggio e recupero devono essere leggibili anche da altre istanze IA collegate

FINE DOCUMENTO