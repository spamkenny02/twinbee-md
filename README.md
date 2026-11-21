# twinbee-md — Detana!! TwinBee (PC Engine) → Mega Drive (SGDK)

Portage hobbyiste (utilisateur francophone ; échanges, commentaires de code et NOTES en **français**) de *Detana!! TwinBee* (HuCard PCE, 512 Ko, CRC32 5CF59D80) vers Mega Drive, par **réécriture du moteur en C (SGDK)**, vérifiée image par image contre des traces RAM/SAT de l'original. Le son n'est pas commencé.

Ce README est le point d'entrée pour reprendre le projet. Le détail chronologique (mesures, adresses, décisions, écarts) est dans **`NOTES.md`** (jalons 1 à 26) : le lire avant de toucher à un sous-système.

## 1. État actuel (jalon 26)

| Domaine | État |
|---|---|
| Stages 1 à 6 | Jouables : décor défilant (plan B), nuages/cloches, ennemis, tirs ennemis, ennemis au sol, bombe, mort/réapparition, vies, bras (hands) |
| Stage 1 | Complet : ennemis simulés par routines portées de la ROM (types 3–10), mi-boss (types 11/12), boss crabe (visuel + dynamique approximative) |
| Stages 2–6 | Décor + nuages + ennemis **rejoués depuis des traces** (pas simulés), tirs ennemis rejoués |
| Boss stage 2 (galion) | Rejoué (séquence fixe, ne peut pas être détruit, pas d'explosion finale) ; BAT 64×64 + scroll X/Y par frame |
| Boss stages 3, 4, 5, 6 | **Non faits** : fin de niveau provisoire à `scrollFrames + 300` |
| Cloches | Cycle de couleurs exact (jalon 25), 7 couleurs rendues |
| Bonus | Bleue (vitesse +2), noire (vitesse −2), blanche (tir double), verte/violette (options : 3 mini-abeilles suiveuses, **sans collision**), rouge (flag posé, **aucun effet**) |
| Autres bonus/objets | Non faits : tir en éventail ($08) et bouclier ($10) des objets au sol, vie supplémentaire, objet laissé par les ennemis au sol |
| Score / points des cloches colorées | Score basique (500 par cloche) ; valeurs réelles non mesurées |
| Son | Musique FM+PSG+PCM (titre, 6 stages, 3 boss, fin de stage) et 4 bruitages PCM (jalons 27-28) ; manquent perte de vie/game over, bonus, explosion joueur |
| ROM | ~1,8 Mo ; VRAM et nombre de sprites très tendus (voir §6) |

Dernière ROM : `md/twinbee/out/rom.bin` après `tools/build_all.sh` (non versionnée : `.gitignore` exclut `*.bin`, `*.pce`, `dumps/`, `emu/`, `out/`).

## 2. Principe d'architecture

- **Vérité = l'original.** Tout comportement est mesuré sur le PCE (traces RAM + SAT + palettes frame par frame via un frontal headless de l'émulateur Geargrafx) ou lu dans le désassemblage HuC6280, puis reproduit en C. Ne jamais deviner une constante : la chercher dans la ROM ou la trace.
- **Stage 1 : simulation fidèle.** Les routines d'ennemis de la banque `$0C` (types 3 à 10, 11/12 mi-boss, 13–15 sol) sont portées dans `enemy.c`. Tir joueur : routine banque `$01` `$CA34-$CD54` reproduite telle quelle.
- **Stages 2–6 : décor et ennemis « rejoués ».** Les générateurs `tools/mkstageN.py` / `mkenemiesN.py` produisent des tables (`stageN_data.h`, `stageN_enemies.h`) : instances d'ennemis (frame d'apparition, trajectoire par frame, sprites/pièces), tirs ennemis, nuages. Seuls les éléments qui dépendent du joueur (collisions, bells, tirs) sont simulés côté MD.
- **Objets PCE** : 109 emplacements, tableaux d'octets `base = $2A6D + k*$6D`, indexés par numéro d'emplacement (k=0 anim, 1/2/3 X hi/lo/frac, 4/5/6 Y, 11 type, 12 état, 9 palette-flash cloche `0x80|pal`, 19–22 tailles/demi-boîtes, 23 flags bonus joueur `$3438`, 24 compteur de coups cloche, 27 octet d'état général / **couleur de cloche `$35EC`**, 35 niveau de vitesse joueur `$3954`). Emplacements : joueur 0, options 3–8, tirs joueur 20/22, tirs ennemis 48–65, ennemis aériens 66–83, cloches ~76–89, nuages 90–95, sol 96–107. Index dans une trace RAM = adresse − `$2000` (la page zéro `$2000-$20FF` contient les globaux : `$87` vies, `$C4` compteur cloche, `$A0` bits options, `$8F`/`$70` dérivés).
- **Banques PCE** : voir `NOTES.md` (carte des banques). Code de jeu : `$0B`, `$0C`, `$15`, `$17`, utilitaires `$01`, effets palette `$14`, son `$02`. Mapping habituel : `$4000=bank 14h`, `$6000=15h`, `$8000=16h`, `$A000=17h`, `$C000=01`, `$E000=00` ; offset fichier = banque×0x2000 + (adresse & 0x1FFF).

## 3. Arborescence

- `md/twinbee/src/` : code C SGDK. `main.c` (boucle, progression `stageNo<6`, `START_STAGE`), `stage.c/.h` (défilement, nuages, cloches, score, popups, fin de niveau, boss 2), `player.c/.h` (vaisseau, tirs, charge, bras, mort, vitesse, flags bonus, options), `enemy.c/.h` + `e2types.h` (ennemis, pools de sprites, boss 1, rejeu des stages 2–6), `boss2.c/.h`, `title.c`, fichiers `*_data.h`/`*_enemies.h`/`*_pal.h` **générés** (ne pas éditer à la main).
- `md/twinbee/res/` : images et `resources.res` (**généré par `tools/mkassets.py`**, ne pas éditer).
- `tools/` : voir §4. `scripts/` : anciens scripts de test (`*.script`). `dbg.sh` : build + run d'un script MD.
- Hors dépôt (trop gros ou protégés) : `extract/` (~120 Mo de PNG/pkl/json intermédiaires), `dumps/` (~5 Go de traces PCE), `emu/` (SGDK, toolchain `gendev`, Genesis Plus GX, Geargrafx), ROM PCE `Detana_TwinBee_Japan.pce`. **Pour reprendre il faut rejouer les extractions** (voir §5) ou récupérer ces dossiers auprès de l'utilisateur.

## 4. Outils (`tools/`)

- **Banc PCE** `pcedump/main.cpp` (se compile contre Geargrafx) : `pcedump <rom.pce> <script> <dossier>`. Script, une commande par ligne `<frame> <cmd>` : `keys <hex>` (PCE : I=01, II=02, SELECT=04, RUN=08, haut=10, droite=20, bas=40, gauche=80), `poke ADRESSE=VAL` (adresse 4 hex `$2000-$3FFF`, **persistant à chaque frame**), `dump <nom>` (VRAM/SAT/palette/registres → `<nom>.vram/.sat/.pal…`, `.rgba`), `trace <nom>` / `traceoff` (RAM+SAT+clavier chaque frame → `<nom>.trace`, lisible par `pcetrace.load`), `watch ADR:N` (journal des écritures d'une adresse, avec PC/banques), `end`. Écrit aussi `codemap.txt` (code exécuté). Astuce : `poke 2087=03` fige les vies ; `poke 380D=80` invincibilité.
- `pcetrace.py` (lecture des traces), `pcegfx.py` / `pcesprites.py` (VRAM → sprites/tiles ; `pcesprites.sprite(vram,pal,pat,w,h,palette)`), `disasm6280.py` (désassembleur ; pour un désassemblage linéaire rapide voir le snippet du jalon 25 : dérive après les tables de données, donc re-synchroniser sur les cibles de branchement), `findgfx.py`.
- **Banc MD** `mdshot/` (frontal libretro de Genesis Plus GX) : `mdshot <core.so> <rom.bin> <script> <dossier>` ; commandes `<frame> keys <hex>` (MD : B=01, START=08, haut/bas/gauche/droite selon le script d'exemple ; **tap B = tir, B maintenu = charge**, le délai de tir ne décompte que les frames pressées), `shot <nom>` (PPM 256×224), `ramtrace <nom>`/`ramtraceoff` (RAM 68k 64 Ko par frame ; **octets échangés par mot : mot big-endian à l'offset `o` = `d[o+1]*256+d[o]`**, offsets = adresses du `nm rom.out`), `end`.
- **Génération** : `mkassets.py` (sprites PCE → feuilles MD, palettes PAL2/PAL3, `resources.res`), `mkstageN.py` (décor recollé + nuages), `mkenemiesN.py` (ennemis/tirs rejoués), `stitch*.py`, `prepimg.py` + `mergeidx.py` (quantification et fusion de tiles ≤ ~700), `mdpal_dyn.py` (2 lignes de palette BG « glissantes » + événements), `mkboss*.py`, `ext_*.py` (extraction depuis traces), `ext_twin.py` (sprites du tir double et de l'option), `enemy*_sim.py` (prototypes Python des routines).
- **Compilation** : `mdbuild.sh <projet>` (rescomp + m68k-elf-gcc + libmd SGDK ; chemins `/home/claude/work/emu/...` en dur) et **`build_all.sh`** (régénère assets + données de tous les stages puis compile). **Toujours utiliser `build_all.sh`** : `mkassets.py` seul réécrit `resources.res` et perd les lignes des stages 2–6.
- Tests : `mdtest_player.py`, `mdtest_stage.py` (mêmes entrées PCE/MD, comparaison), `mdcompare.py`.

## 5. Méthode de travail (à conserver)

1. Mesurer sur PCE : script `pcedump` avec entrées déterministes, `trace`, éventuellement `poke`/`watch` pour isoler une variable ; analyser avec `pcetrace` (numpy).
2. Lire le code : trouver les accès (`8D/85/9D` + adresse dans la ROM), désassembler à partir des **cibles de branchement** (la page zéro `$2000+` s'écrit en opcodes zp : `85 8F` = `STA $8F`).
3. Implémenter en C côté MD ; vérifier avec `mdshot` (captures + `ramtrace`) ; consigner dans `NOTES.md` (jalon N) ce qui est vérifié, les écarts et le non-fait ; commit/push.
4. Pour tester un cas rare sur MD, forcer l'état (ex. `DBG_BELLCNT` dans `stage.c` fixe le compteur de cloches initial ; copier le projet dans `/tmp`, changer la valeur, `mdbuild.sh`).
5. Style de réponse attendu par l'utilisateur : français, compte rendu court (vérifié / écarts / une proposition de suite), pas de digressions non confirmées ; il répond « next » pour enchaîner ; travailler en autonomie.

## 6. Contraintes techniques MD

- **80 sprites max** (SGDK `MAX_SPRITE`, précompilé) : pools déjà serrés (`MAX_SPR16` 22, `MAX_SPR10` 12, `MAX_MISSILE_SPR` 3, `MAX_EX` 6, `MAX_CLOUDS` 8, `MAX_BELLS` 5, `E2_POOL_MAX` 14 ×4 classes, `E2_MAX_PIECES` 12). Un `SPR_addSprite` qui échoue renvoie NULL → plantage (« address error ») sur `SPR_setVisibility`. Les trois options en ont consommé 3 (d'où `MAX_BELLS` 8→5).
- **VRAM** : `SPR_initEx(640)` (stage ≥2) / 696 (stage 1) ; tuiles de fond ≤ ~700–730 uniques par stage (stage 5 : 1651 tuiles fusionnées à 700, perte 1–2 %).
- **Palettes** : fond = 2 lignes (30 couleurs) glissantes par événements ; sprites : PAL2 (vaisseau, ennemis, cloches), PAL3 (nuages, tir, HUD). Le magenta n'existe pas dans PAL2 (cloche violette approchée par des bleus sombres).
- `rescomp` supprime les images vides finales d'une feuille : garder les gardes `numFrame` (`e2Draw`).
- Plan B = décor via MAP SGDK ; plan Window = HUD (2 lignes du bas) ; boss 2 : BAT fantôme `bat[4096]`, diffs toutes les 8 frames, rangées entrantes écrites dans un anneau de 32 lignes, scroll H/V par frame.

## 7. Règles du jeu déjà décodées (PCE)

- **Cloches** (`$17:$AB96` tirage, `$AFE2`+ effets) : compteur global `$C4` (0–29) +1 à chaque apparition et à chaque tir reçu ; table `$AC30` : 2,0,0,0,0, 3,0,0,0,0, 1,0,0,0,0, 4,0,0,0,0, 5,0,0,0,0, 6,0,0,0,0 (0 jaune, 1 bleue, 2 noire, 3 blanche, 4 verte, 5 rouge, 6 violette) ; palettes `$AC4E` = 0,129,133,135,131,132,134 ; la couleur reste jusqu'au tir suivant ; une couleur déjà acquise redevient jaune (blanche si flag $04 sans $08 ; verte si option 1 ; rouge si flag $82 ; violette si option 2 ou flag $80). `$C4` = 0 au début d'un stage. Un tir pendant le délai d'invulnérabilité de la cloche (~10 frames) ne compte pas.
- **Effets** (`$3438` : `$01` opt1, `$02` opt2, `$04` tir double, `$08` éventail, `$10` bouclier, `$80` rouge) : bleue = `$3954 += 2` (max `$12`) ; noire = `−2` (min 0) ; vitesse = `0x80 + niveau*0x40` (8.8, table `$C91D`, niveau initial 4 = 0x180) ; blanche = `$3438 = ($3438 & ~$08) | $04` ; verte = option 1 (3 objets, slots 3–5) ; violette = option 2 (slots 6–8) ; rouge = `$80`, minuteur `$34AE`=10, crée l'objet slot 9 (boîte 30×30 d'après `$3367`/`$33D4`) — **comportement non étudié**. À la mort `$3954`→4 et `$3438`→0.
- **Tir double** : même objet que le tir simple, anim 28 au lieu de 14, demi-boîte 12×12 au lieu de 8×16, sprite motif 495.
- **Options** : 3 mini-abeilles (motif 481, pal 0) aux positions du joueur retardées de 7, 15 et 23 frames (historique de 24 positions, banque 1 `$D052-$D0C6`) ; sprite = (x−8, y−12). Sans tir, collision 7×7 non observée.
- **Objets au sol** (`$17:$2EE4C`, dispatch sur `$3468,Y`) : 1 = routine `$EE77` (nettoyage d'ennemis, à étudier), 2 = flag `$08` (éventail), 3 = bit `$A0` `$10` (bouclier), 4 = vie +1 (`$87` BCD) — non portés. L'éventail a été vu sur PCE (poke `3438=08`), le flag `$10` donne un croissant vert devant le vaisseau.
- Autres règles (tir/charge, bras, contacts, vagues, types d'ennemis, boss 1/2) : `NOTES.md`.

## 8. À faire (ordre suggéré)

1. **Cloche rouge** (flag `$80` + objet slot 9, 30×30) et **objets au sol** (éventail `$08`, bouclier `$10`, vie `$87`) : expérience PCE par `poke` (ex. `3438=80` + création manuelle de l'objet slot 9 : `2C97=py`, `2B50=px`, `2F25=01`, `3367=1E`, `33D4=1E`, `34AE=0A`) puis trace de l'objet.
2. Collision/rôle des options (bloquent-elles les tirs ennemis ? tuent-elles ?), décalage ±4 px de la cloche à chaque tir (anim `$21` → +4, `$22/$23` → −4, bornes 8..E8), points réels des cloches (jaunes enchaînées et colorées), boîte du tir double contre nuages/cloches.
3. Boss des stages 3 (soleil jaune, ~63226→72259), 4 (violet, ~90633→), 5, 6 (rejeu par trace comme le boss 2) ; HP/destruction réelles des boss.
4. Score complet / HUD, continues, écran de fin, progression complète depuis le titre (`START_STAGE` est à 1).
5. Tirs ennemis des ennemis au sol, objet laissé par les ennemis au sol (type 29), explosions au sol.
6. Son : jingles manquants (ids 0x11 perte de vie, 0x47/0x9D/0xA3 non identifiés), effets restants (voir NOTES j27-j28), mixage fin.
7. Optimisation : taille ROM (1,8 Mo, limite SGDK/cart 4 Mo), VRAM, limite de 80 sprites.

## 9. Pièges connus

- `mkassets.py` seul casse `resources.res` ; passer par `build_all.sh`.
- Écart `s8` (`pdx` −240/−206) dans `stage2/6_enemies.h` : pièces hors écran, ignoré.
- Poke de cloche sur PCE inopérant (objet recalculé) : observer par traces plutôt que forcer.
- Frames : les numéros de frame PCE (traces) et MD (`stage.frame`) sont décalés ; ex. stage 1 MD : `stage.frame = frame MD − 357` quand START à 300.
- Ne pas committer la ROM d'origine ni les ressources dérivées si le dépôt devient public.

## 10. Git

Dépôt `spamkenny02/twinbee-md`, branche `main`. Le travail se fait dans `/home/claude/work` ; synchroniser vers le clone (`/home/claude/twinbee-md`) : `NOTES.md`, `tools/*.py|*.sh`, `md/twinbee/src/*.[ch]`, `md/twinbee/res/*` ; push : `git -c push.negotiate=true push origin HEAD`. Un commit par jalon (`jN: …`), ROM livrée à part à l'utilisateur.
