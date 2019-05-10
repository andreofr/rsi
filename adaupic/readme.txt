les playbooks sont lancés avec la commande suivante : 

ansible-playbook -v -i "$INVENTORY" --extra-vars "version=$VERSION" --extra-vars "@$VARIABLES.yml" --extra-vars "@ansible/nexus.yml" "$PLAYBOOK.yml"

avec :
- $INVENTORY : le fichier inventory
- $VERSION   : la version les playbooks à utiliser (ainsi que la version à déployer)
- $VARIABLES : les variables de l'inventory (c'est comme le group_vars)
- $PLAYBOOK  : le nom du playbook à lancer