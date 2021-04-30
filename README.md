# docker-matrix-pantalaimon
Wraps Matrix's [pantalaimon][] service with an [env-based config][e2c].

[pantalaimon]: https://github.com/matrix-org/pantalaimon
[e2c]: https://github.com/JohnStarich/env2config

## Quick Start

Run as a single Docker container, or something like a Docker stack.

Do **_NOT_** expose pantalaimon's port to your Matrix users. It must only be accessible to your bots and bridges.

1. Deploy pantalaimon
2. Point your bridges or bots at pantalaimon instead of the usual Matrix homserver URL
3. Log in via pantalaimon's URL manually for one-time setup.

### Docker

```bash
# Remember to block the port from your Matrix users
docker run --rm -it \
    --name pantalaimon \
    -p "8008:8008" \
    -e MATRIX_URL=https://example.com \
    -v pantalaimon:/data \
    johnstarich/matrix-pantalaimon:0.9.2_20210425
```

### Docker Stack

```yaml
version: "3"

services:
  pantalaimon:
    image: johnstarich/matrix-pantalaimon:0.9.2_20210425
    # Remember to block the port from your Matrix users
    ports:
    - "8008:8008"
    environment:
    - MATRIX_URL=https://example.com
    volumes:
    - pantalaimon:/data

volumes:
  pantalaimon:
```

### First-time setup

To set up an E2EE bridge with pantalaimon for the first time, you must log in manually once.

One method is to exec into the pantalaimon container, install curl, and then run this with the bot user's credentials:
```bash
# Don't forget to replace ${BOT_*} with the correct values for your bot.
curl -XPOST -d '{"type":"m.login.password", "user":"${BOT_USER}", "password":"${BOT_PASS}"}' "http://localhost:8008/_matrix/client/r0/login"
```

