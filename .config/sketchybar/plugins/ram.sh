#!/bin/sh

# If NAME isn't set (running directly), use "ram"
if [ -z "$NAME" ]; then
  NAME="ram"
fi

# Get memory stats
PAGES_FREE=$(vm_stat | grep "Pages free" | awk '{gsub(/\./,"",$3); print $3}')
PAGES_ACTIVE=$(vm_stat | grep "Pages active" | awk '{gsub(/\./,"",$3); print $3}')
PAGES_INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{gsub(/\./,"",$3); print $3}')
PAGES_SPECULATIVE=$(vm_stat | grep "Pages speculative" | awk '{gsub(/\./,"",$3); print $3}')
PAGES_WIRED=$(vm_stat | grep "Pages wired down" | awk '{gsub(/\./,"",$4); print $4}')

# Calculate used and total memory
PAGES_USED=$((PAGES_ACTIVE + PAGES_WIRED))
PAGES_TOTAL=$((PAGES_USED + PAGES_FREE + PAGES_INACTIVE + PAGES_SPECULATIVE))
PERCENT_USED=$((PAGES_USED * 100 / PAGES_TOTAL))

# Print to terminal if running directly
if [ "$NAME" = "ram" ] && [ -z "$SKETCHYBAR_CLIENT_NAME" ]; then
  echo "RAM Usage: ${PERCENT_USED}%"
else
  # Update sketchybar
  sketchybar --set "$NAME" icon="" label="${PERCENT_USED}%"
fi
