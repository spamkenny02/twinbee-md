# Portage Detana!! TwinBee (PC Engine) → Mega Drive / SGDK — Jalon 1

ROM : HuCard 512 Ko, 64 banques de 8 Ko, CRC32 5CF59D80.
Vecteurs : RESET $E000, IRQ1/VDC $E0F1, TIMER $E424.

## Contenu de l'archive
- `tools/pcedump/main.cpp` : frontal headless pour l'émulateur Geargrafx (entrées scriptées, dump VRAM / SAT / palette / registres VDC / RAM, carte du code exécuté). Se compile contre les sources Geargrafx (GPLv3, non incluses).
- `tools/pcegfx.py` : dump → PNG (palettes, planche de tiles, BAT complet, sprites à l'écran, info.json).
- `tools/disasm6280.py` : désassembleur HuC6280 guidé par le code exécuté + suivi de flux statique.
- `tools/findgfx.py` : recherche des tiles VRAM tels quels dans la ROM.
- `disasm/` : listings par banque + `summary.txt`.
- `extract/` : graphismes extraits (écran titre, stage 1 à 4 instants).
- `dumps/*_sheet.png` : planches de captures (boot/attract, partie stage 1).

## Carte des banques (état actuel)
| Banque | Vue en | Rôle (déduit) | Fiabilité |
|---|---|---|---|
| 00 | $E000 | Noyau : reset, IRQ, VDC, manettes, changement de banques | sûr |
| 01 | $C000 | Routines d'affichage (accès VDC intensifs) | probable |
| 02 | $4000 | Pilote sonore (seule banque avec le noyau à écrire sur le PSG) | probable |
| 0B | $4000 | Logique de jeu (aucun accès matériel) | probable |
| 0C | $6000 | Logique de jeu, appelle 0B | probable |
| 14 | $C000 | Effets de palette (écritures VCE) | probable |
| 15 | $C000 | Logique de jeu | probable |
| 17 | $A000 | Logique de jeu | probable |
| 0D-0F | ? | Densité de JSR/RTS typique de code, jamais exécuté dans mes sessions (autres niveaux ?) | hypothèse |
| 18-1A, 35-36 | – | Données graphiques de l'écran titre (quelques tiles non compressés) | indice |
| 22-25 | – | Données graphiques du stage 1 | indice |
| 37, 3F | – | Vides ($FF) | sûr |
| reste | – | Données non identifiées (graphismes compressés, niveaux, musiques) | à faire |

Code tracé : 26 007 octets, dont 17 044 réellement exécutés (boot + attract + ~2 min de stage 1).

## Constats importants pour le portage
- **Graphismes compressés** : seuls 3-4 % des tiles en VRAM se retrouvent tels quels en ROM. Soit on documente le décompresseur, soit on extrait tout par dump VRAM en émulation (ce que fait déjà l'outillage).
- **Affichage** : image 256 px de large ; BAT virtuel 64×64 tiles (512×512), le HUD est stocké à droite du terrain dans le même BAT (split raster à prévoir → plan Window ou second plan sur MD).
- **Couleurs, stage 1** : 8-9 palettes de fond (38-41 couleurs uniques) et 4-6 palettes de sprites (34-48 couleurs uniques) simultanées ; 60 couleurs distinctes max mesurées à l'écran. La MD offre 4×15+1 = 61 couleurs : jouable, mais il faudra regrouper les palettes tile par tile.
- Les couleurs PCE (9 bits) se convertissent sans perte vers la MD (9 bits).
- **Sprites** : 16×16 à 32×32 observés ; la table en contient 64, comme la limite PCE (80 sur MD).

## Limites connues
- 3 sauts indirects et 32 appels inter-banques non résolus (voir `summary.txt`) : code encore non désassemblé derrière.
- Seuls le titre et une partie du stage 1 ont été joués ; les autres niveaux ne sont pas encore couverts.
- Les étiquettes des vecteurs TIMER/IRQ ne sont pas encore nommées dans les listings.

# Jalon 2 — décor du stage 1, défilement et HUD sur Mega Drive

## Résultat
- `md/twinbee/out/rom.bin` : ROM Mega Drive (128 Ko) compilée avec SGDK. Mode H32 (256×224), décor sur le plan B via le moteur MAP de SGDK, HUD sur le plan fenêtre (2 lignes du bas).
- Commandes de test : **C** avance rapide, **A** pause du défilement, **START** retour au début.
- Vitesse : 1/3 px par frame, mesurée sur l'original (358 px en 1080 frames).

## Chaîne de fabrication
1. `tools/pcedump` joue le stage 1 en entier (vies figées par `poke 2087=03`, l'adresse du compteur de vies) et dumpe la mémoire vidéo toutes les 24 frames.
2. `tools/stitch.py` recolle le fond sans sprites → `extract/stage1.png` (256×6208).
3. `tools/mdpal_dyn.py` répartit les tiles sur 2 palettes Mega Drive « glissantes » et produit la carte indexée + la table d'événements de palette (`src/stage1_pal.h`).
4. `tools/mdbuild.sh` compile (rescomp + m68k-elf-gcc + libmd précompilée de SGDK).
5. `tools/mdshot` (frontal libretro pour Genesis Plus GX) capture la ROM, `tools/mdcompare.py` compare au décor PCE.

## Chiffres
- Stage 1 : 53 couleurs de fond au total, 9 max par tile, 762 tiles 8×8 uniques (683 dans le tileset MD après dédoublonnage avec miroirs).
- Palettes fixes : impossible sans perte (5 % de pixels modifiés avec 3 palettes).
- Palettes glissantes : 2 palettes suffisent, 76 changements de couleur sur tout le niveau, 29 pixels modifiés sur 1 589 248 (4 tiles, sur le boss). Les palettes 2 et 3 restent libres pour les sprites (le HUD occupe 7 couleurs de la palette 3).

## Vérification (émulateur Genesis Plus GX)
- 38 captures réparties sur tout le niveau : 0 pixel de différence avec le décor PCE, sauf l'écran final (les 29 pixels ci-dessus).
- HUD : 0 pixel de différence avec la capture PCE.
- START, C et A testés.

## Écarts connus avec l'original
- Le HUD est une image fixe (score, vies, jauge non animés).
- L'original n'affiche que 240 px de large (8 px noirs de chaque côté) et 209 lignes de terrain ; la ROM MD montre les 256 px et 208 lignes.
- L'original démarre par un défilement rapide (2 px/frame) au-dessus de la forêt ; ici la vitesse est constante. La longueur de cette forêt, très répétitive, est la partie la moins sûre du recollage.
- Le boss (crabe) fait partie du décor dans l'original ; il apparaît donc figé en haut de la carte.
- Les couleurs sont écrites pendant l'affichage (`PAL_setColor`) : à déplacer dans le VBlank pour éviter des points parasites sur vraie console.
- Compilé ici avec m68k-elf-gcc 9.3 (paquet gendev) contre la libmd précompilée de SGDK ; non testé avec la chaîne Windows officielle ni sur console.

# Jalon 3 — TwinBee jouable (déplacements, tir, tir chargé)

## Résultat
- `md/twinbee/out/rom.bin` : décor + HUD du jalon 2, plus le vaisseau contrôlable.
- Manette : croix = déplacement, **B** = tir (tenir pour charger, relâcher pour le tir chargé), **C** = avance rapide du décor (debug), **START** = retour au début du décor.
- Code : `src/player.c` / `src/player.h` (toutes les constantes mesurées sont dans `player.h`).

## Ce qui a été mesuré sur l'original (traces RAM + table de sprites, frame par frame)
| Élément | Valeur | Source |
|---|---|---|
| Position joueur | RAM `$20BB` (X), `$20BD` (Y) | trace |
| Vitesse | 1,5 px/frame par axe (virgule fixe, alternance 1/2 px) | trace |
| Limites | X 16..225, Y 24..198 (zone de 240 px ; +8 px à l'écran MD) | trace |
| Départ 1P | (64, 159) | trace |
| Vaisseau | 3 sprites 16×16 : corps + 2 bras ; pose inclinée à gauche/droite | table de sprites |
| Tir normal | à l'appui, apparaît 2 frames après en (x-8, y-14), 6 px/frame, un seul à l'écran | trace |
| Compteur de charge | RAM `$20A6`, +1 par frame bouton tenu, plafonné à 40 | trace |
| Halo de charge | visible à partir de 14, en (x-8, y-24) | trace |
| Tir chargé niveau 1 | relâchement avec compteur 12..39 ; 2 sprites 16×32 en y-6 | trace |
| Tir chargé niveau 2 | compteur à 40 ; 3 colonnes 16×64 en y-38 + traîne 16×32 | trace |
| Invincibilité | RAM `$380D` (minuteur), utilisé pour les mesures | trace |

## Vérification
`tools/mdtest_player.py` rejoue sur la ROM MD les mêmes entrées que trois traces PCE et compare la RAM des deux machines :
- position du joueur : 5 503 frames comparées, 0 différente (la MD réagit une frame plus tôt que la PCE) ;
- compteur de charge : 0 frame différente ;
- tirs chargés niveaux 1 et 2 : 798 frames où le tir est présent des deux côtés, toutes à la même position ;
- tir normal : mêmes positions tant que le tir PCE existe (545 frames sur 615). Les écarts viennent des collisions : sur PCE le tir disparaît en touchant un nuage ou une cloche, ce qui libère le tir suivant plus tôt ; la ROM MD n'a encore ni cibles ni collisions.
- Contrôle visuel du vaisseau (pose neutre et inclinée) : `md/shots/zoom3.png`.

## Palettes
- PAL0-1 : décor (glissantes). PAL2 : vaisseau + tir normal (14 couleurs). PAL3 : HUD + flammes des tirs chargés (12 couleurs).
- Les palettes de sprites PCE 0 à 6 sont constantes pendant le stage 1.

## Non fait / incertain
- Bombe (bouton I de la PCE), cloches, nuages, ennemis, collisions, mort, 2e joueur.
- Jauge de charge du HUD (toujours image fixe).
- Seuil exact du tir chargé niveau 1 : entre 9 et 12 frames (8 ne donne rien, 12 oui) ; réglé à 12.
- Animation du halo et clignotement des flammes : cadence approchée, non comparée frame par frame.
- Coexistence tir normal / tir chargé et nombre max de tirs avec les power-ups : non testés.
- Les changements de palette du décor sont maintenant écrits juste après le VBlank.

# Jalon 4 — nuages, cloches, score, jauge de charge

## Résultat
- `md/twinbee/out/rom.bin` : stage 1 avec le défilement exact de l'original, nuages, cloches, ramassage (500 points, pastille « 500 »), score et jauge de charge dans le HUD.
- Manette : croix, **B** tir/charge, **C** jeu accéléré ×4 (debug), **START** recommencer le stage.
- Code : `src/stage.c` / `stage.h` (défilement, nuages, cloches, HUD), `src/stage1_data.h` (tables générées), `tools/mkassets.py` (génère sprites, tuiles HUD et tables).

## Mesures faites sur l'original
| Élément | Valeur | Fiabilité |
|---|---|---|
| Défilement | RAM `$20B5` ; 2 px/frame pendant ~585 frames, puis 85/256 px/frame, accélération avant le boss (4 px/frame sur 48 frames), arrêt après 5982 px. Stocké frame par frame. | exact |
| Nuages | 29 dans le stage, apparition à y=-48, x fixe, 0,5 ou 0,75 px/frame, indépendants du joueur (2 parties comparées) | exact |
| Cloche libérée | tir dans un nuage → cloche en (nuage.x+8, nuage.y+6), une par nuage, le tir continue | vérifié |
| Trajectoire cloche | vitesse -488/256, gravité 12/256 par frame, chute max 3 px/frame, sort à y≥216 | 1 px d'écart ponctuel |
| Tir sur cloche | relance à -500/256, le tir est consommé (impact 2 frames) ; tests de collision une frame sur deux | vérifié sur 5 rebonds |
| Zone de touche | losange `|dx| + dy <= 24` | déduit de 6 cas |
| Ramassage | cloche à moins de 13 px du centre du joueur → 500 points | 17 parties (seuil entre 12 et 14) |
| Cadence de tir | appui refusé 8 frames après le tir précédent, accepté à 12 | partiel |
| Jauge | largeur remplie = charge arrondie au pair, blanche à 40 | exact |
| Retard des commandes | 1 frame (la ROM le reproduit maintenant) | exact |

## Vérification (`tools/mdtest_stage.py`, mêmes entrées sur PCE et MD)
- Partie sans entrée, 15 407 frames : nuages identiques sur toutes les frames, défilement identique (la variable RAM PCE est en avance d'une frame sur l'affichage MD).
- Joueur : 0 frame différente sur les 4 parties rejouées (10 374 frames).
- Scénario « ramassage » (217 frames) : cloches identiques sauf 3 frames à 1 px, score 500 des deux côtés.
- Scénario « tirs répétés » : cloches identiques (à 1 px près sur 18 frames) pendant 313 frames et 5 rebonds, puis divergence à la frame 3713 : la ROM accepte un appui d'une seule frame que l'original ignore.
- Partie longue avec ennemis côté PCE : nuages et joueur identiques, cloches non comparables (les ennemis absorbent des tirs).
- Comparaison visuelle : `md/shots/compare4.png`.

## Non fait / incertain
- Règle exacte d'acceptation d'un tir (appuis très brefs, cadence entre 9 et 12 frames).
- Changement de couleur des cloches au 5e tir (observé : palette 7 et décalage de 4 px), cloches déjà colorées à la sortie de certains nuages, effets des bonus. Les cloches restent jaunes.
- Série de scores (seul le 500 est vérifié), durée exacte de la pastille (réglée à 28 frames).
- Tirs chargés contre nuages et cloches : aucune collision pour l'instant.
- Cloche au-dessus de l'écran (y<0) : considérée intouchable (observé à y=-12 seulement).
- Ennemis, bombe, mort, boss, son.
- Palettes : PAL2 14 couleurs (vaisseau, cloches, flammes), PAL3 14 couleurs (HUD, nuages, tir). Il reste 2 emplacements libres.

# Jalon 5 — routine de tir d'origine, première vague d'ennemis

## Méthode
Nouveau mode `watch` dans `tools/pcedump` : exécution pas à pas qui note quelle instruction écrit une adresse RAM, avec la pile. Il a servi à localiser les routines dans le désassemblage, lues ensuite directement.

## Routine de tir (banque $01, $CA34-$CD54) — maintenant reproduite telle quelle
- Deux emplacements de tir normal (A puis B) : deux tirs à l'écran au maximum.
- Délai de 4 posé à chaque tir (`$37A0`), qui ne décompte que les frames où le bouton est tenu ou vient d'être pressé. C'est ce qui expliquait les appuis « ignorés ».
- Charge (`$A6`) : +1 par frame tenue, plafond $28 ; relâchement à partir de $0C = niveau 1, à $28 = niveau 2 ; pas de charge tant qu'un tir chargé est à l'écran. Le seuil du halo est $0C aussi (j'avais 14).
- Halo : image choisie par (compteur global >> 3) & 3, la phase 0 n'affiche rien.
- Le tir part de la position du joueur au moment de l'appui.
- Collisions tir/nuage et tir/cloche : chaque cible est testée une frame sur deux selon la parité de son numéro d'objet (nuages = objets 90+, cloches = 89 en descendant) ; à sa frame d'apparition, un tir teste tous les nuages.
- Non repris : la variante de tir chargé « type 3 » et les tirs latéraux (bonus).

## Structure des objets de l'original (utile pour la suite)
Tableaux parallèles de $6D objets : X `$2B47` (+ haut `$2ADA`, fraction `$2BB4`), Y `$2C8E` (+ `$2C21`, `$2CFB`), vitesse X `$3063`/`$30D0`, vitesse Y `$313D`/`$31AA`, accélérations `$3217`/`$3284`, état `$2F89`, image `$2A6D`, demi-tailles de collision `$3369`/`$33D6`. Joueur = objet 0, tirs = 20 et 22, ennemis de la vague 1 = 66 à 71. Les sprites sont affichés 2 frames après le calcul (position - 8). Helpers en banque $0B : `$4111` (vitesse depuis angle et vitesse, table de sinus `$FEB8`), `$4E21`/`$4E4B` (déplacement), `$414C` (animation). Le script d'apparition des ennemis est indexé par le défilement (`$42B3`, pointeur `$97`).

## Vague 1 (routine banque $0C, $6181 et $61DB)
- 6 ennemis, un toutes les 17 frames à partir de la frame de jeu 936, depuis (-8, 0), angle 3, vitesse $12.
- Ligne droite jusqu'à `|joueur.x - ennemi.x| < 32`, puis virage : +1 cran d'angle (11,25°) toutes les 12 frames à la vitesse $20, plus le défilement du sol.
- Destruction : 100 points, explosion de 31 frames ; +1000 quand la vague entière est détruite (observé une seule fois).
- Tirs chargés : traversent et détruisent (boîtes de la table `$CAEA`).

## Vérification
- Modèle Python (`tools/enemy_sim.py`) contre la RAM PCE : 3 367 positions sur 3 parties, 0 différente.
- ROM contre RAM PCE (`tools/mdtest_stage.py`) : partie immobile 241 frames, partie en mouvement 305 frames : 0 différente.
- Joueur et nuages : toujours 0 frame différente sur toutes les parties.
- Cloches : scénario ramassage identique (3 frames à 1 px) ; tirs répétés identique jusqu'à la frame 3717 ; partie longue identique jusqu'à la frame 3388 (avant le jalon : 3222).
- Capture `md/shots/compare5.png` : à entrées identiques (frame 3964), tir chargé, explosions et score 600 des deux côtés.

## Écarts restants connus
- Cloches : sur PCE la cloche se décale de 4 px vers la gauche et change de palette au 5e tir, puis revient ; non reproduit, et c'est la cause de la divergence à 3717. Cause de la divergence à 3388 non identifiée (la ROM libère une cloche que l'original ne libère pas).
- Les destructions d'ennemis ne sont donc pas comparables sur les parties où les cloches ont déjà divergé. Boîte de collision tir/ennemi déduite des tables de demi-tailles et d'un seul cas observé.
- Ennemis : couleurs approchées faute de place en palette (7 couleurs remplacées par la plus proche, PAL2 est pleine). Ils ne tirent pas encore (routine `$6919` / `$444C`), ne touchent pas le joueur, et seule la vague 1 existe.
- Compilé et testé uniquement en émulation (Genesis Plus GX).

# Jalon 6 — toutes les vagues de type 5, contact, mort et réapparition

## Script d'apparition des ennemis (décodé)
- Banque $0B, table à `$5E1A` (186 entrées de 4 octets pour le stage 1), lue par la routine `$42B3` : octets 0-1 = position de défilement (÷4) + colonne x (×8), octet 2 = type (bit 7 = groupe), octet 3 = drapeaux (bit 7/6 = entrées spéciales, dont les nuages).
- Les groupes passent par un séquenceur (`$49DC`, 8 emplacements à `$3BD0`) avec tables `$46B5`/`$46D3`/`$46F1` (délai, nombre, type).
- Relevé sur une partie de référence : 546 apparitions, 15 types. `extract/waves_stage1.json`.

## Ennemi de type 5 (routine `$6100`-`$61DB`), maintenant complet
- 12 groupes de 6 dans le stage (72 ennemis), table générée dans `stage1_data.h`.
- Drapeau bit 1 : arrive par la droite (x = 248) et vire dans l'autre sens. Bit 0 : part en visant le joueur (routine `$4030` transcrite, tables `$40CD` et `$410D`), angle borné.
- Sortie : uniquement par le bas (y ≥ 256).
- Vérification ROM contre RAM PCE : partie immobile 2 758 frames avec ennemi, partie en mouvement 2 007 frames : 0 différente. Modèle Python : 25 252 positions, 0 différente sans tir ; 66 sur 9 026 dans la partie avec tirs (cas non élucidé d'un ennemi né tout près du joueur).

## Mort et réapparition (mesurées, `player.c`)
- Contact → explosion 25 frames → chute 3 px/frame (au moins 52 frames et jusqu'en bas) → réapparition en (64, 255), montée de 2 px/frame pendant 48 frames, invincibilité 192 frames avec clignotement 4/4.
- Vérifié sur une partie : mort à la frame 3832 (PCE 3831), commandes rendues à 3977 (PCE 3976).
- Vies : 3 au départ, affichées dans le HUD. À 0, le stage recommence (provisoire : le game over de l'original n'a pas été observé, les vies étaient figées dans mes parties).
- **Bouton A tenu = invincible** (debug) : les comparaisons automatiques s'en servent, car les parties PCE de référence sont invincibles.

## Écart important découvert : les bras
Dans l'original, un ennemi qui touche un bras est détruit sans tuer le joueur ; le bras se met à clignoter, et il faut plusieurs contacts avant la mort (partie « m1 » : 2 ennemis absorbés par le bras gauche aux frames 3826 et 3842, mort au 3e à 3861). La ROM tue au premier contact (frame 3828 sur la même partie). La boîte de contact de `enemy.h` a été ajustée sur 12 parties sans distinguer bras et corps : à refaire en lisant la routine de collision du joueur.

## Autres limites
- Seul le type 5 existe : les 14 autres types (dont les types 3 et 4, qui tuent un joueur immobile à la frame 4111 dans l'original) et les tirs ennemis restent à faire.
- La table d'apparition est relevée sur une partie (frames), pas encore lue depuis le script indexé par le défilement.
- 6 explosions simultanées au maximum (VRAM de sprites).
- Cloches : mêmes écarts qu'au jalon 5.

# Jalon 7 — bras, contact exact, ennemis de type 3 et 4

## Contact ennemi → joueur (banque $17, boucle `$AD2B`, gestionnaire `$AFE2`)
- Contact si |px−ex| < 10+demi-largeur et |py−ey| < 7+demi-hauteur (demi-tailles lues en RAM : type 5 = 4×5, type 3 = 5×5, type 4 = 2×11).
- Si |dx| ≥ 7+demi-largeur : zone des bras (routines `$AF67/$AF84/$AF9F/$AFB0`). Un bras disponible absorbe le coup : l'ennemi est détruit (+100), le bras clignote 32 frames puis est perdu. Sans bras disponible l'ennemi passe. Corps touché : mort du joueur (l'ennemi est aussi détruit).
- Joueur en réapparition (invincible) : seuls les ennemis de type 5 sont ignorés ; bras restaurés à la réapparition.
- Test après déplacement, une frame sur deux (`$83 & 1 == 1`) ; les événements MD apparaissent +2 frames après les lignes PCE = décalage d'affichage des sprites (ENEMY_LAG), c'est l'alignement correct à l'écran.
- Vérifié (m1, m3 : bras ; m2, m4 : mort ; m4 : 3e mort au PCE 4111 = MD 4113) ; non-régression cb / cc : 0 frame différente.

## Types 3 et 4 (navets/radis, banque $0C)
- Apparition en (x0, −32) (x0 = 24, 56, 88… relevés sur 63 événements), vitesse constante 0x22 via `velocity(angle, 34)`, angle visé une fois pour toutes (`aim`), ligne droite.
- Sortie : y ≥ 256, ou x < −32, ou x > 271 (fenêtre observée).
- Type 3 : sprite 16×16 (affiché en x−8, y−8) ; type 4 : 16×32 (x−8, y−16). Pas de groupe (pas de bonus de vague).
- Vérifié : positions identiques à la PCE sur cc (2 701 / 2 797 frames) et cb (1 270 / 1 325), 0 différence.
- Couleurs approchées sur PAL2 (erreur 15 552 contre 75 168 avec PAL3).
- Limite SGDK : 80 sprites au maximum ; pool partagé de 3 sprites par type (`MAX_MISSILE_SPR`), donc au plus 3 ennemis de chaque type affichés en même temps.

## Jalon 8 — tirs contre les types 3 et 4 (partie « ch »)
- Tir normal : demi-hauteur ennemie 0 pour les types 3/4 (|dy| < 16 ; le type 5 garde 21).
- Ennemi au-dessus de l'écran (y < 0) : intouchable par les tirs.
- Faisceau chargé niveau 2 : demi-largeur 27 (au lieu de 28) ; le niveau 1 inchangé.
- Résultat sur « ch » : type 3 : 0 frame différente sur 378 (avant : 137) ; type 4 : 1 sur 500 (avant : 117), un faisceau niveau 2 détruit un type 4 une frame trop tôt (f4884). Contacts/bras/mort inchangés (m1, m3, m4, cb, cc).

## Non résolu
- Période d'animation des types 3/4 (8 frames supposé), explosion, points des types 3/4 (+100 supposé), tirs ennemis, bombe, boss, 12 types restants, son.

# Jalon 9 — ennemis de type 7 (nacelles en formation) et tirs ennemis (analyse)

## Type 7 (routine `$6234`, banque $0C) — décodé et porté
- Groupes de 6 toutes les 17 frames, x = 48 (indicateur bit 0 = 0) ou 192 (bit 0 = 1), 90 apparitions sur le stage 1 (`stage1_pod7[]`, relevées sur la partie de référence).
- Apparition à y = −48, vitesse verticale initiale `$200 + 2*rang + $80` = `$288` (rang de difficulté `$8F` = 4 dans toutes les traces ; constante dans la ROM).
- État 1 : descend ; passe à l'état 2 quand (y+$50) ≥ $CE ou quand y joueur < (y+$50) (octets bas).
- État 2 (24 frames) : accélération ay = −16, ax = ±18 (signe selon le côté) ; état 3 : arrêt 96 frames ; état 4 (24 frames) : vitesse mémorisée (vy inversée), accélération ax = ∓16, ay = −16 ; état 5 : vx = 0, remonte à vy ≈ −648 et disparaît dès que y < −48.
- Image alternée toutes les 6 frames pendant les états 2 et 4. Demi-tailles de collision 2×5, 1 coup pour détruire.
- Vérifié : modèle Python (`tools/enemy7_sim.py`) = RAM PCE sur 90 apparitions, 22 050 frames, 0 différence ; ROM = PCE : 0 différence sur 3 941 frames (cc) et 1 931 (cb).
- Ressources : les ennemis 16×16 (types 3, 5, 7) partagent un pool de 12 sprites ; MAX_ENEMIES passe de 12 à 18 (comme les 18 emplacements `66..83` de l'original), nécessaire car deux groupes de 6 se chevauchent.

## Tirs ennemis : pas encore utiles au début du stage
- Routine `$6919` : chaque ennemi a un paramètre de cadence (`$39C1`, 1 pour le type 7) ; un compteur (`$3A2E`, un incrément toutes les 2 frames) déclenche la création d'une balle (routine `$444C` → objet de type 1, boîte 1×1) quand il atteint une valeur lue dans la table `$695F` selon le rang de difficulté `$8F` et le numéro de niveau `$B1`. Au rang 4 la valeur est ≥ 128 compteurs, soit plus de 250 frames : les nacelles (245 frames de vie) ne tirent jamais au début ; la première balle des traces apparaît en frame 15 847. À reprendre avec les ennemis suivants.

## Non résolu
- Tir chargé de niveau 1 contre le type 7 : la ROM détruit l'ennemi une frame trop tôt (3 frames différentes sur « ch »). La boîte du tir chargé demande de lire la boucle de collision tir/ennemi de l'original au lieu de l'ajuster.
- Les parties mortelles m1 à m3 montrent un écart d'un pixel sur le type 5 né à la frame 3817 (non vérifié si antérieur au jalon 9).
- Groupes de type 7 : bonus de destruction complète non relevé ; ennemis de type 8 (frame 5454), 12 (6754), 6, 9, 10, 11, 13 à 15 à faire.

# Jalon 10 — ennemis de type 8 (vaisseaux en demi-tour)

## Type 8 (routine `$648B`, banque $0C)
- Arrivent par le côté : bit 0 = 0 → x = −8, angle 3 ; bit 0 = 1 → x = 248, angle 13 ; y = −32 ; vitesse `$24` (table de sinus `$FEB8` via `$4111`). 54 apparitions relevées + 1 relevée sur la partie cb (frame 8300, absente de la partie cc car les 18 emplacements d'objets de l'original étaient pleins).
- État 1 : ligne droite jusqu'à ce que (y+$60) (16 bits) sorte de 0..255 ou que y joueur (octet bas) < (y+$60) (octet bas) ; état 2 : demi-tour, un cran d'angle toutes les 3 frames (+1 côté gauche, −1 côté droit), 16 crans, vitesse inchangée ; état 3 : ligne droite dans le sens opposé jusqu'à sortir de l'écran (x < −32 ou x > 271, y ≥ 256).
- Image 0x144 / 0x145 selon la parité de l'angle, demi-tailles de collision 4×5, un coup pour détruire.
- Tir au rang 4 : jamais (`$6915` avec seuil 6 ≥ rang).
- Vérifié : modèle Python = RAM PCE sur 54 apparitions, 10 962 frames, 0 différence ; ROM = PCE : 0 différence sur cb (1 719 frames) ; sur cc (2 549 frames) la différence vient uniquement de l'apparition ajoutée de la frame 8300.

## Limites
- Couleurs approchées : PAL2 n'a pas de vert, donc les vaisseaux verts de la PCE sont rendus en rouge/orange (palette sprites MD pleine).
- Tir normal contre le type 8 : 1 frame différente sur « ch » (même famille d'écart que les types 4 et 7).
- Il reste les types 12 (frame 6754), 6, 9, 10, 11 et 13 à 15, les tirs ennemis (quand le rang ≥ 6), la bombe, le boss, le son.

## Jalon 11 : ennemis de type 6 (spirale, routine $637B de la banque $0C)
- 61 apparitions dans le stage 1 (33 par la droite x=248, 28 par la gauche x=-8, y=200, vitesse $26, `extract/ev6.pkl`), table `stage1_pod6`, vitesses `ship6_vel` (vitesse 38 via `velocity`).
- Machine à états (modèle `tools/enemy6_sim.py`, 0 écart sur les 61 objets de la partie cc) : angle initial 0x17 (droite) ou 0x19 (gauche) ; état 1 : 6 crans toutes les 7 frames (sens −1 pour la droite) ; état 2 : 26 frames droites ; état 3 : 62 crans toutes les 5 frames (sens inverse) ; état 4 : 26 frames droites ; état 5 : crans toutes les 7 frames (sens du 1) jusqu'à la sortie par le bas (y >= 256).
- Affichage : un seul motif 16x16 (pattern $150), retourné horizontalement toutes les 8 frames ; clignote une image sur deux pendant les 48 premières frames (parité de la frame PCE + celle de l'apparition).
- Collision : demi-tailles 5x5. Zone de tir (SHH) non mesurée (0 par défaut), aucune trace ne tire sur le type 6. Aucun tir ennemi : le compteur $3A2E tourne mais aucun projectile n'a été vu.
- Vérification : cc 4029 frames, cb 1797 frames : 0 différente.

### Jalon 11 (suite) : mesure de la zone de tir du type 6, bloquée par la cadence de tir
- Traces `dumps/c2` (tir en impulsions 4 frames tenues / 4 relâchées de la frame 7000 à 9200, joueur identique côté MD : 0 frame différente) : 23 destructions de type 6 côté PCE.
- Les écarts MD viennent du tir du joueur, pas de la boîte de collision : PCE tire à 7002, 7018, 7034, 7050, 7074, 7090, 7112 (intervalles 14 à 24 frames), la MD tire à d'autres frames avec les mêmes appuis. Balayage SHH6 = 0, 3, 5, 8, 11 : écarts 350, 347, 352, 355, 358, donc sans effet. SHH6 reste à 0 (macro `SHH6` dans enemy.c).
- À faire d'abord : modéliser exactement l'acceptation d'un tir (appuis brefs répétés) avant de mesurer les zones de tir.

## Correction du jalon 11 (suite) et jalon 12 : mi-boss (type 11) et ses projectiles (type 12)
- **Correction** : la divergence de tir mesurée plus haut n'était pas un défaut de la cadence de tir. Le tir PCE de la frame 7000 était consommé par un objet de type 12 (projectile du mi-boss), que la MD ne connaissait pas. La cadence de tir est correcte.
- **Type 11 (mi-boss)**, apparitions aux frames PCE 6691 et 14787 (deux fois, identiques), x = 112 : descend de y = -30 à 80 à 2 px/frame (k = 0..55), puis état 2 (k 56..128), 3 (129..206), 4 (207..238), 5 (239..334), état 6 : remonte à 2 px/frame et disparaît à y < -48 (k = 399). Demi-tailles 10x5. Il encaisse des tirs (16 mesurés : 3 pendant la descente + 12 + le dernier à la frame 7034) ; non touché par contact. Affichage : deux moitiés (gauche normale, droite retournée), images 16x16 pour k < 171 et k >= 295, 16x32 entre (image haute « arrêt » pour k 207..246).
- **Type 12 (projectiles)**, demi-tailles 1x1 : 12 « convergents » (indices 0..11, un toutes les 6 frames à partir de k = 63, partent des bords, 80 frames de vol, intouchables, état 1) puis 12 tirés du boss (indices 16..27, un toutes les 8 frames à partir de k = 247, de (112, 88), vitesse $24 aux angles de la table, sortie de l'écran, vulnérables au tir, état 2). Table `stage1_bul12` (position 8.8 et vitesse relevées sur la partie cc).
- **Emplacements** : l'objet explosion de l'original garde son emplacement 31 frames (la MD le fait maintenant, état `on == 4`) ; un projectile créé dans un emplacement déjà traité dans la frame par le boss n'apparaît qu'à la frame suivante (état `on == 3`). Pool de sprites 16x16 porté à 16 (18 fait planter la ROM : limite de 80 sprites).
- **Vérification** : cc 798 frames (type 11) et 614 (type 12), cb 399 et 306 : 0 différente ; types 3, 4, 5, 6, 7, 8 inchangés sur cc et cb.
- **Non résolu** : timing exact des destructions par tir. Sur c2 (tir en rafales à partir de 7000) : type 12 1 frame différente, mais types 6, 8 et 5 divergent par cascade ; sur c3 (joueur sous le boss, `dumps/c3`) le boss meurt 1 frame trop tard côté MD (un tir est absorbé par un projectile qui n'est pas touché côté PCE). Essai « test de collision avec la position du tir de la frame précédente » : type 5 passe de 25 à 3 frames différentes sur ch mais le type 8 se dégrade (les demi-hauteurs de tir de chaque type ont été calées sans ce décalage). À refaire proprement avec un jeu de traces de tir par type.
- Points de score du mi-boss et des projectiles : non mesurés (ENEMY_SCORE par défaut sauf contact : aucun point). Effet des tirs chargés sur le boss : non mesuré (1 dégât par frame de contact).

# Jalon 13 — écran titre, flux titre → jeu → game over, ennemis de type 9 et 10

## Écran titre
- Image = dernière image de l'intro PCE (frame 1740 de `dumps/boot`, recadrée sur 224 lignes à partir de la ligne 15), réduite à 4 palettes de 15 couleurs (`tools/mdpal.py`, 2,2 % de pixels modifiés), ressource `title_image` (non compressée : le décodage « BEST » de 896 tuiles prenait ~2 s au démarrage).
- « PUSH START BUTTON » clignotant : ajout MD (l'original n'affiche pas de texte sur cette image). START lance le stage 1 ; plus de vie → retour au titre.
- L'intro Konami / défilement animé de la PCE n'est pas portée (image fixe).
- Corrections liées : l'écran reste noir pendant le chargement du stage (palette de fond posée à la fin de `STAGE_init`), un `SYS_doVBlankProcess()` après `STAGE_init()` vide la file DMA (sans lui, un redémarrage affichait un décor vide pendant ~100 frames), `SPR_initEx(640)` (VRAM sprites ; tuiles utilisateur 16..743 < 800, marge de 57 tuiles).
- `tools/mdtest_stage.py` appuie sur START à la frame 300 (le jeu démarre au titre).

## Types 9 et 10 (banque $0C, table de gestionnaires à $16C26)
- Table des gestionnaires : type 9 → `$65FE`, type 10 → `$652D`, types 13/14 → `$4EE0`, 15 → `$4F2E` (objets au sol, voir ci-dessous).
- **Type 9 (soucoupes grises)** : 16 apparitions (2 séries de 8, toutes les 21 frames, côtés alternés), x = 24 ou 216, y = −8, vx = ±256, vy = $120 avec ay = −3 : x atteint 120 quand vy atteint 0 (96 frames) ; arrêt 96 frames ; puis cran d'angle toutes les 17 frames (vitesse $1C, sens selon le côté) jusqu'à (y & $FF) ≥ $D0 ; elle fonce alors sur le joueur (visée `$4030`, vitesse $40). Image 15/16/17/18 aux frames 0/56/68/80 puis figée sur 18. Collision 5×5. Modèle `tools/enemy910_sim.py` = RAM PCE sur 16 objets.
- **Type 10 (petits vaisseaux en formation)** : 12 apparitions (2 séries de 6, x = 56 + 24·n puis 136 + 24·n, y = 224, vy = −256) ; montent 192 frames, puis ay = 8 et ax = ±18 (signe : octet x − $78 négatif → +18) pendant l'ouverture des ailes (images 19→23 aux compteurs 13, 26, 38, 51), ax s'inverse quand vy = 0, fin quand vy atteint 512 (puis redescendent) ; les objets de rang impair (après la décision) descendent en plus de 1/3 px par frame (`$427F`). Collision 9×5. Images 21 à 23 = deux demi-sprites 16×16 symétriques (composés en un 32×16 côté MD).
- Vérification ROM = PCE : cc 1098 frames (type 9) et 463 (type 10), 0 différence ; tous les autres types inchangés (cc, cb : 0 ; ch, c2, c3 : mêmes écarts de timing de tir qu'avant).
- Couleurs approchées par PAL2 (gris / rouge-bleu).

## Constats pour la suite (stage 1 jusqu'à la fin)
- Les objets de type 13/14 (rangée de 5 « cibles » au sol, y = 179 relatif au défilement, images 38/40) et 15 sont des ennemis au sol : non implémentés (la bombe, bouton I, n'existe pas encore côté MD).
- Fin du stage : le défilement s'arrête à la frame PCE 18 300 et un boss géant (crabe rose, nombreux sprites, projectiles orange et anneaux bleus) occupe l'écran dans une arène sombre à piliers ; trace `dumps/ce/ce.trace` (frames 17 500 à 24 000), captures `dumps/ce/g*.rgba`. Non porté.

# Jalon 14 — stage 1 jouable de bout en bout (boss de fin approximatif)
- Flux : titre → stage 1 → boss de fin → « STAGE 1 CLEAR » (START) → titre ; plus de vie → titre.
- **Boss de fin = APPROXIMATION non vérifiée** : le crabe est déjà dans le décor extrait (statique) ; un objet invisible (type interne 13) à (120, 50), boîte 44×22, 100 tirs, lance 3 tirs visés toutes les 50 frames (sprites des projectiles du mi-boss), actif dès la frame de jeu 15 160 (PCE 18 040), +10 000 points à la mort. L'original (trace `dumps/ce/ce.trace`) : crabe animé qui se déplace (y 15–105, x 108–124, mouvement dépendant du joueur), anneaux bleus, projectiles orange, bras en sprites (patterns 288–370, palette 12), piliers = objets de type 2. Rien de cela n'est reproduit ; le crabe reste affiché après sa défaite.
- Vérification : cc, types 3–12 inchangés (0 différence) ; seuls les projectiles du boss approximatif diffèrent (type 12 après la frame 18 090).
- Harnais : le champ `bossDead` ajouté à `EnemyState` décale le tableau des types (offset +4 dans `mdtest_stage.py`).
- Toujours absents : bombe (bouton I), ennemis au sol (types 13/14/15, rangées de cibles), cloches de couleur / bonus (vitesse, etc.), tirs ennemis hors boss, son, intro Konami, stages 2+.

## Jalon 15 — ennemis au sol (types 13/14/15) et bombe

**Bombe (bouton I PCE → C sur Mega Drive ; A reste l'invincibilité de débogage, haut+bas = vitesse x4)**, décodée sur la trace `dumps/bb4` :
- 2 emplacements (objets 38 et 43 sur PCE), alternés ; une pression = une bombe dans le premier emplacement libre.
- Viseur automatique : ennemi au sol (y entre 70 et 150, |dx| < 32 du joueur) non déjà visé, sinon (x joueur, y 111). La bombe part à y joueur − 5, x visé −12 (emplacement 38) ou +12 (emplacement 43).
- Vol : immobile 8 frames, puis −2,5 px/frame ; elle explose quand elle atteint le y de la cible ; l'ennemi touché devient une explosion 4 frames plus tard, +100 points.
- Vérifié sur bb4 : trajectoire de la bombe à ±1 frame, destruction des ennemis au sol à ±1 frame de la frame PCE.
- Non fait : l'objet (type 29) que l'ennemi laisse en mourant, l'explosion propre aux ennemis au sol (blanche/fumée sur PCE ; on réutilise l'explosion aérienne).

**Ennemis au sol** (17 apparitions relevées sur `dumps/cc`, `stage1_ground[]`) :
- Types 13/14 ($4EE0) : suivent le défilement du sol (delta de scroll de la frame), fermés 240 frames (120 pour l'indicateur 1 au premier cycle), ouverts 10 frames. Ne se détruisent qu'à la bombe, tirs normaux sans effet.
- Type 15 ($4F2E) : marcheur, 96 frames d'arrêt / 128 frames de marche (vx ±0,125, vy 0,125), image 344/345 alternée (10 / 192 frames).
- Vérifié contre `dumps/cc` : types 14 : 15 frames différentes sur 3963 (un décalage d'1 px d'une frame tous les 256 frames) ; type 15 : 13 sur 3133.
- Non fait : leurs tirs (le marcheur tire un projectile visé à chaque cycle ; les types 13/14 ne tirent qu'à partir du rang 6, donc pas ici).

**Technique** : 6 emplacements dédiés aux ennemis au sol (`MAX_ENEMIES` 24, `MAX_AIR` 18) ; limite de 80 objets sprite du moteur SGDK atteinte → une seule feuille `spr_exm` par explosion (au lieu de deux objets), `sEnemy` passe à 22 ; SPR_initEx(696).

## Jalon 16 : boss de fin visuel
- `tools/mkboss.py` (appelé par mkassets) : 11 motifs du crabe (VRAM PCE b18100) → `res/boss_l.png`/`boss_s.png`, quantifiés sur la ligne de palette BG 0 (état final des événements de palette) ; `src/boss_data.h` : 21 poses (≤12 pièces) + pose/ancre par frame depuis la trace `dumps/ce` (joueur immobile).
- enemy.c : à la frame de jeu 14620, libère sEn10/sEn4/nuages (VRAM) et crée 12+4 sprites ; position = ancre + dx/dy. Capture `md/shots/bt/all.png` vs `pce.png` : disposition concordante.
- Reste approximatif : HP/tirs/mouvement dépendant du joueur, explosion de mort.

## Jalon 17 : dynamique du boss
- Relevé sur `dumps/ce` (SAT) : tirs ennemis = motif 487 ; salves de 3 depuis le canon gauche (obj x 73) puis droit (167), à y_crabe+63, toutes les ~80 frames (première : PCE 18007 = frame de calcul 15127). Implémenté (visés, angle±2).
- Boîte de collision du boss suit l'ancre du crabe (y = ay+32). PV : aucun octet de PV trouvé en RAM (balayage décrément/coïncidence avec les tirs) ; estimation = 500 tirs consommés avant la mort (trace `bs` : mort en PCE 24780, 554 tirs disparus). À affiner.
- Mort : sprites du crabe masqués, `STAGE_eraseBoss` remplace le décor du crabe par `res/boss_clear.png` (bande vide + piliers extraite sous le crabe), explosions aléatoires ~130 frames (PCE : 24780→24910), puis fin de niveau. Trajectoire en boucle au-delà de 6500 frames.

## Jalon 18 : tirs ennemis génériques
- Objets 48..65 type 1 (routine $444C) : 72 événements de tir uniques extraits de toutes les traces (`tools/ext_ebul.py` → `extract/ebul.pkl`) ; frame et position du tireur identiques d'une partie à l'autre. Vitesse 319/256, 32 directions, angle = visée + (0..3) − 1. Côté MD : le tir part si un ennemi vivant est à la position relevée (±3 px) et si le joueur n'est pas à moins de 0x30×0x28 (routine $4507).
- Boss : tirs relevés séparément (jalon 17).

## Jalon 19 — stage 2 jouable (décor, scroll, nuages, ennemis rejoués, tirs)
- Chaîne : `tools/build_all.sh` (mkassets, mkstage2, mkenemies2, compilation).
- Ennemis du stage 2 : trajectoires rejouées depuis le relevé PCE (idle-run, 321 instances, 223 gabarits, 145 images), HP=1, pas de poursuite ; tirs génériques rejoués (64 événements).
- Bug corrigé : réserve de VRAM sprites trop petite (560) -> NULL sur SPR_addSprite -> corruption de la liste. Le décor du stage 2 s'arrête à la tuile 786 ; réserve portée à 640.
- Reste : boss stage 2 (vaisseau, scroll figé à 37666), cloches/objets du stage 2, score, stage 3+, son.

## Jalon 20 — tables du stage 2 compactées + trace complète du jeu
- Tables d'ennemis : paires (dx,dy) dédoublonnées (1 octet/pas) + images en run-length ; contrôle d'aller-retour dans mkenemies2.py. Code 506 -> 338 Ko.
- Boss du stage 2 : le vaisseau est dessiné en fond (BG) par un script d'une dizaine de milliers de frames (états 1 à 12 de l'objet 72, 37600 -> 47754) ; non reproduit. Le scroll s'arrête à $0FFC.
- Trace complète : `dumps/s3.script` -> `dumps/s3/` (trace s3t depuis 47960, dump toutes les 40 frames jusqu'à 110000). Elle traverse les stages 3 à 6 (boss jaune en stage 3 vers 77000, boss violet en stage 4 vers 131000...).

## Jalon 21 — stage 3 jouable (îles flottantes), chaîne paramétrée par stage
- Chaîne générique : `tools/ext_inst.py` (instances d'ennemis), `ext_ebul_n.py` (tirs), `ext_clouds.py` (nuages), `stitch2.py` (fond recollé à partir du scroll RAM de la trace), `mdpal_dyn.py`, `mkstageN.py`, `mkenemiesN.py`, `build_all.sh`.
- Traces : `dumps/s3/` (partie avec tir, dumps toutes les 40 frames jusqu'à 110000), `dumps/s3i/` (sans tir, trace 47000 -> 73000). Stage 3 = frames PCE 48142 -> 72662 ; scroll 4992 px fini à 63226 ; stage 4 dès 72662 (6299 px), stage 5 dès 92066 (4179 px), stage 6 dès 105095.
- Ennemis : tables communes `e2types.h`, données par stage (`E2Data`), pools de sprites plafonnés (14/8/4/3) car la VRAM sprites est à la limite.
- Boss du stage 3 (soleil jaune, 63226 -> 72259) : non fait. Les objets 104-107 (types 4/5) sont une chaîne de pièces qui saute d'une frame à l'autre ; la chronologie est la même avec ou sans tir (le boss ne dépend pas du joueur). Le stage se termine provisoirement 300 frames après la fin du défilement.
- TEST_SKIP (stage.c) : saute à 50 frames de la fin du défilement, pour tester les enchaînements.

## Jalon 22 — Stage 4
- Stage 4 intégré : décor (stitch3 + scroll RAM, 701 tuiles, 38 événements palette), nuages (39), ennemis rejoués (types 39–47, 241 templates, pools 14/8/0/3), tirs génériques.
- Testé sous émulateur (START_STAGE=4, captures 500..4500) : pas de crash, rendu conforme aux dumps PCE.
- Reste : boss stages 2/3/4 (fin provisoire scrollFrames+300), stages 5/6 (run idle avec dumps requis), tirs des ennemis sol, cloches/items, score, son.

## Jalon 23 — Stages 5 et 6
- Run PCE à vide avec dumps (dumps/s5.script : trace 92000–124000, dump toutes les 40 frames) → décor, ennemis (types 48–58 et 60–76), tirs, nuages.
- Stage 5 : décor périodique (512 px) + fin ; 6918 px. Stage 6 : 3071 px, 9318 frames.
- Nouveaux outils : `prepimg.py` (limite à 30 couleurs, fusion de tiles rares), `mergeidx.py` (fusion des tiles indexées jusqu'à 700), `mdpal_dyn.py` avec affinité de slots. Perte visuelle ≈1–2 % des pixels (blocs visibles par endroits).
- E2_MAX_PIECES 8 → 12 (un ennemi du stage 6 a 11 pièces). Avertissement connu : un delta pièce hors s8 dans stage6_enemies.h (une pièce mal placée).
- Les ennemis au sol du stage 5 (cristaux/plateformes) ne sont pas rejoués (pool sol = 0).
- Jeu jouable des stages 1 à 6 ; fin de chaque stage 2–6 provisoire (scrollFrames+300), pas de boss.

## Jalon 24 — Boss du stage 2 (galion) rejoué
- Le galion est un décor BG (BAT 64x64 de la PCE) : 637 tuiles distinctes, ≈50 couleurs → partition statique 2×15 couleurs (`tools/mkboss2pal.py`, erreur faible, 145 tuiles légèrement dégradées).
- Capture fine : `dumps/s2b.script` (dump toutes les 8 frames, 37600→47800) ; `tools/mkboss2.py atlas` (dictionnaire de tuiles), `tools/mkboss2data.py` (BAT initial + diffs par keyframe + scroll X/Y par frame → `src/boss2_data.h`).
- Scroll : octets RAM $3DB6 (X−8) et $3DBA (Y−3, signé) ; le bit 8 est retrouvé par continuité (vérifié sur 238 ancres/dumps, seul écart en toute fin quand l'écran est vide).
- MD (`src/boss2.c`) : tileset chargé à TILE_USER_INDEX, copie du BAT, lignes entrantes écrites dans le plan B (anneau 32 lignes), diffs appliqués à chaque keyframe, HScroll/VScroll par frame. Début à la frame PCE 37 400 (ciel vide), fin 47 760 → « STAGE 2 CLEAR ».
- Ennemis du stage 2 re-extraits sur toute la durée (types 2,3,4,16–28 : pirates, boulets…). Les objets de type 1 des emplacements 90–95 dans la fenêtre du boss ne sont pas des nuages (fumées) : supprimés de la liste des nuages.
- Bug corrigé : rescomp supprime les images vides en fin de feuille de sprites → `pc->img >= numFrame` faisait planter updateFrame ; garde ajoutée dans e2Draw (valable pour tous les stages).
- Non fait : le galion ne peut pas être détruit (séquence fixe, comme observé en run sans dégâts), pas d'explosion finale.

## Jalon 25 — Système de bonus (cloches colorées) : première partie
Sources : routines banque $17 (`$AB96` tirage de couleur, `$AFE2`+ effets), tables lues dans la ROM, vérifié par poke/traces PCE et par émulation MD.
- Couleur d'une cloche : compteur global `$C4` (0..29), +1 à **chaque apparition de cloche et à chaque tir reçu**, table `$AC30` : une cloche colorée tous les 5 coups, dans l'ordre noire(2), blanche(3), bleue(1), verte(4), rouge(5), violette(6) ; palette de sprite ($AC4E) 5,7,1,3,4,6 ; la couleur reste jusqu'au tir suivant. Vérifié : $C4=5 → blanche, 10 → bleue sur les traces PCE. Une couleur déjà acquise redevient jaune (règles $ABC2–$AC2E : blanche si flag $04 ; verte si option 1 ; rouge si flag $82 ; violette si option 2 ou flag $80).
- Effets au ramassage (octet de bonus joueur $3438 : $01 option 1, $02 option 2, $04 tir double, $80 rouge) : bleue = vitesse +2 (niveau $3954, 4 → 18 max, vitesse = 0x80 + niveau×0x40 en 8.8), noire = vitesse −2 (min 0), blanche = tir double, verte/rouge/violette = flags posés. Tout est perdu à la mort ($3954 → 4, $3438 → 0).
- Tir double (poke $3438=04 en PCE) : même objet, anim 28 au lieu de 14, boîte de touche 12×12 au lieu de 8×16 ; sprite motif 495 (`tools/ext_twin.py` → extract/sprites_twin.npy).
- MD : `bellRoll()` (stage.c), `player.speedLvl/flags`, `enemyShotHW/HH`, feuille `spr_bell` à 14 images (7 couleurs × 2). La violette PCE (magenta) est approchée par des bleus sombres (PAL2 n'a pas de magenta). Test : `DBG_BELLCNT` (stage.c) force le compteur initial ; vérifié compteur 4/9/14/19/24/29 → flags 4 / vitesse 6 / flag 1 / flag 128 / flag 2 / vitesse 2.
- **Non fait** : effets visibles des options (traîne de 24 positions $3C5F, sprites suiveurs), du flag rouge ($80, minuteur $34AE), tir 3 directions ($08) et bouclier ($10) venant des objets au sol ($2EEDC, $2EF07), vie supplémentaire ($2EEF4), décalage ±4 px de la cloche à chaque tir, points des cloches colorées, élargissement des boîtes tir double vs nuages/cloches.

## Jalon 26 — Options (cloches verte et violette)
- Les options sont 3 mini-abeilles (objets 3–5 pour l'option 1, 6–8 pour l'option 2, motif 481) qui reproduisent la position du joueur avec 7, 15 et 23 frames de retard (historique de 24 positions, routine banque 1 $D052-$D0C6) ; à l'acquisition tout l'historique est rempli de la position courante. Mesuré sur cs.trace (11079). Les deux options utilisent les mêmes retards (superposées dans le code d'origine).
- MD : historique dans player.c, 3 sprites `spr_orb` (affichés si flag OPT1/OPT2, cachés pendant mort/clignotement). MAX_BELLS 8 → 5 pour rester sous les 80 sprites.
- Non vérifié : collision des options (boîte 7x7 dans l'objet, aucun tir, aucune destruction d'ennemi observée sur la trace) -> pas de collision côté MD. Reste : cloche rouge, tir 3 voies/bouclier (objets sol), vie supplémentaire.

## Jalon 27 — Musique (FM + PSG + PCM) via XGM2
Chaîne : pilote sonore PCE (banque $02, requête = `JSR $E3FC` avec A = identifiant) → capture des écritures PSG → conversion → VGM → rescomp `XGM2` → pilote XGM2 (Z80) de SGDK.
- **Outils PCE** (`tools/pcedump`) : `psglog <nom>` (journal exact des écritures $0800-$0809 avec horodatage cycle + instantané par frame, format lu par `tools/psgw.py`), `snd <id>` (simule `JSR $E3FC` avec A=id), `mute <masque>` (coupe des canaux PSG), `pcm <nom>`/`pcmoff` (audio PCE s16 stéréo 44,1 kHz), `sndlog <n>` (pas à pas : journal des requêtes sonores du jeu, `sndlog.txt` = « frame id »). `tools/mdshot` : `wav <nom>`/`wavoff` (audio MD).
- **Identifiants** (hex = valeur de A ; les captures `dumps/songs/g<décimal>.psg` sont nommées en décimal) : 01-0A effets canal 0 ; 0B jingle de boot (126 frames) ; 11 jingle court 6 canaux (62 frames, probablement perte de vie, appelé en banque 0 `$E639`) ; 17 tir du joueur ; 19 cloche ramassée ; 1A cloche touchée ; 1B ennemi détruit ; 1D gros ennemi ; 21 effet long (charge) ; 28 bonus ; 40 effet canal 4 ; **4D** intro de stage 1 (958 frames, avant l'origine du stage) ; **53** titre ; **5B** stage 1, **62** stage 2, **67** stage 3, **6C** stage 4, **71** stage 5, **7B** stage 6 ; **80** boss (stages 1, 2, 5), **87** boss (stages 3, 4), **8C** boss du stage 6 ; **91** jingle de fin de stage (352 frames) ; 47 (id 71 décimal), 9D, A3 : autres jingles non identifiés (game over / continue / fin ?).
- **Captures propres** : le titre rejoue sa démo après ~2500 frames et coupe le son : les morceaux sont donc lancés **en jeu** (stage 1, joueur invincible/vies figées) par `snd FF` puis `snd <id>` à la frame 3550, capture 8000 frames (`dumps/songs/run2.sh`). Boucles : détectées par autocorrélation d'une signature tolérante (note + volume ≠ 0) : période 91:3614, 98:3234, 103:2420, 108:1684, 113:2257, 123:2234, 128:3373, 135:1271, 140:1795 frames ; début de boucle = premier point où la similarité glissante (300 frames) ≥ 0,8. Le titre (83) est bouclé en entier (la boucle détectée n'était qu'un silence de 300 frames, et XGM2_playTrack(0) reprenait alors sur la boucle seule).
- **Conversion** (`tools/mkmusic.py <id>` → `md/twinbee/res/music/s<id>.vgm`) : 1 état PSG par frame (60 Hz) ; canaux 1, 2, 3 (et 0 au titre) → **FM** (YM2612 algo 7, 4 opérateurs en additif : MUL = les 4 harmoniques dominantes de la forme d'onde 32×5 bits, TL = enveloppe de volume PCE recalculée à chaque frame, F-num recalculé depuis la fréquence PCE, vibrato inclus) ; canal 5 → **PSG tone 0** (fréquence PCE = période SN76489 directement, repliée de 1 octave si >1023) ; canal 4 bruit → **PSG bruit** (tone 3 comme horloge) ; canal 4 DDA (batterie échantillonnée) → **PCM** : les rafales d'écritures DDA (30-120 écritures/frame) sont regroupées par signature des 40 premiers échantillons, `0xE0 seek + 0x80` dans le VGM (xgm2tool déduplique et rééchantillonne). Gains calibrés par canal contre le rendu PCE (RMS ±1 dB, `tools/muscal.sh`), spectrogrammes comparés (`tools/cmpaudio.py`, `tools/musictest.sh`).
- **Intégration** : `src/mus.c/.h` (XGM2_load(mus_all) puis `XGM2_playTrack`), pistes : 0 titre, 1-6 stages, 7 boss A, 8 boss B, 9 boss 6, 10 fin de stage. Lancement aux frames de stage mesurées sur PCE (thème : 322/60/53/62/59/66 ; boss : 14620/11815/15084/9889/9211/8933). 331 Ko de données, ROM 2,2 Mo.
- **Non fait** : jingle de perte de vie / game over / continue (ids 11, 47, 9D, A3 non reliés), effets sonores restants (voir j28), cloche rouge/objets, fondu.

## Jalon 28 — Bruitages PCM
- Rendu de chaque effet 01..40 (hex) en isolation (`dumps/sfx/run.sh` : `snd FF` puis `snd <id>`, `pcm`) → `tools/mksfx.py <ids>` : mono 13,3 kHz, recadré, +6 dB, WAV → `res/sfx.res` (`WAV sfx_XX "…" XGM2 13300`).
- Appels (`SFX_play`, canaux PCM 2 et 3 d'XGM2, le canal 1 reste à la batterie du morceau) : tir joueur (17), ennemi détruit (1B, dans `kill()`), cloche touchée (1A), cloche ramassée (19), bonus (28 : défini, pas encore appelé).
- Journal des requêtes en jeu (stage 1, 3400-9000, `dumps/sl2/sndlog.txt`) : 17 ×511, 1B ×98, 1A ×23, 19 ×5, 28 ×1 (frame 5088), 1D ×1, 21 ×1 : 19 suit la collecte d'une cloche colorée dans la frame suivante (ex. frame 4437 → 4438).

## Jalon 31 — Boss des stages 3 à 6 (rejeu de sprites) + cloche rouge
- Boss 1 corrigé (rochers/anneaux), cloche rouge = barrière (10 coups, flag $80, SFX 0x28).
- Boss 3–6 : rejeu des sprites PCE (`src/bossn.c`), données delta par frame générées par `tools/mkbossN.py` (voir commandes dans `tools/build_all.sh`), `src/bossN_data.h`, `res/bossN_*.png`. Boss 6 en boucle. PV 400 (estimés), hitbox non mesurée.
- Vérifié à l'émulateur : stages 3, 4, 5 (ver jaune, PAL2 sans vert clair) et 6 (boss final).
- Reste : intro, objets au sol (ventilo/bouclier/vie), décalage cloche ±4 px, hitbox barrière, jingles mort/game over, stage 6 fin.

## Jalon 32 — Intro (version animée)
- `src/intro.c` : logo Konami en images fixes (captures PCE `dumps/boot/f0180`, `f0420`), puis scène de vol entièrement animée à 60 images/s : fond en dégradé de CRAM (jour → crépuscule → nuit), 6 nuages (64×32, extraits de f0660) défilant de 1 px/image, 22 étoiles scintillantes (dessinées), TwinBee (32×32, extrait de f0900) qui monte puis flotte. Sprites générés par `tools/mkintro.py`. START abrège.
- Première version (images fixes quantifiées, fondus) abandonnée : saccadée. Attention : `SPR_setPosition` prend des coordonnées écran (pas de +128).
- Écarts : 1 seule abeille (l'original en a deux), pas d'enseigne qui descend dans l'intro (elle n'apparaît que sur l'écran titre).

## Jalon 33 — Fruits laissés par les ennemis au sol (corrige une première version « vie »)
- Traces `dumps/bb4`, `dumps/it1` (partie de 9 000 frames, bombes en balayage), `dumps/it2` (joueur forcé sous l'objet par `poke 2B47`) : 5 objets de type 29, emplacements 96/97, créés à la position de l'ennemi tué à la bombe, chute 1/3 px par frame, disparition vers y 166 ; sous-type `$3468` = 0 dans les 5 cas. Ce sont des **fruits** (pêche motif 422 pal 7, pomme 419 pal 4, vus dans `dumps/it1/m5700` et `m10560`).
- Ramassage observé (it2, joueur sous l'objet) : aucun point, aucun changement durable de la RAM utile → effet = SFX seul (sous-type 0, ROM `$AE71` : SFX $22).
- Les 4 autres sous-types de la routine ROM (banque $17 `$AE44`) : 1 efface les objets ($AE77), 2 `$3438 |= $08` + SFX $28 ($AEDC, éventail), 3 `$A0 |= $10` ($AF07, bouclier), 4 vie +1 BCD max 99 + SFX $23 ($AEF4). Jamais vus en jeu : source/tirage inconnus (peut-être les mêmes objets hors stage 1, ou issus d'autres événements).
- MD : `itemDrop/itemUpdate` (enemy.c), 2 emplacements, fruits alternés pêche/pomme (`spr_item`, `tools/mkitem.py` depuis les dumps it1), ramassage |dx|,|dy| < 12 (estimé), SFX cloche. Vérifié à l'émulateur (affichage et chute).


## Jalon 35 — Musique refaite depuis les MDX X68000
- Retour utilisateur : musique « horrible » (rendu des captures PSG PCE en FM additif). L'utilisateur a fourni `DTWNB*.MDX` (version X68000, séquences MXDRV d'origine avec vraies voix OPM) → `extract/mdx/`. Le zip « TG-16 » reçu était une page anti-bot, inutilisable.
- `tools/mdx.py` : lecteur MXDRV (voix 27 octets, commandes FF..E8 ; LFO = 1 ou 5 octets). Validé : les 8 pistes FM d'un morceau totalisent exactement le même nombre de clocks. Volume : arg ≥ 0x80 = atténuation (arg−0x80), < 0x10 = table VOLTAB. Clock = 1024×(256−T)/4 MHz.
- `tools/mkmdx.py <n° MDX> <vgm>` : pistes 0-5 → FM YM2612 (voix OPM recopiées telles quelles, même format de registres ; TL des porteuses + atténuation + `MTL`), pistes 6-7 → PSG carré, piste ADPCM (PDX absent) → percussions PSG par heuristique (0/2 grosse caisse, 1/10/11 caisse claire, 9 cymbale, 3-8 toms, reste charleston). DAC coupé (batterie PCM PCE supprimée). Ties (F7) fusionnés ; boucle = cible du F1. Vibrato/LFO, portamento, detune non rendus.
- Note MDX → MIDI : +15 (calé sur les captures PCE ; corrélation de chroma 0,92 sur le titre rendu).
- Correspondance PCE → MDX : 83 titre→10, 91 stage 1→00, 98→01, 103→02, 108→03, 113→04, 123→06, 128 boss A→11, 135 boss B→12, 140 boss 6→13, 145 fin de stage→07 (sans boucle). Stages 3-6 et boss A choisis d'après titres et durées.
- Ancienne chaîne (captures PSG, `tools/mkmusic.py`, jalon 27 et réglages du 35 précédent) conservée.
- Non vérifié à l'oreille.

## Jalon 36 — Logo Konami animé et étude du mode 2 joueurs
- Logo (`src/intro.c`, `tools/mkintro.py`, captures `dumps/kon`) : ligne bleue qui descend (~2 px/image) et révèle le contour ligne par ligne (BG_A = ligne scrollée, BG_B = tuiles du contour ajoutées), 30 images de pause, remplissage couleur par fondu de palette, puis fond noir → blanc en 7 paliers de 5 images (indice 0 de la palette), pause de 70 images. Total ≈ 4,5 s (PCE : image 20 → ~260).
- **Mode 2 joueurs de l'original (à implémenter)** : existe, simultané. Se déclenche en appuyant sur RUN sur la manette 2 (multitap, `EnableTurboTap(true)` ajouté à `tools/pcedump` + commande `keys2 <masque>`), le HUD « 2P PRESS RUN » devient « 2P ♥ 2 » avec score et jauge propres. Le joueur 2 est l'objet 1 : entre par le bas à x = 160 (le joueur 1 est à 64 dans cette partie), monte de 2 px/image de y = 247 à y = 159, 2 vies (octet `$2088`, joueur 1 : `$2087`). Il se pilote avec la manette 2 (déplacement et tir vérifiés sur `dumps/tw`). Pas encore étudié : bombes/options/vitesse du joueur 2, collisions entre joueurs, partage du score, game over d'un seul joueur, couleur (WinBee rose).

## Jalon 37 — Mode 2 joueurs (WinBee)
- **Entrée** : START sur la manette 2 (RUN sur PC Engine) pendant le stage ; le joueur 2 monte depuis (160, 255) à 2 px/image comme sur la trace, 2 vies, invincible 192 images. START manette 1 relance toujours le stage (et remet le 2P à zéro).
- **Architecture** : `players[2]` (`player` = `players[0]`), état privé et sprites par joueur dans `player.c` (`playerCur`, macros `P` / `V`) ; `PLAYER_update(n, joy, frame)` / `PLAYER_draw(n)` ; le joueur 2 crée ses sprites à l'entrée seulement (budget 80 sprites).
- **Stage** : cloches ramassées par le premier joueur à portée, tirs, tirs chargés, score (`stage.score2`, en fin de structure), bombes (4 voies : 2 par joueur) et contacts ennemis par joueur ; HUD du joueur 2 = moitié droite du HUD PCE (`tools/mkhud2.py`, décalage de 15 colonnes, cœur rose sur l'entrée 15 de PAL3).
- **Mort** : chaque joueur a ses vies ; à 0 vie avec l'autre en jeu, le vaisseau disparaît (phase 3) ; retour au titre quand les deux sont éliminés.
- **Approximations (non vérifiées sur trace)** : les ennemis visent le joueur 1, ou le joueur 2 si le 1 est touché/éliminé (l'original a peut-être une autre règle) ; la couleur des cloches tient compte des bonus des deux joueurs ; le bonus de groupe est crédité au joueur 1 ; **WinBee a les mêmes couleurs que TwinBee** (palette sprites PAL2 pleine, PAL1 utilisée par le décor du stage 1).
- Outils : `mdshot` accepte `keys2 <masque>` (manette 2) ; `mdtest_stage.py` appuie deux fois sur START (intro puis titre).

## Jalon 38 — Règles 2P relevées sur trace (`dumps/tw2`, `tw3`, `tw4`)
- **Ciblage** : le virage des ennemis de type 5 se déclenche sur le joueur le plus proche en x (vague arrivant par la droite, P1 en 64 / P2 en 160 : trajectoire identique à la RAM PCE avec x cible = 160, écart 0 sur 14 trajectoires ; avec P1 en 225 / P2 en 16 la meilleure cible est 225). Implémenté pour toutes les visées (`nearP`, `TX`/`TY` dans enemy.c).
- **Collision entre joueurs** : les deux vaisseaux se repoussent, distance minimale 16 px sur au moins un axe. P1 qui pousse P2 de face avance à demi-vitesse et déplace P2 d'autant ; en montant en diagonale, P1 chasse P2 de 4 px vers le bas. `PLAYER_collide` rend la poussée en x à ±3 px et ne reproduit pas la poussée en y (P2 reste en 159 au lieu de 163).
- Reste non vérifié : cible des tirs d'ennemis quand les deux joueurs sont à égalité, bonus de groupe, couleur de WinBee.

## Jalon 39 — WinBee en rouge
- Pas de ligne de palette libre pour un vrai rose : le joueur 2 utilise des sprites `spr_body2/arm2/orb2` (générés par `tools/mkhud2.py`) dont les bleus sont remplacés par les rouges/bruns déjà présents dans PAL2 (indices 2→1, 3→7, 5/6→4, 9→8). Le cœur du HUD 2P est bien rose.

## Jalon 41 — fin du stage 6 (recherche PCE, `dumps/end6.script`, captures `dumps/end6/v*`)
- Rejeu autofire jusqu'à 150000 : le boss 6 (cerveau) meurt vers PCE ~126100. Suite relevée : fondu noir → panorama qui défile (île et arbre, puis château doré, puis ciel) avec cadre doré + portrait de la princesse et texte japonais (« ありがとう ツインビー… », 3 lignes qui changent) vers 126600–128500 ; ciel avec les 3 héros (rose, bleu, vert) qui volent, staff roll (PRODUCER K. KITAUE, PROGRAMER ASUTY.S IGA, SPECIAL THANKS…) ~129900–134000 ; étoiles ; mer + arc-en-ciel, 3 caractères jaunes, « © 1992 KONAMI / ALL RIGHTS RESERVED. » ~135000–140000 ; puis la partie recommence au stage 1 (score conservé, 3 vies).
- Durée totale ≈ 15000 frames (~4 min). Pas encore porté (texte japonais, panorama haut, portrait, staff roll à reconstituer).

## Jalon 42 — fin du stage 6 (portage de l'ending)
- `tools/mkend.py`/`endbg.py` (fonds a/b/c en tuiles + palettes animées), `tools/mkendspr.py` (flux de sprites rejoués, k-means++ pour garder les couleurs rares), `src/end.c` (lecture temps réel calée sur `vtimer`).
- Scène de dialogue : le scroll n'est PAS par ligne en Y mais un split horizontal (BXR 0 au-dessus de la ligne `splitRow`, 256 en dessous) → HSCROLL_LINE ; BYR 256 puis 250→180 à 0,25 px/frame. Entre 127480 et 127780 le bas défile plus vite (parallaxe) : non reproduit (MD n'a pas de VScroll par ligne).
- Priorité des sprites = ordre SAT via `SPR_setDepth` (sinon les yeux de la princesse étaient masqués).
- Couleurs : ids clés sur 2 étapes (126800 + médiane) et fusion pondérée par rareté (corrige le ciel violet). Connus : (le « sprite parasite » à ~128300 est le rayon de lumière de la PCE : sprites 0xeb affichés une frame sur deux = transparence par scintillement, fidèle ; une carte BG de plus à 128180), musique de la fin non portée. Retour au titre à la fin (la PCE relance le stage 1).

## Jalon 43 — compression des flux
- `tools/lzspack.py` (appelé par build_all.sh, idempotent) compresse en LZ4 par blocs de 2 Ko `bossN_flux` (N=3..6) et `ends_X_flux` ; `src/lzs.c/h` les décompresse au fil de l'eau (tampon 2,5 Ko, `LZS_ensure()` avant chaque frame, marge 512 o > frame max). Un seul flux ouvert à la fois. Décodeur vérifié en natif (boss3 complet, lectures irrégulières) et en émulateur (boss 3 affiché, fin identique).
- ROM : 4 063 232 → 2 883 584 octets. Reste non compressé : `e2..e6_pi/rf/rl/frames` (≈1,35 Mo, accès aléatoire par ennemi : il faudrait un cache de blocs) et boss 2.

## Jalon 44 — compression des ennemis rejoués
- `tools/rapack.py` (appelé par build_all.sh après mkenemiesN, idempotent) : `eN_pi` (trajectoires), `eN_rf`+`eN_rl` fusionnés en `eN_run` (planaire, 16 entrées par bloc) et `eN_frames` (1 image = 1 bloc de 64 o) en LZ4 par blocs de 64 o. Accès aléatoire : `RA_block()` (src/ra.c).
- Chaque ennemi garde son bloc courant décompressé (`pbuf`, `rbuf`, `efr` dans `raWork`, 6 Ko partagés avec le tampon `lzs` des boss/de la fin). Un cache LRU partagé a été essayé : trop lent (thrash, jeu à 60 % de vitesse) puis trop gourmand en RAM.
- Piège RAM : la limite pratique est ≈ 25 Ko de BSS (au-delà, le heap SGDK ne suffit plus : fond du stage 2 corrompu, `ILLEGAL INSTRUCTION` dans le dépaquetage LZ4W au stage 4). BSS actuel 23,9 Ko.
- `e2Off` initialisé à TRUE (l'ennemi n'est ni mis à jour ni dessiné avant ENEMY_init).
- ROM : 2 883 584 → 2 621 440 octets. Non compressé : boss 2 (≈100 Ko), tables de scroll des stages, tilesets/sprites (PNG rescomp).

## Jalon 45 — compression du boss 2
- `tools/b2pack.py` (appelé par build_all.sh, idempotent) fusionne les 6 tableaux (keyFrame/dStart/dIdx/dVal/scrollX/scrollY) en un flux séquentiel LZ4 (blocs de 256 o), lu par `boss2.c` (tampon propre de 256 o, `RA_unz` exporté de ra.c).
- RAM : `edep`/`esp` de end.c partagent désormais `bat` (boss2.c) — jamais utilisés en même temps. BSS ≈ 24,1 Ko. ROM 2,62 -> 2,49 Mo.

## Jalon 46 — choix 1 / 2 joueurs au titre
- Menu « 1 PLAYER / 2 PLAYERS » (haut/bas, l'entrée choisie clignote ; START valide ; START de la manette 2 = 2 joueurs direct). `TITLE_run()` renvoie TRUE pour 2 joueurs ; main.c appelle PLAYER_join/STAGE_join dès la 3e frame du stage. START manette 2 en jeu fonctionne toujours.

## Jalon 47 — bruitages supplémentaires
- Requêtes sonores PCE relevées par `sndlog` (stage 1 + boss 1, partie stage 2, bombes) : 18 = bombe (à chaque pression), 1D = mi-boss détruit, 1F = boss touché (35 tous les 4 coups), 34 = mort du boss (stages 3+), 40 = explosions de mort du boss (16, une toutes les 8 frames).
- Branchés côté MD : SFX_BOMB, SFX_BIG, SFX_BHIT/BHIT2 (bossn.c), SFX_BDEAD, SFX_BXPL (enemy.c). Non reliés : 22/23 (objets), 2B/2C/32/33/36/3B/1E, 21/24/2D, boss du stage 2 (pas de PV côté MD).

## Jalon 48 — intro PCE rejouée, logo Konami, bras des bombes
- Capture `dumps/intro` (trace SAT 1-1779, dumps toutes les 2 frames de 300 à 1178 puis toutes les frames jusqu'à 1744). Scène de vol (PCE 530-1745) = **rejeu** : sprites (étoiles, nuages, abeille qui tourne puis choc avec l'enseigne) via `tools/mkendspr.py` scène `i` (flux LZ4, 2 palettes MD lignes 2-3), fond = entrée 0 de la palette (jour → nuit → jour, `intro_bgt`), enseigne du titre en BG (`tools/mkintro2.py`, 2 palettes MD sans perte) avec défilement vertical BYR mesuré (`intro_byt`), plan 64x64 pendant l'intro. Ligne écran PCE = y + 3 (rgba), MD = y − 12. `INTRO_replay()` dans end.c ; la musique du titre démarre au début de la scène (comme la PCE à l'image 528), `titleMusicOn` évite le redémarrage dans TITLE_run.
- Logo Konami : trait bleu qui s'étire (8 px/image, images 12-54, y MD 10) avec éclat (3 images, `spr_intro_spark`), puis balayage à 2 px/image (54-160), logo tenu jusqu'à l'image 490 puis fondu au noir (490-526). L'ancienne scène simulée (nuages dessinés, étoiles) est supprimée. Pas de jingle de boot (id 0B) côté MD.
- Bombes : la main de la voie (gauche si voie 0) passe au motif PCE 465 (main avec bombe), 2 px plus bas, pendant 8 images (`PLAYER_bombArm`, `spr_arm` à 2 images, `extract/sprites_armb.npy`). Vérifié sur trace PCE (bb/tb).
- end.c : classes de sprites rejouées 8 → 12, `edep`/`esp` agrandis dans la zone partagée `bat`.

## Jalon 49 — intro Konami identique à la PCE (écart 0 px mesuré, images 12-230)
- tools/mkkonami.py : logo couleur = tuiles/BAT du BG PCE (4 palettes) + rejeu exact des palettes 170-249 (scintillement, marches blanches) ; trait de balayage (profils 3/5/7/8 lignes relevés, opaque dessous) ; éclat = sprite 48x24 par image (res/intro_spark.png).
- Pacing en temps réel (vtimer) : images logo 12→490, fondu 490-526.
- Jingle Konami : son PCE 0B (SFX_KONAMI, res/sfx/s11.wav) lancé à l'image 170 du logo, mesuré dans l'émulateur MD (début ≈ image 172).
- Jingle Konami refait en piste musique XGM2 (MUS_KONAMI = s11.vgm via tools/mkmusic.py 11, MAXF=140) au lieu d'un PCM 13 kHz (son sale).
- Jingle Konami : capture PSG propre au vrai boot (dumps/songs/gk11.psg, la g11 était polluée par la musique de jeu) ; conversion : START=170 MAXF=135 MB=2.5 PSGFILE=dumps/songs/gk11.psg python3 tools/mkmusic.py 11. Hauteurs vérifiées contre l'audio PCE (660/990/1050/1320 Hz).

## Jalon 50 — attract complet (démo stage 2 + carte), écrans titre/OPTION/scène, ROM compressée
- **Démo stage 2** : trajectoire du vaisseau relevée en RAM PCE (`$BA..$BD`, 3316 positions → `src/demo_path2.h`) et table de défilement dédiée (`demoScroll2[]`, 1658 o, 1101 px / 3316 images, 1 px toutes les 3 images) posée par `STAGE_setDemoScroll()` uniquement pendant l'attract ; le stage jouable garde `stage2_scroll`.
- **Attract en deux phases** (`titleOrAttract()`) : phase 0 = démo stage 1 + saynète garçon/TwinBee ; phase 1 = démo stage 2 + `CARD_run()` (carte princesse 128x128, mot révélé à 150, logo complet à 240, fin 370, musique coupée à 300) + `INTRO_run()`. START écourte chaque étape.
- **Écrans** : scène de la princesse en français, saynète (2 poses + mot/logo), titre (1P/2P/OPTION), OPTION pixel-perfect (sprites + palette `opt_*`), HUD de démo « 2P GAME OVER ».
- **Compression** : toutes les ressources en `BEST` (tilesets stage 1..6/hud/boss, maps stage 1..6, images, sprites) → 3 014 656 o (23 blocs) à **2 883 584 o (22 blocs)**, `ROM end $002BFFFF`, CRC32 **`385FAE1C`**.
- **Heap** : `STAGE_init()` libère l'ancienne carte avant `VDP_loadTileSet` et `STAGE_update()` la libère avant `BOSS2_start()` ; sans ça l'unpack du tileset (stage 2 : 23,5 Ko, boss 2 : 20,5 Ko, carte : 28,6 Ko) échoue dans ~40 Ko de tas et laisse l'ancien décor en VRAM (première ROM BEST corrompue).
- **Vérifié en headless** : cycle complet titre → démo 1 → saynète → titre → démo 2 → carte → Konami → vol → titre ; stage 2 jouable et boss 2 avec les ressources `BEST` ; carte comparée à la PCE 13420-13740 (mêmes étapes de révélation).
- **Limites assumées** : pas de boss dans la démo (la démo PCE s'arrête avant l'arène) ; les ennemis des deux démos sont bien présents (vérifié en headless).
- **Banc** : le libretro consomme ~9 % d'images de plus que la logique (frames dupliquées), sans incidence sur les durées du jeu.

## Jalon 51 — correctif heap : plus de crash au 2e écran-titre

- **Symptôme** : après un cycle complet (démo 2 + carte + Konami + titre), le titre suivant s'affichait sans logo ni « 1 PLAYER », puis plantait ~400 images plus tard (`ILLEGAL INSTRUCTION`, PC `$F90001`, pile `SR=$2304 PC=$4EF90001`).
- **Cause** : la carte du décor (`bg`) n'était jamais libérée à la fin de `attractDemo()`. Au titre suivant, le plus gros bloc libre du tas tombait à 9 490 o, insuffisant pour décompresser le tileset du logo (316 tuiles = 10 112 o) ; `VDP_loadTileSet` échouait, les tuiles du logo et de sprites manquaient, puis le moteur sprite sautait sur une adresse corrompue. La démo stage 2 laissait ~12 Ko occupés, la démo stage 1 ~17 Ko.
- **Correctif** : `STAGE_releaseMap()` (`stage.c`) libère `bg` ; appelée en fin de `attractDemo()` (`main.c`). Le tas revient à 25 184 o libres / 19 440 o plus gros bloc au titre (identique au boot).
- **Vérifié en headless** : deux cycles complets (titres ~16 500 et ~24 500), titres complets, démos stage 1 et 2 avec ennemis, plus de crash ; tas stable d'un cycle à l'autre (25 184 o libres, plus gros bloc 19 440 → 20 320 o).
- **ROM** : 2 883 584 o (22 blocs), CRC32 **`245531E0`**, MD5 `b3c0d4da38c8b59454ae45ba8b1f22fb`, checksum d'en-tête `$016F`, `ROM end $002BFFFF`.

## Jalon 52 — musiques refaites depuis les captures PSG PCE (12 pistes)

- **Source** : `pcedump psglog` (journal exact des écritures PSG + instantané 246 o/frame, 5 canaux PCE). Les 12 pistes ont été re-dumpées en jeu (`snd FF` puis `snd <id>` à la frame 3551, 6000 frames) : `analysis/out/pcedump/g<id>.psg`. Les anciens dumps `Codex\...\*.psg` (480 o/frame, sans journal) sont inutilisables.
- **Conversion** (`tools/mkmusic.py`) : canal 1/2/3/5 → FM (algo 7 additif, MUL = harmoniques dominantes de l'onde 32×5 bits, TL = enveloppe PCE par frame) ; canal 4 bruit → PSG bruit (horloge tone 3) ; canal 4 tonalité → PSG tone 1 ; canal 4 DDA → PCM (une écriture DAC `0xE0 seek` + `0x80` par écriture DDA, aux instants d'origine). Réglages : `HMAX=8`, `NH=4`, seuil d'harmonique 0,08, horloge de bruit plafonnée à `n2 >= 10` (~11 kHz) car le PSG MD est filtré à ~3,4 kHz.
- **Boucles** : période mesurée par similarité de signature (note + volume) — 83:1400, 91:3614, 98:3234, 103:2420, 108:1684, 113:2257, 123:2234, 128:3373, 135:1271, 140:1795 frames ; 145/163 (jingles) joués une fois. `P_FIX` dans `mkmusic.py` fige ces périodes.
- **Bug de débit PCM corrigé** : sans option, xgm2tool applique un « sample rate fix » qui, sur nos rafales DAC (écritures groupées dans la frame), **surestimait le débit de ~1,9×** (4420 Hz au lieu de 2317) → batterie jouée ~1,9× trop aiguë. Les lignes `XGM2` de `res/music.res` (musictest et prod) passent maintenant **`-dr`** ; débit mesuré 2317/2336 Hz, sinus de contrôle 300 Hz restitué à 299 Hz.
- **Calibration** : chaque piste est comparée à l'audio de référence PCE (`.s16` 44,1 kHz) sur 20 s (bandes 30 Hz–20 kHz, corrélation d'enveloppe) ; un `MB` (gain global) par piste compense l'écart de RMS. Résultat final : **−0,3 à +0,2 dB** sur les 12 pistes.
- **Écarts spectraux résiduels** (médiane) : 80–500 Hz +1 à +2,5 dB (corps PCM), 3–8 kHz −2 à −5 dB, 8–20 kHz −10 dB (filtre passe-bas du PSG MD, limite matérielle). Le 1,2–3 kHz reste à +4 dB sur le stage 1.
- **Taille** : `mus_all` = 513 280 o (12 pistes, PCM partagé). ROM de prod **3 407 872 o** (`ROM end $0033FFFF`), CRC32 **`A3F5FC3A`**, MD5 `97DEC2A88B92EC44C61690CD6F732175`.
- **Vérifié en headless** : boot → titre (musique) → démo stage 1 (musique stage 1) sur 60 s, pas de crash ; pic audio 9 887/32 767 (aucune saturation).
