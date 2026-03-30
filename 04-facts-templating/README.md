# Scenario 04 - Facts et templating

## Objectif

Generer un fichier a partir des facts Ansible avec fallback propre.

Ce scenario est volontairement simple sur le fond, mais tres utile pour :

- pratiquer `gather_facts`
- choisir les bons facts
- utiliser `set_fact`
- construire un template robuste

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
./verify.sh
```
