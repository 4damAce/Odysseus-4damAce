#!/bin/bash
# One-liner to set up Odysseus app on Umbrel

read -p "Umbrel IP (default 192.168.8.227): " UMBREL_IP
UMBREL_IP=${UMBREL_IP:-192.168.8.227}

read -p "Umbrel user (default umbrel): " UMBREL_USER
UMBREL_USER=${UMBREL_USER:-umbrel}

echo "📦 Setting up Odysseus app on Umbrel at $UMBREL_IP..."

# Create app directory
ssh $UMBREL_USER@$UMBREL_IP "mkdir -p ~/umbrel/apps/odysseus"

# Copy app files
echo "📋 Copying app files..."
scp metadata.json $UMBREL_USER@$UMBREL_IP:~/umbrel/apps/odysseus/
scp docker-compose.yml $UMBREL_USER@$UMBREL_IP:~/umbrel/apps/odysseus/
scp nginx.conf.template $UMBREL_USER@$UMBREL_IP:~/umbrel/apps/odysseus/
scp entrypoint.sh $UMBREL_USER@$UMBREL_IP:~/umbrel/apps/odysseus/

# Set permissions
ssh $UMBREL_USER@$UMBREL_IP "chmod +x ~/umbrel/apps/odysseus/entrypoint.sh"

# Create .env file
echo "⚙️  Creating environment file..."
ssh $UMBREL_USER@$UMBREL_IP "cat > ~/umbrel/apps/odysseus/.env << 'EOF'
ODYSSEUS_PC_HOST=host.docker.internal
ODYSSEUS_PC_PORT=7860
EOF"

echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Open Umbrel Dashboard: http://$UMBREL_IP"
echo "2. Go to App Store → My Apps"
echo "3. Find 'Odysseus' and toggle it ON"
echo "4. Check the app status in dashboard"
echo ""
echo "5. Configure Cloudflare Tunnel:"
echo "   - Open Cloudflare Tunnel app"
echo "   - Add new route:"
echo "     Subdomain: odysseus (or whatever you want)"
echo "     Type: HTTP"
echo "     URL: http://app:80"
echo ""
echo "6. Access:"
echo "   - Local: http://127.0.0.1:7860 (your PC)"
echo "   - Family: https://odysseus.yourdomain.com (via Cloudflare)"
echo ""
echo "💡 To toggle app on/off:"
echo "   Dashboard → My Apps → Odysseus → Toggle button"
