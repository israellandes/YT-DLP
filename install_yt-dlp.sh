#!/bin/bash

echo "Installing yt-dlp and ffmpeg..."

# Update package list
sudo apt-get update

# Install ffmpeg
sudo apt-get install -y ffmpeg

# Install pip if not already installed
sudo apt-get install -y python3-pip

# Install yt-dlp
pip3 install --upgrade yt-dlp

echo "Installation complete!"