# Wireless Network Attack Project

This project provides a simple script to test and evaluate wireless network security. The script enables scanning of nearby wireless networks and executing a Deauthentication attack on a selected network.

## Usage

### 1. Checking for Available Wireless Network Interfaces

The script lists all available wireless network interfaces on the system. Users can select an interface to proceed with network scanning.

### 2. Scanning Wireless Networks and Selecting a Target Network

The script scans for all wireless networks accessible via the selected interface. Users can view the network details and select a target for the Deauthentication attack.

### 3. Executing the Deauthentication Attack

Once a target network is selected, the script initiates a Deauthentication attack, temporarily disrupting the network's wireless connectivity.

## Requirements

- Linux Operating System (The script is designed to work exclusively on Linux)
- Necessary Libraries and Tools: `iwconfig`, `iwlist`, `airmon-ng`, `aireplay-ng`
- GNU Parallel (The script checks for this tool and offers to install it if it's not present)

## Installation

The script includes functions to check for required tools (`parallel`, `aircrack-ng suite`) and installs them if they are not available. It supports various package managers like `apt-get`, `yum`, `dnf`, `zypper`, and `pacman` for Linux, and `brew` for macOS.

## Disclaimer

- The script is intended solely for security testing and educational purposes.
- Attacking other people's wireless networks is illegal, and the script should only be used on networks where you have permission.
- Exercise caution when using the script and comply with relevant laws and regulations.