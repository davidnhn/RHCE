# Scenario 01 - Service web complet

## Objectif

Deployer un service web interne sur un groupe `app` :

- installation des paquets
- deploiement d'un fichier de configuration template
- deploiement d'une page d'accueil
- activation et demarrage du service
- ouverture du firewall
- verification de l'etat final

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
ansible-navigator run validate.yml -i inventory.yml --mode stdout
./verify.sh localhost
```

## Ce que ce scenario vous apprend

- penser "package -> config -> service -> firewall -> verification"
- utiliser un handler seulement quand il est necessaire
- eviter le piege du firewall non persistant
- voir une version structuree avec `role`, validation `httpd -t` et logs Ansible
