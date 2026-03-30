# Scenario 10 - Mock exam EX294

## Objectif

Ce dossier simule un mini faux examen multi-objectifs.
Tu as ici :

- un sujet d'entrainement
- une structure de projet proche d'un rendu EX294
- une implementation de reference dans `site.yml`

## Sujet propose

Realiser les taches suivantes :

1. Verifier l'inventaire statique et la connectivite.
2. Utiliser `ansible.cfg` et `ansible-navigator.yml` fournis.
3. Appliquer un role baseline sur tous les hotes.
4. Deployer un service web gere par role sur le groupe `web`.
5. Ouvrir le firewall pour ce service.
6. Creer des comptes ops sur le groupe `ops`.
7. Installer leurs cles SSH depuis les fichiers `keys/`.
8. Configurer un sudo sans mot de passe pour le groupe ops.
9. Creer un espace de stockage LVM sur le groupe `storage`.
10. Generer un rapport base sur les facts sur le groupe `report`.
11. Planifier une sauvegarde sur le groupe `backup`.
12. Deployer un fichier applicatif base sur Vault sur le groupe `secure`.
13. Durcir SSH sur le groupe `secure` avec validation et rollback.
14. Rejouer jusqu'a stabilite.
15. Verifier l'etat final avec les commandes systeme.

## Execution

```bash
cp vars/mock-vault.yml.example vars/mock-vault.yml
ansible-vault encrypt vars/mock-vault.yml
ansible-galaxy collection install -r requirements.yml
ansible-inventory -i inventory.yml --list -y
ansible-navigator run site.yml -i inventory.yml --mode stdout --ask-vault-pass
```

## Ce que ce mock travaille

- enchainement de plusieurs themes sans perdre la lisibilite
- discipline de verification
- relecture de l'inventaire et des variables avant execution
