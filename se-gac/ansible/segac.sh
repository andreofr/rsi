
if [ "$#" -lt "3" ]; then
  echo "Ce script nécessite les trois paramètres : composant, version, environnement"
  echo "Un troisième paramètre (inventaire) est facultatif, la valeur par défaut sera utilisé s'il n'est pas renseigné."
  exit 1
fi

COMPOSANT=$1
XYZLivraison=$2
ENV=$3
INVENTORY=$4

# La version est de la form X.Y.Z-LIVRAISON
# on split la version en deux : X.Y.Z et LIVRAISON 
arrayXYZLivraison=(${XYZLivraison//-/ })

if [ "${#arrayXYZLivraison[@]}" -ne "2" ]; then
  echo "La version est mal formée."
  echo "Le format attendu est X.Y.Z-LIVRAISON"
  exit 1
fi

VERSION=${arrayXYZLivraison[0]}
LIVRAISON=${arrayXYZLivraison[1]}

# Si l'inventory n'est pas fourni, on utilise celui par defaut
if [ -z "$INVENTORY" ]; then
    INVENTORY="hosts/hosts-$ENV"
    echo "[INFO] Using default inventory : $INVENTORY"
fi

echo "[INFO] [$0] with parameters : version = $XYZLivraison - environment = $ENV - inventory = $INVENTORY"
echo "[RUN] ansible-playbook -v -i "$INVENTORY" --extra-vars "version=$XYZLivraison" --extra-vars "@variables/variables-$ENV.yml" --extra-vars "@../ansible/nexus.yml" $VERSION/$COMPOSANT.yml"

ANSIBLE_RETRY_FILES_ENABLED=False \
ansible-playbook -v -i "$INVENTORY" --extra-vars "version=$XYZLivraison" --extra-vars "@variables/variables-$ENV.yml" --extra-vars "@../ansible/nexus.yml" $VERSION/$COMPOSANT.yml
