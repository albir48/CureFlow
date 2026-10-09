# Secure Web Hosting and Project Submission Portal

This project implements a secure Apache-hosted portal for project submission and administration.

## Overview

- Public site: `portal.local`
- Admin site: `admin.portal.local`
- Protected admin area using Apache Basic Authentication and `.htaccess`
- File upload form accepting PDF, DOCX, JPG, PNG and GIF
- URL rewriting for clean routes like `/about`
- File uploads stored outside the web root
- Example Apache site configs and setup script included

## Directory layout

- `public/` — public portal site
- `admin/public/` — admin portal site protected by `.htaccess`
- `uploads/` — uploaded files stored outside public web roots
- `portal.local.conf` — example Apache vhost for the public portal
- `admin.portal.local.conf` — example Apache vhost for the admin portal
- `setup.sh` — install and enable required services on Ubuntu

## Deployment steps

The repository includes a ready-to-run setup script that performs most of this work automatically on Ubuntu Server.

```bash
bash ./setup.sh
```

The script will:

1. Install Apache, SSH, PHP, UFW and supporting packages
2. Deploy the portal files to `/var/www/portal.local/public` and `/var/www/admin.portal.local/public`
3. Copy the virtual-host configuration files into `/etc/apache2/sites-available/`
4. Create the upload store outside the web root
5. Create a default admin account for the protected page

Manual verification steps are still useful if you want to inspect the deployment by hand:

```bash
sudo mkdir -p /var/www/portal_uploads
sudo chown -R www-data:www-data /var/www/portal_uploads
sudo chmod 750 /var/www/portal_uploads
```

6. Create the admin auth file and user credentials:

```bash
sudo htpasswd -c /etc/apache2/.htpasswd projectadmin
```

7. Update `upload.php` and `upload_handler.php` if the upload path differs from `/var/www/portal_uploads`
8. Ensure the public and admin `.htaccess` files stay in place so the rewrite rules and Basic Auth protection remain active.
9. Enable Apache modules and sites:

```bash
sudo a2enmod rewrite ssl headers
sudo a2ensite portal.local.conf
sudo a2ensite admin.portal.local.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

8. Configure host entries on the client machine:

```text
192.168.100.10 portal.local admin.portal.local
```

## SSH hardening

Use the following file on Ubuntu Server:

`/etc/ssh/sshd_config.d/99-project-hardening.conf`

```text
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
AllowUsers projectadmin
``` 

Validate before restarting:

```bash
sudo sshd -t
sudo systemctl restart ssh
```

## Firewall rules

```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status verbose
```

## Demonstration checklist

- SSH login with key only
- SCP/SFTP file transfer
- Apache virtual hosts open in browser
- Admin area protected by Basic Auth
- Clean URL rewrite `/about`
- Upload valid files and reject invalid files
- HTTPS support with self-signed certificate
- Apache logs observed with `tail -f`
- Service restart and auto-start on reboot
