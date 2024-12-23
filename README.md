# Wi-Fi Deauther Script

This **Wi-Fi Deauther Script** is a Bash-based tool designed for Kali Linux, utilizing `airodump-ng` and `aireplay-ng` from the Aircrack-ng suite. The script automates Wi-Fi network scanning, adapter mode switching, and client deauthentication, allowing for precise control over network attacks for penetration testing purposes.

> **Disclaimer:** This tool is intended for educational and ethical penetration testing purposes only. Unauthorized use of this script is illegal and punishable under applicable laws. Use responsibly.

---

## Features

- **Wi-Fi Adapter Management:**
  - Switch between **Managed** and **Monitor** modes.
  - Support for frequency change (2.4 GHz and 5 GHz).

- **Wi-Fi Network Scanning:**
  - Discover available Wi-Fi networks.
  - Automatically retrieve network details (BSSID, ESSID, Channel).

- **Deauthentication Attacks:**
  - Deauthenticate a specific client from a selected network.
  - Deauthenticate all clients from a network.
  - Control the duration of the deauthentication attack.

- **Customizable Settings:**
  - Manual selection of networks and clients.
  - Configurable deauthentication duration.

- **Cool Interface:**
  - Displays a colorful ASCII art banner: **"Made by Amit"**.

---

## Requirements

- Kali Linux or any Linux distribution with Aircrack-ng installed.
- A Wi-Fi adapter capable of monitor mode.
- Superuser (root) privileges.

---

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/Wi-Fi-Deauther.git
   cd Wi-Fi-Deauther
