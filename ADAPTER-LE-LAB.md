# Adapter le pack a votre lab

Ce guide centralise les ajustements les plus frequents avant d'executer les scenarios.
L'objectif est de reduire les erreurs classiques en preparation RHCE.

## 1. Inventaires

Dans chaque `inventory.yml`, adaptez au minimum :

- `ansible_host` si vous utilisez de vraies adresses IP
- les noms d'hotes si vous avez vos propres VMs
- le groupe cible si votre lab a une autre nomenclature

Commande de verification :

```bash
ansible-inventory -i inventory.yml --list -y
```

## 2. Utilisateur distant et elevation

Les scenarios structurels utilisent souvent `student` comme exemple.
Si votre lab utilise un autre compte, adaptez :

- `ansible_user`
- `remote_user` dans `ansible.cfg` quand present
- la configuration sudo si necessaire

## 3. Disques pour le stockage

Le scenario 03 accepte :

- `storage_device: auto`
- ou un device explicite comme `/dev/sdb`

Si l'auto-detection ne convient pas a votre lab, fixez le device dans :

- [group_vars/storage.yml](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/03-storage-lvm/group_vars/storage.yml)

## 4. Vault

Les scenarios Vault utilisent des fichiers d'exemple a copier :

- [06-vault-secret/vars/vault.yml.example](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/06-vault-secret/vars/vault.yml.example)
- [10-mock-exam/vars/mock-vault.yml.example](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/10-mock-exam/vars/mock-vault.yml.example)

Workflow :

```bash
cp vars/vault.yml.example vars/vault.yml
ansible-vault encrypt vars/vault.yml
```

## 5. Cles SSH des utilisateurs

Le mock exam et certains scenarios supposent des cles deja disponibles.
Adaptez si besoin :

- les variables `ssh_key` dans les scenarios simples
- les fichiers `keys/*.pub` dans le mock exam

## 6. Logs Ansible

Les scenarios structurels utilisent maintenant :

- `log_path = logs/ansible.log`

Pensez a consulter les logs quand un run echoue :

```bash
tail -f logs/ansible.log
```

## 7. Collections a installer

Selon le scenario, installez les collections avant execution :

```bash
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general
```

## 8. Routine de verification conseillee

Avant de considerer un scenario comme "reussi" :

1. Verifier l'inventaire
2. Lancer le playbook
3. Rejouer le playbook
4. Verifier l'etat systeme reel
5. Imaginer ou tester le reboot
