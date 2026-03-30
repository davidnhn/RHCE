# Scenario 07 - Role based deploy

## Objectif

Passer d'un playbook simple a un projet mieux structure :

- `site.yml`
- roles reutilisables
- `group_vars` et `host_vars`
- `requirements.yml`
- handlers et tags

## Execution

```bash
ansible-galaxy collection install -r requirements.yml
ansible-inventory -i inventory.yml --list -y
ansible-navigator run site.yml -i inventory.yml --mode stdout
```

## Ce que ce scenario vous apprend

- quand un role devient preferable a un gros playbook unique
- comment la precedence de variables marche entre `defaults`, `group_vars` et `host_vars`
- comment preparer un projet plus proche d'un vrai depot d'examen
