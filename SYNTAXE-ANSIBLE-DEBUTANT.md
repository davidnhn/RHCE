# Syntaxe Ansible pour debuter

Ce document sert d'aide-memoire rapide quand vous lisez les scenarios de ce dossier.
L'objectif est de comprendre la logique Ansible, pas seulement de recopier.

## 1. Comment Ansible "pense"

Ansible decrit un etat cible.
On ne lui dit pas seulement "execute cette commande", on lui dit plutot :

- ce paquet doit etre installe
- ce service doit etre demarre
- ce fichier doit exister avec tel contenu
- ce point de montage doit etre present

Le module Ansible compare l'etat actuel et l'etat voulu.
Si tout est deja correct, il ne change rien.
C'est cela l'idempotence.

## 2. Structure minimale d'un playbook

```yaml
---
- name: Example play
  hosts: web
  become: true

  tasks:
    - name: Install httpd
      ansible.builtin.dnf:
        name: httpd
        state: present
```

Lecture ligne par ligne :

- `---` : debut du document YAML
- `- name: Example play` : debut d'un play
- `hosts: web` : ce play s'applique au groupe `web` de l'inventaire
- `become: true` : execute les taches avec elevation de privilege
- `tasks:` : liste des actions a executer
- `- name: Install httpd` : une tache
- `ansible.builtin.dnf:` : module appele
- `name: httpd` : paquet vise
- `state: present` : etat desire

## 3. Inventaire : comment Ansible sait ou agir

Exemple :

```yaml
all:
  children:
    web:
      hosts:
        web1.example.com:
        web2.example.com:
```

Idee importante :

- `all` = racine de l'inventaire
- `children` = groupes
- `web` = nom du groupe
- `hosts` = machines appartenant a ce groupe

Si un playbook dit `hosts: web`, il ciblera `web1.example.com` et `web2.example.com`.

## 4. Module : la vraie unite de travail

Une tache Ansible appelle generalement un module.

Exemples courants :

- `ansible.builtin.dnf` : paquets
- `ansible.builtin.systemd_service` : services systemd
- `ansible.builtin.file` : permissions, repertoires, liens, suppression
- `ansible.builtin.copy` : copier du contenu brut
- `ansible.builtin.template` : copier un fichier avec variables Jinja2
- `ansible.posix.firewalld` : firewall
- `ansible.builtin.user` : utilisateurs
- `ansible.builtin.group` : groupes
- `ansible.posix.mount` : montage et persistance

## 5. Variables

Exemple :

```yaml
vars:
  app_service_name: httpd
```

Puis reutilisation :

```yaml
name: "{{ app_service_name }}"
```

Regle importante :

- `{{ ... }}` = interpolation Jinja2
- on s'en sert pour inserer une variable dans une valeur

## 6. Boucles

Exemple :

```yaml
- name: Create users
  ansible.builtin.user:
    name: "{{ item.name }}"
    state: present
  loop: "{{ ops_users }}"
```

Ici :

- `loop` parcourt une liste
- `item` represente l'element courant
- si `ops_users` contient plusieurs dictionnaires, la tache sera repetee pour chacun

## 7. Handlers

Un handler est une tache speciale executee seulement si une autre tache le demande avec `notify`.

Exemple :

```yaml
- name: Deploy config
  ansible.builtin.template:
    src: app.conf.j2
    dest: /etc/app.conf
  notify: restart app
```

Puis :

```yaml
handlers:
  - name: restart app
    ansible.builtin.systemd_service:
      name: app
      state: restarted
```

Utilite :

- eviter de redemarrer un service a chaque run
- ne redemarrer que si la configuration a change

## 8. `copy` vs `template`

Utilisez `copy` si vous envoyez du contenu fixe.

Utilisez `template` si le fichier contient des variables comme :

```jinja2
Host: {{ inventory_hostname }}
```

Regle memoire :

- `copy` = pas d'interpolation
- `template` = interpolation Jinja2

## 9. `register`, `changed_when`, `failed_when`

Exemple :

```yaml
- name: Validate sshd configuration
  ansible.builtin.command: /usr/sbin/sshd -t
  register: sshd_validation
  changed_when: false
  failed_when: sshd_validation.rc != 0
```

Lecture :

- `register` stocke le resultat de la commande
- `changed_when: false` dit "cette verification ne modifie rien"
- `failed_when: ...` definit explicitement la condition d'echec

Tres utile pour le troubleshooting en RHCE.

## 10. `block`, `rescue`, `always`

Exemple mental :

- `block` = ce que je tente
- `rescue` = ce que je fais si ca echoue
- `always` = ce que je fais quoi qu'il arrive

C'est l'equivalent d'un schema "try / catch / finally".

## 11. `become: true`

Beaucoup de taches RHCE modifient des fichiers systeme, des services ou des comptes.
Sans `become: true`, vous aurez souvent des erreurs de permission.

Pensez-le comme :

- "lancer cette partie avec sudo"

## 12. Pourquoi on evite `shell` et `command` si un module existe

Exemple moins bon :

```yaml
- name: Install httpd badly
  ansible.builtin.command: dnf install -y httpd
```

Exemple meilleur :

```yaml
- name: Install httpd properly
  ansible.builtin.dnf:
    name: httpd
    state: present
```

Pourquoi le module est meilleur :

- plus lisible
- plus idempotent
- plus simple a verifier
- plus proche de la logique de l'examen

## 13. Methode de lecture d'un playbook

Quand vous ouvrez un playbook, posez-vous toujours ces questions :

1. Quels hotes sont cibles ?
2. Est-ce qu'il faut les privileges root ?
3. Quelles variables pilotent le comportement ?
4. Quels modules sont utilises ?
5. Qu'est-ce qui est verifie ?
6. Qu'est-ce qui doit persister apres reboot ?

## 14. Reflexe RHCE a memoriser

Chaque scenario doit etre pense ainsi :

1. Je verifie l'inventaire
2. Je lance le playbook
3. Je relance le playbook
4. Je verifie l'etat final sur l'hote

## 15. Lecture rapide des symboles YAML utiles

- `:` separe une cle et une valeur
- `-` introduit un element de liste
- l'indentation est obligatoire
- 2 espaces par niveau est une bonne habitude

Exemple :

```yaml
tasks:
  - name: First task
    ansible.builtin.file:
      path: /tmp/demo
      state: directory
```

Si l'indentation est mauvaise, le playbook casse.

## 16. Ce qu'il faut retenir en priorite absolue

Pour bien debuter en EX294, memorisez d'abord :

- `inventory`
- `hosts`
- `become`
- `tasks`
- modules de base
- variables `{{ ... }}`
- `loop`
- `template`
- `handlers`
- verification et idempotence
