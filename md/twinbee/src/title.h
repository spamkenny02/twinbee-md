#ifndef TITLE_H
#define TITLE_H
bool TITLE_run(void);       // écran titre : menu 1/2 joueurs (haut/bas), START valide ; retourne TRUE pour 2 joueurs (START manette 2 = 2 joueurs direct)
extern bool titleWantsAttract;  // TRUE : l'écran titre s'est fermé tout seul (inactivité) -> lancer la démo d'attract
#endif
