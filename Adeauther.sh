#!/bin/bash

# Function to display a colorful heading
show_heading() {
    echo -e "\e[1;36m" # Cyan color
    echo "  __  __       _     _   _       _     "
    echo " |  \/  |     (_)   | | (_)     | |    "
    echo " | \  / | __ _ _  __| |  _ _ __ | |__  "
    echo " | |\/| |/ _\` | |/ _\` | | | '_ \| '_ \ "
    echo " | |  | | (_| | | (_| | | | | | | | | |"
    echo " |_|  |_|\__,_|_|\__,_| |_|_| |_|_| |_|"
    echo "            Made by Amit              "
    echo -e "\e[0m" # Reset color
}

# Function to check Wi-Fi adapter status
check_adapter_status() {
    echo "Checking Wi-Fi adapter status..."
    iwconfig 2>/dev/null | grep -E "Mode|ESSID|Frequency"
}

# Function to change adapter mode
change_adapter_mode() {
    echo -e "\n1. Managed Mode"
    echo "2. Monitor Mode"
    read -p "Select mode (1/2): " mode

    if [ "$mode" == "1" ]; then
        airmon-ng stop $adapter
        echo "Adapter mode changed to Managed."
    elif [ "$mode" == "2" ]; then
        airmon-ng start $adapter
        echo "Adapter mode changed to Monitor."
    else
        echo "Invalid selection."
    fi
}

# Function to scan for Wi-Fi networks and select one
scan_networks() {
    echo "Scanning for Wi-Fi networks... Press Ctrl+C to stop."
    airodump-ng $adapter --output-format csv --write scan_results 2>/dev/null &
    sleep 5
    kill $!  # Stop scanning

    echo "Available networks:"
    awk -F',' '/WPA|WEP/{print NR-1, $1, $14, $4}' scan_results-01.csv | column -t -s ','

    read -p "Select a network number: " network_number
    selected_network=$(awk -F',' '/WPA|WEP/{print NR-1 "," $1 "," $14 "," $4}' scan_results-01.csv | sed -n "$((network_number + 1))p")

    if [ -z "$selected_network" ]; then
        echo "Invalid selection."
        return 1
    fi

    bssid=$(echo "$selected_network" | cut -d',' -f2)
    essid=$(echo "$selected_network" | cut -d',' -f3)
    channel=$(echo "$selected_network" | cut -d',' -f4)

    echo "Selected Network: ESSID=$essid, BSSID=$bssid, Channel=$channel"
}

# Main menu
show_heading # Display the heading at the start

while true; do
    echo -e "\n---- Wi-Fi Attack Script ----"
    echo "1. Check Wi-Fi Adapter Status"
    echo "2. Change Adapter Mode"
    echo "3. Scan for Wi-Fi Networks"
    echo "4. Exit"
    read -p "Choose an option: " choice

    case $choice in
    1)
        check_adapter_status
        ;;
    2)
        change_adapter_mode
        ;;
    3)
        scan_networks
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please try again."
        ;;
    esac
done
