# Scenario 02 - Comptes, SSH et sudo

## Objectif

Creer des comptes ops sur plusieurs hotes avec :

- groupes
- utilisateurs
- cles SSH
- repertoire `.ssh`
- sudo via `/etc/sudoers.d`

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
./verify.sh
```

## Points pedagogiques

- bien utiliser `append: true`
- modeliser les donnees dans une liste de dictionnaires
- verifier l'etat reel avec `id`, `getent`, `sudo -l`
