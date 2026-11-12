# FORK — `openzema`

Questo repository è un fork di [`anomalyco/opencode`](https://github.com/anomalyco/opencode).
Non è affiliato, sponsorizzato o approvato dal progetto upstream.

## Provenienza

| Campo | Valore |
| --- | --- |
| Upstream | `anomalyco/opencode` |
| Fork | `zema-tech/openzema` |
| Branch di lavoro | `zema-theme` |
| Branch base (upstream) | `dev` |
| Versione | `2.2.7` (`package.json`) |
| Package manager | `bun@1.4.4` |
| Licenza | MIT — vedi [`LICENSE`](./LICENSE) |
| Commit del fork | `b7e28a1` — `feat(ui): add zema theme` |
| Manutenzione | `zema-tech` |

Il fork è un clone shallow con storia ridotta: la storia upstream completa non è
presente in questo repository. Il commit `b7e28a1` è l'unico commit locale.

## Differenze rispetto all'upstream

Le differenze rispetto all'upstream sono intenzionalmente minime: identità visiva
e documentazione. Il runtime, le API e il comportamento dell'applicazione non
sono stati modificati.

| File | Stato | SHA-256 |
| --- | --- | --- |
| `packages/ui/src/theme/themes/zema.json` | riscritto | `0c11ca3b654390cc2ee01f01140d58806434e226be5af776e227aa84c3647b06` |
| `README.md` | riscritto (banner fork, provenienza, lingue) | `cda65c7f1a0212de54c75ae4e9d3b1284468ce1bc76b9e02cbcc8e018172e05a` |
| `FORK.md` | aggiunto | — |
| `MANIFEST.md` | aggiunto | — |
| `scripts/verify.sh` | aggiunto | — |
| `checksums/MANIFEST.sha256` | aggiunto | — |

### Tema `zema`

`packages/ui/src/theme/themes/zema.json` (91 righe) definisce una palette
Claude/coral per entrambi i modi, light e dark, con override tipografici per
`text-weak`, `syntax-*` e `markdown-*`:

- light: `neutral #faf9f5`, `ink #141413`, `primary #d97757`, `accent #bd5d3a`
- dark: `neutral #0a0a0a`, `ink #e8e6e3`, `primary #d97757`, `accent #e2957a`

Il tema è registrato in `packages/ui/src/theme/context.tsx` e usa solo la palette
seed: non contiene un blocco `v2Overrides`, che resta opzionale e viene risolto a
runtime da `packages/ui/src/theme/v2/resolve.ts`.

Nessun altro tema, pacchetto o file di codice è stato modificato.

## Licenza e diritti

Il codice upstream è distribuito con licenza MIT. Il file [`LICENSE`](./LICENSE)
è conservato invariato e continua a valere per tutto il codice derivato.

Il repository non include un file `NOTICE`. Eventuali marchi, nomi e loghi
citati appartengono ai rispettivi titolari; il nome "OpenCode" e i loghi
upstream sono usati solo per descrivere la provenienza del fork.

## Sincronizzazione con l'upstream

Il branch di lavoro del fork è `zema-theme`, creato da `dev`. Il branch `dev`
del fork è il mirror del branch `dev` upstream e va usato come sorgente di
riallineamento: `upstream/dev` viene mergiato in `zema-theme`, non il
contrario.

```sh
git remote add upstream https://github.com/anomalyco/opencode.git
git fetch upstream dev
git switch zema-theme
git merge upstream/dev
```

Le modifiche fork-specific sono confinate ai file elencati sopra, quindi i
conflitti attesi riguardano `README.md` e, in caso di modifiche upstream al tema
omonimo, `packages/ui/src/theme/themes/zema.json`.

## Verifica

L'integrità dei file tracciati e dei file fork-specific è verificabile con:

```sh
./scripts/verify.sh
```

Lo script controlla la presenza dei file attesi, valida il JSON del tema e
verifica i digest in [`checksums/MANIFEST.sha256`](./checksums/MANIFEST.sha256).

## Struttura fork-specific

```text
openzema/
├── FORK.md                     # questo file
├── MANIFEST.md                 # inventario misurato del repository
├── README.md                   # README del fork
├── checksums/
│   └── MANIFEST.sha256         # digest SHA-256 di tutti i file versionati
├── scripts/
│   └── verify.sh               # verifica riproducibile
└── packages/ui/src/theme/themes/
    └── zema.json               # tema del fork
```

## Escluso dal repository

Il repository versiona solo il sorgente. Non sono tracciati, e non devono esserlo:

- `node_modules/` e le directory di build (`dist/`, `.turbo/`, `target/`);
- artefatti binari o archivi di release;
- file oltre il limite GitHub di 100 MB per file.

Gli artefatti di build si rigenerano dai sorgenti con i comandi descritti in
[`README.md`](./README.md#build-from-source).
