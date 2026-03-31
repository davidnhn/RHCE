# Logging et debug Ansible

Le RHCE ne demande pas seulement d'ecrire un playbook correct.
Il faut aussi diagnostiquer vite quand quelque chose ne marche pas.

## 1. Verifier l'inventaire d'abord

```bash
ansible-inventory -i inventory.yml --list -y
```

## 2. Limiter a un seul hote

```bash
ansible-navigator run playbook.yml -i inventory.yml --mode stdout --limit node1
```

## 3. Augmenter la verbosite

```bash
ansible-navigator run playbook.yml -i inventory.yml --mode stdout -vv
ansible-playbook -i inventory.yml playbook.yml -vv
```

## 4. Utiliser `debug`

Le module `debug` aide a voir rapidement :

- une variable
- un `register`
- un choix conditionnel

Exemple :

```yaml
- name: Show the selected IP
  ansible.builtin.debug:
    var: report_primary_ip
```

## 5. Utiliser `register`

Exemple :

```yaml
- name: Validate sshd
  ansible.builtin.command: /usr/sbin/sshd -t
  register: sshd_validation
  changed_when: false
```

Puis :

```yaml
- name: Show validation output
  ansible.builtin.debug:
    var: sshd_validation
```

## 6. Consulter les logs Ansible

Plusieurs scenarios structurels ecrivent dans :

- `logs/ansible.log`

Commande utile :

```bash
tail -f logs/ansible.log
```

## 7. Reflexe examen

Quand un scenario echoue :

1. verifier le groupe cible
2. verifier `become`
3. lire le message d'erreur exact
4. regarder les variables clefs
5. relancer sur un seul hote
6. valider l'etat systeme avec `systemctl`, `firewall-cmd`, `lsblk`, `mount`, `getenforce`
