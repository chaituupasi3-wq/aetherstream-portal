#!/usr/bin/env bash
# ==============================================================================
# Script Name: health-check.sh
# Description: Verifies HTTP status of AetherStream portal endpoints.
# Exits with 0 on success, 1 on failure.
# ==============================================================================

set -euo pipefail

URL="http://localhost/index.html"
HEALTH_URL="http://localhost/health.html"

echo "Running AetherStream portal health checks..."

# Check Index Page
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "  [PASS] Index page is reachable (HTTP $HTTP_STATUS)"
else
    echo "  [FAIL] Index page returned unexpected status: HTTP $HTTP_STATUS"
    exit 1
fi

# Check Health Status Page
HEALTH_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$HEALTH_URL")
if [ "$HEALTH_STATUS" -eq 200 ]; then
    echo "  [PASS] Health page is reachable (HTTP $HEALTH_STATUS)"
else
    echo "  [FAIL] Health page returned unexpected status: HTTP $HEALTH_STATUS"
    exit 1
fi

echo "All health checks passed successfully!"
exit 0