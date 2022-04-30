sudo certbot renew
sudo chmod 777 /etc/letsencrypt/live/devapp.today/fullchain.pem
sudo chmod 777 /etc/letsencrypt/live/devapp.today/privkey.pem
cp /etc/letsencrypt/live/devapp.today/fullchain.pem /home/ubuntu/wk/devapp_v2/frontend/etc/ssl/
cp /etc/letsencrypt/live/devapp.today/privkey.pem /home/ubuntu/wk/devapp_v2/frontend/etc/ssl/


