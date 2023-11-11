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
                echo "Parallel 설치를 위한 패키지 관리자를 지원하지 않습니다."
                exit 1
            fi
            ;;
        Darwin*)
            if command_exists brew; then
                brew install parallel
            else
                echo "macOS에서 Parallel을 설치하려면 Homebrew를 설치하세요."
                exit 1
            fi
            ;;
        *)
            echo "Parallel 설치를 지원하지 않는 OS입니다."
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
                echo "Aircrack-ng 설치를 위한 패키지 관리자를 지원하지 않습니다."
                exit 1
            fi
            ;;
        Darwin*)
            if command_exists brew; then
                brew install aircrack-ng
            else
                echo "macOS에서 Aircrack-ng을 설치하려면 Homebrew를 설치하세요."
                exit 1
            fi
            ;;
        *)
            echo "Aircrack-ng 설치를 지원하지 않는 OS입니다."
            exit 1
            ;;
    esac
}

check_and_install() {
    local tool=$1
    local install_function=$2
    if ! command_exists "$tool"; then
        echo "$tool 이 설치되어 있지 않습니다."
        read -p "설치하시겠습니까? (yes/no): " install_choice
        if [ "$install_choice" = "yes" ]; then
            $install_function
        else
            echo "이 스크립트를 실행하기 위해 $tool 이 필요합니다."
            exit 1
        fi
    fi
}

check_and_install parallel install_parallel
check_and_install airmon-ng install_aircrack_ng
check_and_install aireplay-ng install_aircrack_ng

show_wireless_interfaces() {
    echo "사용 가능한 무선 네트워크 인터페이스를 나열합니다:"
    iwconfig | grep "IEEE 802.11" | awk '{print $1}'
}

scan_network() {
    INTERFACE=$1
    echo "인터페이스 $INTERFACE 에서 네트워크 스캔 중..."
    sudo iwlist $INTERFACE scan | grep "ESSID\|Channel"
}

start_monitor_mode() {
    sudo airmon-ng start $INTERFACE
    MON_INTERFACE="${INTERFACE}mon"
}

deauthenticate() {
    sudo iwconfig $MON_INTERFACE channel $SELECTED_CHANNEL
    # Start monitor mode, deauthenticate and then stop monitor mode
}

stop_monitor_mode() {
    sudo airmon-ng stop $MON_INTERFACE
}

show_wireless_interfaces

read -p "사용할 무선 네트워크 인터페이스를 선택하세요: " INTERFACE

show_wireless_interfaces | parallel -j 0 scan_network

read -p "무선 네트워크의 ESSID를 입력하세요: " SELECTED_ESSID
read -p "무선 네트워크의 채널을 입력하세요: " SELECTED_CHANNEL

start_monitor_mode
deauthenticate
stop_monitor_mode
