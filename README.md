# Odysseus - Umbrel App

A lightweight reverse proxy app for Umbrel that bridges access to Odysseus running on your PC with RTX 3090 GPU acceleration.

## Quick Install

1. Open your Umbrel dashboard at `http://192.168.8.227`
2. Go to **App Store**
3. Click **+** to add custom app store
4. Paste: `https://github.com/yourusername/odysseus-umbrel-app`
5. Find **Odysseus** and click **Install**
6. Toggle **On**

## What This App Does

- **Toggleable**: Start/stop from Umbrel dashboard with one click
- **Bridge**: Proxies traffic from Umbrel to your PC's Odysseus (127.0.0.1:7860)
- **GPU Acceleration**: All AI computation happens on your RTX 3090
- **Network Access**: Access from Umbrel's local network
- **Simple**: No configuration needed - just toggle on

## Accessing Odysseus

**Your PC (Direct - unchanged):**
```
http://127.0.0.1:7860
Login: admin / ravatfamily
```

**From Umbrel (through app):**
```
http://192.168.8.227:7861
Login: admin / ravatfamily
```

## How It Works

```
Umbrel App (ody service, port 7861)
    ↓ (nginx reverse proxy)
    ↓
host.docker.internal:7860
    ↓
Your PC Odysseus (127.0.0.1:7860)
    ↓
RTX 3090 GPU Processing
```

## Architecture

- **Service name**: `ody` (lightweight, simple)
- **External port**: `7861` (Umbrel network)
- **Container port**: `80` (nginx default)
- **Backend**: `host.docker.internal:7860` (your PC localhost)

## Troubleshooting

**App won't start:**
```bash
ssh umbrel@192.168.8.227
cd ~/umbrel/apps/odysseus
docker compose logs ody
```

**Can't reach your PC:**
Verify Odysseus is running on your PC:
```bash
curl http://127.0.0.1:7860/
```

**Port 7861 already in use:**
Edit `docker-compose.yml`:
```yaml
ports:
  - 7862:80  # Change 7861 to 7862
```

Restart the app from Umbrel dashboard.

## Files

- `umbrel-app.yml` - App manifest (Umbrel configuration)
- `docker-compose.yml` - Container definition (service name: `ody`)
- `nginx.conf` - Reverse proxy configuration
- `README.md` - This file

## For Developers

This app uses the Umbrel App Framework and can be added to any community app store.

Repository format compatible with:
- Umbrel Community App Store
- Official Umbrel App Store
- Any Umbrel v0.5+

## Support

- **Odysseus Issues**: https://github.com/strigo/odysseus/issues
- **Umbrel Docs**: https://docs.umbrel.com
- **App Issues**: https://github.com/yourusername/odysseus-umbrel-app/issues

## License

MIT - Same as Odysseus
