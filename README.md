# YT-DLP Music Downloader

This project provides a simple and efficient way to download music or playlists from YouTube and SoundCloud using `yt-dlp`. The script is designed to handle both individual tracks and playlists, with options for adding metadata and embedding thumbnails.

## Features

- Downloads individual tracks or entire playlists from YouTube and SoundCloud.
- Converts audio to high-quality MP3 format.
- Adds metadata and embeds thumbnails into downloaded files.
- Customizable download directory.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- A Unix-based operating system (Linux, macOS, etc.).
- Python 3.6+ installed.
- `yt-dlp` installed within a virtual environment.

## Installation

### For Ubuntu 22.04

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/YT-DLP.git
    cd YT-DLP
    ```

2. Run the installation script specific to Ubuntu 22.04 to set up the virtual environment and install dependencies:

    ```bash
    ./install.sh
    ```

    This script will:
    - Update the package list.
    - Install `python3-venv` if it's not already installed.
    - Create a Python virtual environment in your home directory.
    - Install `yt-dlp` within the virtual environment.

## Usage

### Downloading Music from YouTube and SoundCloud

1. Prepare your list of links:

    - Create a `links.txt` file in the root directory.
    - Add YouTube and SoundCloud links (either individual tracks or playlists) you wish to download, one per line.

    **Tip:** You can use the Chrome plugin [Link Gopher](https://chrome.google.com/webstore/detail/link-gopher/bpjdkodgnbfalgghnbeggfbfjpcfamkf?hl=en&pli=1) to quickly gather all the links from a webpage and paste them into your `links.txt` file. This tool works great for collecting both individual track links and playlist links.

2. Run the download script:

    ```bash
    ./download_music.sh
    ```

    - By default, the script will read links from `links.txt`.
    - If you want to specify a different file, pass the filename as an argument:

    ```bash
    ./download_music.sh your_links_file.txt
    ```

    The script will automatically detect whether the link is for an individual track or a playlist and download accordingly.

### Script Details

- **Music Directory:**  
  The default directory for downloaded music is `~/YT-DLP/Music`. You can change this by modifying the `MUSIC_DIR` variable in the `download_music.sh` script.

- **Virtual Environment:**  
  The script assumes `yt-dlp` is installed in a virtual environment located at `~/yt-dlp-env`. If your environment is elsewhere, update the `YT_DLP` and `source` commands in the script.

### Handling Errors

- If the links file is not found, the script will display an error and exit.
- The script is designed to ignore errors from `yt-dlp` and continue processing the next link in the list.

### Customization

- Modify the `download_audio` and `download_playlist` functions in the `download_music.sh` script to change options like audio format or output file structure.

## Contributing

If you'd like to contribute, please fork the repository and make changes as you'd like. Pull requests are warmly welcome.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
