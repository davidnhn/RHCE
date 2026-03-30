# Scenario 03 - Stockage LVM et montage persistant

## Objectif

Fournir un espace applicatif persistant :

- disque ou partition ajoutee au volume group
- logical volume
- filesystem
- point de montage
- entree persistante

## Execution

```bash
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbook.yml -i inventory.yml --mode stdout
./verify.sh
```

## Attention

Ce scenario suppose qu'un disque de donnees libre existe deja.
Adaptez `storage_device` avant execution.
