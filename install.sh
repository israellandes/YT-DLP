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
