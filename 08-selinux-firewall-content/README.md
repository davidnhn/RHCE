# Scenario 08 - SELinux, firewall and content editing

## Objectif

Deployer un service web interne tout en travaillant des sujets souvent oublies
mais rentables a l'examen :

- `lineinfile`
- `blockinfile`
- contexte SELinux
- `seboolean`
- verification finale cote systeme

## Execution

```bash
ansible-galaxy collection install -r requirements.yml
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
```

## Ce que ce scenario vous apprend

- SELinux n'est pas "hors sujet" pour EX294
- on peut modifier proprement une conf sans tout reecrire
- firewall, service et contenu doivent etre coherents ensemble
