# twinbee-md

Portage de *Detana!! TwinBee* (PC Engine) vers Mega Drive avec SGDK, par réécriture du moteur en C vérifiée contre des traces RAM de la version PCE.

- `NOTES.md` : journal des jalons, chaîne de fabrication, écarts connus.
- `md/twinbee/src` : code C (SGDK) et données générées ; `md/twinbee/res` : ressources (images dérivées du jeu original).
- `tools/` : extraction des traces PCE, recollage des décors, palettes, génération des données, bancs de test (mdshot, pcedump).
- `scripts/` : scripts de capture/test.

La ROM d'origine n'est pas incluse. Les ressources et données générées sont dérivées du jeu d'origine : à ne pas publier si le dépôt est public.
