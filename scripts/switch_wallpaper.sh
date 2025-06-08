#!/bin/bash

# Directory containing the wallpapers
WALLPAPER_DIR="$HOME/Wallpapers/"

# Find all image files in the wallpaper directory (jpg, jpeg, png, gif)
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))

# Get the current wallpaper path by querying swww
# Extract the image path, get the first result, and resolve to absolute path
current=$(swww query | grep 'currently displaying:' | awk -F'image: ' '{print $2}' | head -n1 | xargs realpath)

# Initialize current index as -1
current_index=-1

# Loop through all wallpapers to find the index of the current one
for i in "${!wallpapers[@]}"; do
    wallpath=$(realpath "${wallpapers[$i]}")
    if [[ "$wallpath" == "$current" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next index (wraps around to 0 if at end of array)
next_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
selected_wall="${wallpapers[$next_index]}"

# Array of possible transition types
transitions_types=('center' 'grow' 'wipe' 'random')
# Select a random transition type
selected_type="${transitions_types[$RANDOM % ${#transitions_types[@]}]}"

# Array of possible transition positions
transitions_pos=('center' 'top' 'left' 'right' 'bottom' 'top-left' 'top-right' 'bottom-left' 'bottom-right')
# Select a random transition position
selected_pos="${transitions_pos[$RANDOM % ${#transitions_pos[@]}]}"

# Change wallpaper using swww with selected image and random transition settings
swww img "$selected_wall" --transition-type "$selected_type" --transition-pos "$selected_pos"

