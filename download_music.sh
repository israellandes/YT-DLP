#!/bin/bash

# Set the music directory
MUSIC_DIR="$HOME/Music/Downloads"

# Create the music directory if it doesn't exist
mkdir -p "$MUSIC_DIR"

# Function to download audio
download_audio() {
    local url="$1"
    yt-dlp -v -x --audio-format mp3 --audio-quality 0 \
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
    yt-dlp -v -x --audio-format mp3 --audio-quality 0 \
        -o "$MUSIC_DIR/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" \
        --yes-playlist \
        --add-metadata \
        --embed-thumbnail \
        --ignore-errors \
        --no-overwrites \
        "$url"
}

# Check if a file path is provided
if [ $# -eq 0 ]; then
    echo "Please provide a file path containing the links."
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
done < "$1"

echo "All downloads completed!"