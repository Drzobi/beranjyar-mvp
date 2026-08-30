# BeranjYar MVP - wg-easy (WireGuard UI) + Android sample

This repository contains a minimal MVP to run a private WireGuard-based VPN for the BeranjYar pilot.

Contents:
- docker-compose.yml : wg-easy container template
- install.sh : install Docker + start docker-compose (Ubuntu/Debian)
- android-sample/ : minimal Android Studio skeleton to import/configure client
- .github/workflows/android-ci.yml : example CI job to build Android (handles missing gradlew)

IMPORTANT NOTES (MVP)
- ADMIN (wg-easy) password is NOT included in files. Set it in environment before first run.
- WG_HOST and server IP are set to vpn.beranjyar.internal / 10.10.0.1 as placeholders — replace with your real host/IP.

Quick start (Ubuntu/Debian):
1) Copy repository files to your server (or download ZIP and extract).
2) Edit docker-compose.yml and set PASSWORD environment variable to a strong password (or export it as env var before running):
   export WG_PASSWORD=My$tr0ngP@ss
   Then update docker-compose.yml to use the value or use an .env file.
3) Run: sudo ./install.sh
4) Open and forward port 51821 (HTTP UI) and 51820 UDP (WireGuard) in your router/firewall.
5) Open http://<SERVER_IP>:51821 and login with the ADMIN password you set. Create peers and export QR or .conf for clients.

Note about CGNAT / ISP
- If your ISP uses CGNAT, incoming UDP from internet may not reach your home server. Options:
  - request a public/static IP from ISP
  - use a public relay/VPS to NAT traffic (advanced)

Security notes
- Store private keys securely. For MVP we create keys on server for simplicity; in production consider client-side key generation.
- Keep logs minimal and inform pilot users about data collected.
- Use certificate pinning in the mobile app when contacting your API.

Android sample
- The `android-sample` folder contains a minimal Kotlin app demonstrating how to display/import a WireGuard .conf or QR; it is NOT a full VPN client.

Pilot plan
- Test with 5-20 trusted users. Collect connectivity, performance and battery usage data. Revoke peers quickly if needed.

If you need help deploying or customizing the server config for your environment, tell me your server IP or tell me to keep placeholders.