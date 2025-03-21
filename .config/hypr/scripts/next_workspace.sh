#!/bin/bash

# Define variables
curr_workspace=$(hyprctl activeworkspace -j | jq '.id' | tr -d '\n')
MAX_WORKSPACE=10

next_workspace() {
    if [ "$curr_workspace" -eq "$MAX_WORKSPACE" ]; then 
        exit 1
    else 
        hyprctl dispatch "workspace r+1"
    fi
}

move_to_workspace() {
    if [ "$curr_workspace" -eq "$MAX_WORKSPACE" ]; then 
        exit 1
    else 
        hyprctl dispatch "movetoworkspace r+1"
    fi
}

while getopts "nm" opt; do
  case "$opt" in
    n) next_workspace ;;
    m) move_to_workspace ;;
    \?) echo "Unknown option"; exit 1 ;;
  esac
done

