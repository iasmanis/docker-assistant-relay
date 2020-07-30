# docker-assistant-relay

First time setup:

Follow the instructions to setup Assistant Relay [here](https://github.com/greghesp/assistant-relay/blob/master/readMe.md).



After setup, you can run it with:

```
docker run --rm -d \
    --name assistant-relay -p 3000:3000
    -v /path/to/host/folder/secrets:/assistant-relay/server/configurations/secrets:ro \
    -v /path/to/host/folder/tokens:/assistant-relay/server/configurations/tokens:ro \
    -v /path/to/host/folder/config.json:/assistant-relay/server/configurations/config.json \
    -e TZ=America/New_York \
    ingemars/assistant-relay:3.2.0
```

In docker swarm mode:

```
docker service create \
    --name assistant-relay \
    --detach=false \
    --publish 3000:3000 \
    -e TZ=Europe/Riga \
    --mount "type=bind,source=/path/to/host/folder/secrets,target=/assistant-relay/server/configurations/secrets" \
    --mount "type=bind,source=/path/to/host/folder/tokens,target=/assistant-relay/server/configurations/tokens" \
    --mount "type=bind,source=/path/to/host/folder/config.json,target=/assistant-relay/server/configurations/config.json" \
    ingemars/assistant-relay:3.2.0
```

If you are using it in Home Assistant, you can set up noficiation agents as follows:

```
# Notifications
notify:
  - name: Google Home
    platform: rest
    resource: !secret relay_url
    method: POST_JSON
    message_param_name: command
    data:
      user: !secret relay_user
      broadcast: true
  - name: Google Home Command
    platform: rest
    resource: !secret relay_url
    method: POST_JSON
    message_param_name: command
    data:
      user: !secret relay_user
```

Based on [greghesp/assistant-relay](https://github.com/greghesp/assistant-relay/tree/master)
