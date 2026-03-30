# Scenario 05 - Robustesse, validation et rollback

## Objectif

Durcir SSH sans vous enfermer dehors.

Le scenario montre comment :

- deployer un fichier de conf gere
- valider la syntaxe
- redemarrer le service
- verifier la disponibilite
- rollback en cas d'echec

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
./verify.sh
```

## Idee cle

Un bon playbook RHCE ne doit pas seulement "changer des fichiers".
Il doit converger vers un etat final fiable et diagnostiquer proprement.
