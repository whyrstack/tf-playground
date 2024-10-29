#!/bin/bash

# apt update -y
# apt upgrade -y

# install="nginx python3-certbot-nginx dovecot-imapd dovecot-pop3d dovecot-sieve opendkim opendkim-tools spamassassin spamc net-tools fail2ban bind9-host" 

# apt install $install -y

# hostnamectl set-hostname ${instance_name}.poulson.xyz
# sudo sed -i 's/127\.0\.0\.1 localhost/127\.0\.0\.1 mail\.poulson\.xyz mail/g' /etc/hosts
# systemctl restart systemd-hostnamed

# rm -rf /etc/nginx/sites-available/*
# rm -rf /etc/nginx/sites-enabled/*

# cat <<EOF > /etc/nginx/sites-available/mail
# server {
#         listen 80 default_server;
#         listen [::]:80 default_server;

#         root /var/www/html;

#         index index.html index.htm index.nginx-debian.html;

#         server_name mail.poulson.xyz www.mail.poulson.xyz;

#         location / {
#                 try_files $uri $uri/ =404;
#         }

# }
# EOF

# ln -s /etc/nginx/sites-available/mail /etc/nginx/sites-enabled/

# systemctl restart nginx.service

# cat <<EOF > /root/run-me.sh
# #!/bin bash
# echo "Installing postfix..."
# sudo apt install postfix postfix-pcre -y
# echo "Downloading LukeSmith email script..."
# curl -LO lukesmith.xyz/emailwiz.sh
# echo "running certbot for you..."
# sudo certbot --nginx
# echo "done, now run LukeSmithScript (and follow DNS instructions if required...)"

# EOF

# chmod +x /root/run-me.sh



# echo "DONE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

# exit 0