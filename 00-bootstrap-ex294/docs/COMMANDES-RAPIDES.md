# Commandes rapides a memoriser

## Verifier l'inventaire

```bash
ansible-inventory -i inventory.yml --list -y
```

## Tester la connectivite

```bash
ansible bootstrap -i inventory.yml -m ansible.builtin.ping
```

## Tester avec become

```bash
ansible bootstrap -i inventory.yml -m ansible.builtin.command -a "id" -b
```

## Lire la doc d'un module

```bash
ansible-doc ansible.builtin.copy
ansible-navigator doc ansible.builtin.copy
```

## Lancer le smoke test

```bash
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout
```

## Iterer vite sur un seul hote

```bash
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout --limit node1
```
