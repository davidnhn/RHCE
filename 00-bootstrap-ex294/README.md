# Scenario 00 - Bootstrap EX294

## Objectif

Ce scenario reproduit le tout debut d'un vrai sujet EX294 :

- lire un inventaire statique propre
- verifier que `ansible.cfg` pointe au bon endroit
- utiliser `ansible-navigator`
- faire un test ad hoc rapide
- lancer un premier playbook "smoke test"

## Fichiers importants

- `ansible.cfg`
- `ansible-navigator.yml`
- `inventory.yml`
- `group_vars/all.yml`
- `playbooks/smoke.yml`
- `docs/COMMANDES-RAPIDES.md`

## Execution conseillee

```bash
ansible-inventory -i inventory.yml --list -y
ansible bootstrap -i inventory.yml -m ansible.builtin.ping
ansible-navigator doc ansible.builtin.copy
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout
```

## Ce que ce scenario vous apprend

- toujours verifier ce qu'Ansible "voit"
- separer le probleme inventaire / connexion / playbook
- demarrer par un playbook minimal avant les gros scenarios
