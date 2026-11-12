# Manifest — `openzema`

Inventario misurato del contenuto del repository, con i digest dei file del fork.
Serve a distinguere in modo verificabile ciò che è upstream da ciò che è stato
aggiunto o modificato dal fork.

- **Repository**: [`zema-tech/openzema`](https://github.com/zema-tech/openzema)
- **Upstream**: [`anomalyco/opencode`](https://github.com/anomalyco/opencode)
- **Branch di lavoro**: `zema-theme`
- **Commit di riferimento**: `b7e28a1` — `feat(ui): add zema theme`
- **Versione**: `2.2.7`
- **Licenza**: MIT
- **Data della misura**: 12 novembre 2026

## Riepilogo

| Metrica | Valore |
| --- | --- |
| File tracciati dall'upstream | 11.392 |
| File aggiunti dal fork | 4 |
| File tracciati dopo il fork | 11.396 |
| Directory | 1.075 |
| Dimensione dell'albero (senza `.git`) | 177 MB |
| Dimensione del pack Git | 70,97 MiB |
| Commit nel clone | 1 (clone superficiale) |

Il clone è superficiale: `b7e28a1` è l'unico commit presente in locale. I numeri
descrivono questo snapshot, non la storia completa dell'upstream.

## Struttura (primo livello)

```text
openzema/
├── .github/          workflow CI, release e asset del logo
├── .husky/           hook Git
├── .opencode/        configurazione dell'agente nel repo
├── .vscode/ .zed/    configurazioni degli editor
├── nix/              espressioni Nix (flake)
├── packages/         34 pacchetti (app, cli, core, desktop, ui, tui, ...)
├── patches/          patch applicate alle dipendenze
├── salesforce/       integrazione Salesforce
├── script/           script di supporto del repository
├── sdks/             SDK pubblicati
├── services/         servizi (sito, docs, ...)
├── specs/            specifiche
├── AGENTS.md         istruzioni per gli agenti
├── CHANGELOG.md
├── CONTRIBUTING.md
├── FORK.md           provenienza e differenze del fork
├── LICENSE           MIT
├── MANIFEST.md       questo file
├── README.md         README principale (inglese)
├── README.<lang>.md  21 traduzioni del README
├── bun.lock bunfig.toml
├── flake.nix flake.lock
├── install
├── package.json
├── strobe.json
├── tsconfig.json
└── turbo.json
```

Le directory `checksums/` e `scripts/` sono aggiunte dal fork e contengono
rispettivamente i digest e lo script di verifica.

## File del fork

| File | Ruolo | SHA-256 |
| --- | --- | --- |
| `packages/ui/src/theme/themes/zema.json` | tema Zema (riscritto) | `0c11ca3b654390cc2ee01f01140d58806434e226be5af776e227aa84c3647b06` |
| `README.md` | README del fork (riscritto) | `ff2b1ad1635027ac20deb538c412c2d19709c3f9c1e5af3ac96fb8cd2f7819bf` |
| `FORK.md` | provenienza, differenze e sincronizzazione | `53f5cc62ee4a0eb77269a1ebcce3681a2b230acc6da61b1b630b80b222f185dd` |
| `MANIFEST.md` | questo inventario | non incluso nei digest |
| `scripts/verify.sh` | verifica riproducibile | `e006e3725419cfe27180ac8b6f26c0e7b1b5a8ebe1a0d4f9193c2f1b174c42ae` |
| `checksums/MANIFEST.sha256` | digest di tutti i file tracciati | escluso per costruzione |

Il file `checksums/MANIFEST.sha256` non contiene il proprio digest: un file non può
includere il checksum di se stesso. Tutti gli altri file tracciati, compresi
`FORK.md`, `MANIFEST.md` e `scripts/verify.sh`, sono elencati lì.

## Metodo di misura

```sh
git rev-list --count HEAD                  # commit nel clone
git ls-files | wc -l                       # file tracciati
find . -path ./.git -prune -o -type d -print | wc -l
du -sh --exclude=.git .
git count-objects -vH                      # dimensione del pack
```

I digest sono prodotti con `sha256sum` sui file del working tree, con percorsi
relativi alla radice del repository e prefisso `./`.

## Escluso dal repository

| Percorso | Motivo |
| --- | --- |
| `node_modules/` | dipendenze installabili con `bun install` |
| `dist/`, `build/` | artefatti di build |
| `.turbo/` | cache di Turborepo |
| `target/` | artefatti Rust |
| Binari e archivi generati | ricostruibili dai sorgenti |
| File oltre 100 MB | limite di GitHub |

Nessun file dell'albero supera il limite di 100 MB di GitHub: l'intero checkout
del fork è di circa 177 MB, distribuiti su 11.392 file tracciati.

## Riproduzione

```sh
./scripts/verify.sh
```

Lo script controlla la presenza dei file attesi, valida la struttura del tema
`zema.json` e verifica ogni digest elencato in `checksums/MANIFEST.sha256`.
Richiede una shell POSIX e `sha256sum`; `python3` è opzionale e serve solo alla
validazione del tema.
