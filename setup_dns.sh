```bash
#!/bin/bash

# ============================================================
# Bind9 Local DNS Cache Auto-Installer
# Author: Sheikh Alamin Santo
# Optimization: Tuned for High-Performance ISP Networks
# ============================================================

# Color Codes
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}[+] Starting DNS Cache Server Installation...${NC}"

# 1. Install Bind9
echo -e "${GREEN}[+] Installing Bind9 and Utilities...${NC}"
apt-get update -y
apt-get install -y bind9 bind9utils bind9-doc

# 2. Configure Options (Caching & Forwarding)
echo -e "${GREEN}[+] Configuring named.conf.options...${NC}"

# Backup original config
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

# Inject Optimized Configuration
cat > /etc/bind/named.conf.options <<EOF
acl "trusted" {
        127.0.0.0/8;
        192.168.0.0/16;  # Allow Local Network
        10.0.0.0/8;      # Allow Private Ranges
        172.16.0.0/12;
};

options {
        directory "/var/cache/bind";

        # Forwarding (If not in cache, ask Google/Cloudflare)
        forwarders {
                1.1.1.1;
                8.8.8.8;
        };

        # Security & Access Control
        recursion yes;
        allow-query { trusted; };
        allow-transfer { none; };

        # Performance Tuning
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
        
        # Cache Limits (Prevent RAM overflow)
        max-cache-size 90%;
        cleaning-interval 60;
};
EOF

# 3. Check Configuration Syntax
echo -e "${GREEN}[+] Verifying Configuration Syntax...${NC}"
named-checkconf

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] Syntax OK. Restarting Bind9...${NC}"
    systemctl restart bind9
    systemctl enable bind9
    
    echo -e "${GREEN}=============================================${NC}"
    echo -e "${GREEN}   DNS CACHE SERVER IS READY! 🚀             ${NC}"
    echo -e "${GREEN}=============================================${NC}"
    echo -e "Use this Server IP in your MikroTik DNS Settings."
else
    echo -e "\033[0;31m[!] Configuration Error! Please check logs.\033[0m"
fi
