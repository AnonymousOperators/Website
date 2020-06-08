# This will assist in setting up Flask App on Nginx With Gunicorn on VPS
# This config also setups for domain names and ssl

# DO NOT USE THESE URLS Conf IT WONT WORK!!!
# USE THE CONFS IN REPO, JUST USE URLS FOR REFERENCE


# https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-18-04
# https://blog.miguelgrinberg.com/post/running-your-flask-application-over-https

# This will later be made to where you can just run  ./build.sh

##################
## Dependencies ##
##################
apt update --fix-missing; apt -y upgrade; apt -y install python3-pip gunicorn3 nginx sudo; apt -y install python3-dev build-essential libssl-dev libffi-dev python3-setuptools; apt -y install python3-venv;



# don't forget to add USER

cd /home
python3.6 -m venv app
mkdir app/templates


source app/bin/activate
#pip installs just use pip in venv
pip install wheel flask gunicorn
# Extensions
#
pip install flask_login flask_mail Flask-PyMongo

#add app.py file, test
# should run on public_ip:port
# If it works, do WSGI

# add wsgi.py to app/

gunicorn --bind 0.0.0.0:5000 wsgi:app


#Next, let’s create the systemd service unit file.
#Creating a systemd unit file will allow Ubuntu’s init system to automatically
#start Gunicorn and serve the Flask application whenever the server boots.
sudo nano /etc/systemd/system/myproject.service

# put this inside
[Unit]
Description=Gunicorn instance to serve app
After=network.target

[Service]
User=an0n
Group=www-data
WorkingDirectory=/home/app
Environment="PATH=/home/app/bin/gunicorn"
ExecStart=/home/app/bin/gunicorn --workers 3 --bind unix:app.sock -m 007 wsgi:app

[Install]
WantedBy=multi-user.target
# end of

#We can now start the Gunicorn service we created and enable it so that it starts at boot:
sudo systemctl start myproject;
sudo systemctl enable myproject;

# if that worked, you'll get This
# Created symlink /etc/systemd/system/multi-user.target.wants/app.service → /etc/systemd/system/app.service.


# now let's add nginx confs so default web traffic is Flask

sudo nano /etc/nginx/sites-enabled/app

# create symlink
sudo ln -s /etc/nginx/sites-enabled/app /etc/nginx/sites-available

###############
## SSL Setup ##
###############
# Next we need to do ssl
sudo apt install python-certbot-nginx
sudo certbot --nginx -d anonymousoperators.com -d www.anonymousoperators.com

# Boom, now you have flask, redirect, and ssl
