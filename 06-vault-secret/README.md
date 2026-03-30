# Scenario 06 - Vault et secret applicatif

## Objectif

Deployer un fichier applicatif contenant un secret sans l'ecrire en clair dans le playbook.

## Preparation

1. Copier `vars/vault.yml.example` vers `vars/vault.yml`
2. Chiffrer le fichier :

```bash
cp vars/vault.yml.example vars/vault.yml
ansible-vault encrypt vars/vault.yml
```

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout --ask-vault-pass
./verify.sh
```

## Ce que ce scenario vous apprend

- ne pas mettre un mot de passe en dur dans un playbook
- utiliser `vars_files`
- masquer les sorties sensibles avec `no_log: true`
