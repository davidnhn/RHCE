# RHCE EX294 - Pack de scenarios Ansible commentes

Ce pack a ete construit a partir du PDF fourni.
Le document insiste surtout sur 6 idees fortes :

1. EX294 est un examen Ansible pratique, pas un examen Linux "a la main".
2. Les taches les plus rentables sont packages, services, firewall, users, stockage, fichiers, templates et securite.
3. L'etat final compte plus que la "jolie theorie" : il faut etre idempotent, reproductible et correct apres reboot.
4. `ansible-navigator`, l'inventaire statique et la verification rapide font partie du vrai workflow.
5. Les handlers, variables, facts, Vault, collections et error handling font la difference entre un playbook fragile et un playbook d'examen.
6. Les petites erreurs coutent cher : mauvais `hosts:`, oubli de `become`, firewall non persistant, template invalide, groupes remplaces par erreur, montage non persistant.

## Comment utiliser ce pack

Chaque scenario contient :

- un `inventory.yml`
- un `playbook.yml`
- les fichiers associes (`group_vars`, `templates`, etc.)
- un `verify.sh` pour penser "etat final" comme a l'examen
- un `README.md` tres court pour savoir ce que le scenario vous entraine a faire
- parfois un `validate.yml` pour une verification Ansible plus structuree
- parfois un `ansible.cfg` local pour illustrer un vrai workflow de projet

Si vous debutez avec Ansible, lisez d'abord :

- [SYNTAXE-ANSIBLE-DEBUTANT.md](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/SYNTAXE-ANSIBLE-DEBUTANT.md)
- [ADAPTER-LE-LAB.md](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/ADAPTER-LE-LAB.md)
- [LOGGING-ET-DEBUG.md](c:/Users/david/Documents/RHCE/rhce-ex294-scenarios/LOGGING-ET-DEBUG.md)

Workflow conseille :

```bash
cd rhce-ex294-scenarios/00-bootstrap-ex294
ansible-inventory -i inventory.yml --list -y
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout
```

Le deuxieme run doit etre stable ou presque stable.

## Collections utiles

Certains scenarios utilisent des collections tres classiques :

```bash
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general
```

## Scenarios inclus

### 00-bootstrap-ex294

Cas reel : prise en main d'un projet EX294 avec inventaire, `ansible.cfg`,
`ansible-navigator.yml`, doc offline et smoke test.

Themes EX294 :

- inventaire statique
- `ansible.cfg`
- `ansible-navigator`
- commandes ad hoc
- smoke test et verification rapide

### 01-service-web

Cas reel : deploiement d'un service web interne.

Themes EX294 :

- `dnf`
- `template`
- `systemd_service`
- `firewalld`
- `handlers`
- verification et idempotence

### 02-users-ssh-sudo

Cas reel : creation de comptes ops avec acces SSH et droits sudo.

Themes EX294 :

- `group`
- `user`
- `authorized_key`
- boucles
- variables
- gestion propre des groupes

### 03-storage-lvm

Cas reel : mise a disposition d'un espace applicatif persistant.

Themes EX294 :

- LVM
- filesystem
- `mount`
- persistance
- verification RHCSA

### 04-facts-templating

Cas reel : generation d'un fichier de configuration ou d'un rapport a partir des facts.

Themes EX294 :

- `gather_facts`
- `set_fact`
- `template`
- conditionnels
- gestion de fallback

### 05-robustesse-ssh

Cas reel : durcissement SSH avec verification et rollback en cas d'echec.

Themes EX294 :

- `block`
- `rescue`
- `always`
- `failed_when`
- `changed_when`
- diagnostic rapide

### 06-vault-secret

Cas reel : deploiement d'un secret applicatif sans le laisser en clair dans le playbook.

Themes EX294 :

- `ansible-vault`
- `vars_files`
- `template`
- `no_log`
- permissions sur un fichier sensible

### 07-role-based-deploy

Cas reel : deploiement industrialise avec `site.yml`, roles, `group_vars`,
`host_vars`, handlers et collections.

Themes EX294 :

- roles
- `site.yml`
- `requirements.yml`
- `group_vars` et `host_vars`
- `tags`

### 08-selinux-firewall-content

Cas reel : service web interne avec contenu gere, durcissement HTTP,
firewall et contexte SELinux.

Themes EX294 :

- SELinux
- `lineinfile`
- `blockinfile`
- `firewalld`
- handlers et verification

### 09-scheduling-archives

Cas reel : planification d'une tache d'archivage et gestion d'un script
de sauvegarde.

Themes EX294 :

- `cron`
- scripts geres par Ansible
- archives
- variables et boucles
- verification systeme

### 10-mock-exam

Cas reel : mini faux examen multi-objectifs couvrant l'essentiel de l'EX294.

Themes EX294 :

- workflow complet
- roles
- users
- stockage
- firewall
- facts
- Vault
- scheduling
- error handling

## Methode de travail inspiree du PDF

Quand vous vous entrainez, gardez toujours cette routine :

1. Verifier l'inventaire avant de lancer quoi que ce soit.
2. Tester d'abord sur un hote ou un petit groupe.
3. Utiliser les modules avant `command` ou `shell`.
4. Rejouer le playbook.
5. Verifier l'etat reel avec les commandes RHEL.
6. Imaginer le reboot et la persistance.

## Extensions utiles pour aller plus loin

Une fois ces scenarios maitrises, vous pouvez les faire evoluer vers :

- un role Ansible au lieu d'un simple playbook
- des variables dans `group_vars/` et `host_vars/`
- un fichier Vault pour les secrets
- des `tags`
- un `site.yml` qui orchestre plusieurs scenarios a la fois
