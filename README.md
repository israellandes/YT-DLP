# yt-dlp Installation and Usage Guide

This guide will walk you through installing yt-dlp and using it to download audio from YouTube and SoundCloud.

## Installation

1. Save the following script as `install.sh`:

```bash
#!/bin/bash

echo "Installing yt-dlp and ffmpeg..."

# Update package list
sudo apt-get update

# Install ffmpeg
sudo apt-get install -y ffmpeg

# Install python3-venv if not already installed
sudo apt-get install -y python3-venv

# Create a virtual environment
python3 -m venv $HOME/yt-dlp-env

# Activate the virtual environment
source $HOME/yt-dlp-env/bin/activate

# Install yt-dlp in the virtual environment
pip install --upgrade yt-dlp

# Deactivate the virtual environment
deactivate

# Create a wrapper script to run yt-dlp
echo '#!/bin/bash
source $HOME/yt-dlp-env/bin/activate
$HOME/yt-dlp-env/bin/yt-dlp "$@"
deactivate' > $HOME/yt-dlp-wrapper.sh

# Make the wrapper script executable
chmod +x $HOME/yt-dlp-wrapper.sh

echo "Installation complete!"
echo "To use yt-dlp, run: $HOME/yt-dlp-wrapper.sh [options] [URL]"
echo "You may want to add an alias to your .bashrc file:"
echo "echo \"alias yt-dlp='$HOME/yt-dlp-wrapper.sh'\" >> $HOME/.bashrc"
```

2. Make the script executable:
   ```
   chmod +x install.sh
   ```

3. Run the installation script:
   ```
   ./install.sh
   ```

4. (Optional) Add an alias to your `.bashrc` file:
   ```
   echo "alias yt-dlp='$HOME/yt-dlp-wrapper.sh'" >> $HOME/.bashrc
   ```
   Then, either restart your terminal or run `source ~/.bashrc` for the changes to take effect.

## Usage

### Direct Usage

You can use yt-dlp directly by running:

```
$HOME/yt-dlp-wrapper.sh [options] [URL]
```

Or, if you've set up the alias:

```
yt-dlp [options] [URL]
```

### Batch Download Script

1. Save the following script as `download_music.sh`:

```bash
#!/bin/bash

# Set the music directory
MUSIC_DIR="$HOME/Music/Downloads"

# Set the path to the yt-dlp wrapper script
YT_DLP="$HOME/yt-dlp-wrapper.sh"

# Create the music directory if it doesn't exist
mkdir -p "$MUSIC_DIR"

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

# Check if a file path is provided
if [ $# -eq 0 ]; then
    echo "Please provide a file path containing the links."
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Read the file line by line
while IFS= read -r link || [ -n "$link" ]; do
    # Skip empty lines
    [ -z "$link" ] && continue
    
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
```

2. Make the script executable:
   ```
   chmod +x download_music.sh
   ```

3. Create a text file (e.g., `links.txt`) with your YouTube and SoundCloud links, one per line.

4. Run the script:
   ```
   ./download_music.sh links.txt
   ```

This will process each link in the file and download the audio to the specified music directory (by default, `$HOME/Music/Downloads`).

## Notes

- The download script handles both individual tracks and playlists.
- It uses verbose mode for detailed output.
- It embeds thumbnails and metadata.
- It avoids overwriting existing files to handle duplicates.
- Audio is downloaded in MP3 format with the best available quality.

Remember to respect copyright laws and terms of service when downloading content.
