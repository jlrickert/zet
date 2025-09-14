# Patch: serving password protected static websites on my homelab

I needed a way to serve my KEG out to cowokers in a protected way from my
[homelab](../578). I would like to host it using docker compose files. I want to
keep it nice and simple.

**Requirements:**

- HTTPS
- basic http authentication
- needs to restart if the server is restarted
- Needs to be able to server static content

## Patch

I spun up a [v1 cloud instance](../1063) to setup static web hosting.

### 1. Install docker

```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$(whoami)"
```

### 2. Create project structure

```bash
mkdir ~/www-ecw-keg
cd ~/www-ecw-keg
touch Caddyfile
touch docker-compose.yml
```

### 3. Install caddy

```bash
mkdir -p ~/repos/github.com
cd ~/repos/github.com
git clone "https://github.com/caddyserver/caddy.git"
cd caddy/cmd/caddy
go build
sudo mkdir /opt/caddy/bin
sudo cp caddy /opt/caddy/bin/
echo 'export PATH="$PATH:/opt/caddy/bin"' >> ~/.bashrc
# reload bash
```

### 4. Create a password

I used the username and password with the
[ECW test server credentials](../1053).

Use the command `caddy hash-password` to generate a blob value. Password for Bob
is jiberish - not literally.

### 5. Create a `Caddyfile` file

```text
ecw.keg.jlrickert.me {
  root * /usr/share/caddy
  basic_auth {
    Bob JDJhJDEwJEVCNmdaNEg2Ti5iejRMYkF3MFZhZ3VtV3E1SzBWZEZ5Q3VWc0tzOEJwZE9TaFlZdEVkZDhX
  }
  encode
  file_server
}
```

### 6. Create a `docker-compose.yml` file

```yaml
name: ecw-keg-registry
services:
  caddy:
    image: caddy:2.10-alpine
    restart: always
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - ./static:/usr/share/caddy
      - caddy_data:/data

volumes:
  caddy_data:
  # caddy SSL volume
```

### 8. Add the content

Copy over content to the `static` directory

### 7. Start the service

```bash
docker compose up -d
```

### 8. Systemd service

```text
[Unit]
Description=ECW Keg Docker Compose
Requires=docker.service
After=docker.service network-online.target
Wants=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/jlrickert/www-ecw-keg
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=120
TimeoutStopSec=60

[Install]
WantedBy=multi-user.target
```

```text
sudo systemctl daemon-reload
sudo systemctl enable myapp.service
sudo systemctl start myapp.service
```