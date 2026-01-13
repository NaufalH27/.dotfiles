workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')

floatings=$(
  hyprctl clients -j | jq \
    --argjson wid "$workspace_id" \
    '[.[] | select(.workspace.id == $wid and .floating)]'
)


echo "$floatings" | jq -c '.[]' | while read -r client; do
  echo "Client JSON:"
  echo "$client"
done
