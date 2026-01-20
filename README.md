# 🌍 Bind9 Local DNS Cache Optimizer for ISPs

![Linux](https://img.shields.io/badge/OS-Ubuntu%20%7C%20CentOS-orange)
![Service](https://img.shields.io/badge/Service-BIND9%20DNS-blue)
![Performance](https://img.shields.io/badge/Performance-Ultra%20Low%20Latency-green)

## 📖 Overview
Slow browsing is the #1 complaint in the ISP business. Often, the issue isn't bandwidth, but **DNS Latency**. Every time a user visits a website, their request travels to Google (8.8.8.8) or Cloudflare, adding 50-100ms delay.

This repository creates a **Local Recursive DNS Cache Server** inside your network. It stores DNS records locally in RAM, serving requests in **<1ms**.

## 🛠 Features
- 🚀 **Zero Latency:** Resolves cached domains instantly from the local network.
- 📉 **Bandwidth Saving:** Reduces unnecessary traffic to upstream providers.
- 🛡️ **DNS Security:** Protects against DNS Spoofing and Cache Poisoning.
- 📝 **Logging:** Logs query data for analysis (optional).

## ⚙️ Configuration Logic
- **Forwarders:** If the domain is not in the cache, it forwards the query to high-speed public DNS (1.1.1.1 / 8.8.8.8).
- **ACL (Access Control List):** Ensures only *your* ISP clients can use this server (prevents public abuse).
- **Caching:** Optimization parameters tuned for high-throughput environments.

## 🚀 Installation Guide

### Step 1: Clone the Repo
```bash
git clone [https://github.com/devalaminbro/bind9-local-dns-cache-optimizer.git](https://github.com/devalaminbro/bind9-local-dns-cache-optimizer.git)
cd bind9-local-dns-cache-optimizer

Step 2: Run the Setup Script
This script automates the installation and configuration of Bind9 on Ubuntu/Debian.
chmod +x setup_dns.sh
sudo ./setup_dns.sh

Step 3: Point MikroTik to This Server
Go to your MikroTik Router: IP > DNS > Servers: [Your Linux Server IP]

⚠️ Hardware Recommendation
RAM: Minimum 2GB (DNS Caching is RAM intensive).
CPU: 2 Cores.

Author: Sheikh Alamin Santo
Cloud Infrastructure Specialist & System Administrator
