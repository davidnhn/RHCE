# Scenario 09 - Scheduling and archives

## Objectif

Mettre en place une sauvegarde planifiee d'un repertoire applicatif :

- script gere par Ansible
- fichier de cron dedie
- repertoire de sauvegarde
- archivage immediat optionnel

## Execution

```bash
ansible-galaxy collection install -r requirements.yml
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
```

## Point important

L'archivage immediat via module est volontairement optionnel ici.
Par defaut il est desactive pour garder des re-runs plus stables.
