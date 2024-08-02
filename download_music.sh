#!/bin/bash

# Set the default music directory
MUSIC_DIR="$HOME/YT-DLP/Music"

# Set the path to the yt-dlp wrapper script
YT_DLP="$HOME/yt-dlp-env/bin/yt-dlp"

# Create the music directory if it doesn't exist
mkdir -p "$MUSIC_DIR"

# Activate the virtual environment
source $HOME/yt-dlp-env/bin/activate

# Function to download audio
download_audio() {
    local url="$1"
    $YT_DLP -v -x --audio-format mp3 --audio-quality 0 \
        -o "$MUSIC_DIR/%(title)s.%(ext)s" \
        --no-playlist \
        --add-metadata \
        --embed-thumbnail \
        --ignore-errors \
        --no-overwrites \
        "$url"
}

# Function to download playlist
download_playlist() {
    local url="$1"
    $YT_DLP -v -x --audio-format mp3 --audio-quality 0 \
        -o "$MUSIC_DIR/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" \
        --yes-playlist \
        --add-metadata \
        --embed-thumbnail \
        --ignore-errors \
        --no-overwrites \
        "$url"
}

# Set default links file
DEFAULT_LINKS_FILE="./links.txt"

# Check if a file path is provided as an argument
LINKS_FILE=${1:-$DEFAULT_LINKS_FILE}

# Check if the file exists
if [ ! -f "$LINKS_FILE" ]; then
    echo "File not found: $LINKS_FILE"
    deactivate
    exit 1
fi

# Read the file line by line
while IFS= read -r link
do
    echo "Processing link: $link"
    
    # Check if the link is a playlist
    if [[ $link == *"playlist"* ]] || [[ $link == *"/sets/"* ]]; then
        echo "Detected playlist. Downloading all songs..."
        download_playlist "$link"
    else
        echo "Detected single track. Downloading..."
        download_audio "$link"
    fi
    
    echo "Finished processing: $link"
    echo "------------------------"
done < "$LINKS_FILE"

echo "All downloads completed!"

# Deactivate the virtual environment
deactivate

