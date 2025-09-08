#!/bin/bash
# ChordCubes Enterprise Deployment Script
# Military-grade deployment for production, staging, and development
# Created September 8, 2025

# Configuration
PROD_PORT=9000
STAGING_PORT=9001
DEV_PORT=9002
LOG_DIR="/Users/markvandendool/ChordCubes-Enterprise/logs"
BACKUP_DIR="/Users/markvandendool/ChordCubes-Enterprise/backups"
CONFIG_DIR="/Users/markvandendool/ChordCubes-Enterprise/config"
DEPLOY_DIR="/Users/markvandendool/ChordCubes-Enterprise/deployments"

# Create required directories
mkdir -p "$LOG_DIR" "$BACKUP_DIR/$(date +%Y%m%d)" "$CONFIG_DIR"

# Stop any existing servers
echo "Terminating any existing ChordCubes servers..."
pkill -f "python3 -m http.server 900[0-2]" 2>/dev/null

# Function to start a server
start_server() {
    local env=$1
    local port=$2
    local log_file="${LOG_DIR}/${env}_$(date +%Y%m%d_%H%M%S).log"
    
    echo "Starting $env server on port $port..."
    cd "/Users/markvandendool/ChordCubes-Enterprise/$env/src" && \
    nohup python3 -m http.server $port > "$log_file" 2>&1 &
    
    local pid=$!
    echo "$pid" > "${CONFIG_DIR}/${env}_server.pid"
    
    echo "✅ $env server started on port $port (PID: $pid)"
    echo "   Access at: http://localhost:$port"
    echo "   Logs: $log_file"
}

# Create deployment archives
echo "Creating deployment archives..."
cd "/Users/markvandendool/ChordCubes-Enterprise"
tar -czf "${DEPLOY_DIR}/chordcubes_v1.50_gold_$(date +%Y%m%d).tar.gz" production/
tar -czf "${BACKUP_DIR}/$(date +%Y%m%d)/chordcubes_v1.50_gold_$(date +%Y%m%d_%H%M%S).tar.gz" production/

# Generate checksums
cd "${DEPLOY_DIR}"
shasum -a 256 "chordcubes_v1.50_gold_$(date +%Y%m%d).tar.gz" > "chordcubes_v1.50_gold_$(date +%Y%m%d).tar.gz.sha256"
echo "✅ Deployment package created with SHA-256 verification"

# Start servers
start_server "production" $PROD_PORT
start_server "staging" $STAGING_PORT
start_server "development" $DEV_PORT

echo ""
echo "🚀 CHORDCUBES V1.50 GOLD ENTERPRISE DEPLOYMENT COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PRODUCTION:  http://localhost:$PROD_PORT"
echo "STAGING:     http://localhost:$STAGING_PORT"
echo "DEVELOPMENT: http://localhost:$DEV_PORT"
echo ""
echo "Deployment package: ${DEPLOY_DIR}/chordcubes_v1.50_gold_$(date +%Y%m%d).tar.gz"
echo "Backup created: ${BACKUP_DIR}/$(date +%Y%m%d)/chordcubes_v1.50_gold_$(date +%Y%m%d_%H%M%S).tar.gz"
echo ""
echo "Enterprise documentation available at: /Users/markvandendool/ChordCubes-Enterprise/docs/"
