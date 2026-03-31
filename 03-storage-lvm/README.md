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

Ce scenario peut fonctionner de deux facons :

- `storage_device: auto` pour tenter une detection simple d'un disque libre
- `storage_device: /dev/sdX` si vous preferez fixer explicitement le device

Il montre aussi une version structuree en role reutilisable.
