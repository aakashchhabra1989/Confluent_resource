#!/bin/bash
# Script to toggle prevent_destroy settings across all Terraform resources
# Usage: ./toggle_prevent_destroy.sh [enable|disable]

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [enable|disable]"
    echo "  enable  - Sets prevent_destroy = true on all resources"
    echo "  disable - Sets prevent_destroy = false on all resources"
    exit 1
fi

ACTION="$1"

if [ "$ACTION" = "enable" ]; then
    echo "Enabling prevent_destroy on all resources..."
    
    # Replace false with true
    find . -name "*.tf" -type f -exec sed -i 's/prevent_destroy = false/prevent_destroy = true/g' {} \;
    
    # Uncomment commented prevent_destroy lines
    find . -name "*.tf" -type f -exec sed -i 's/# *prevent_destroy = true/prevent_destroy = true/g' {} \;
    find . -name "*.tf" -type f -exec sed -i 's/#   prevent_destroy = true/    prevent_destroy = true/g' {} \;
    find . -name "*.tf" -type f -exec sed -i 's/#     prevent_destroy = true/      prevent_destroy = true/g' {} \;
    
    echo "✅ prevent_destroy = true enabled on all resources"
    
elif [ "$ACTION" = "disable" ]; then
    echo "Disabling prevent_destroy on all resources..."
    
    # Replace true with false
    find . -name "*.tf" -type f -exec sed -i 's/prevent_destroy = true/prevent_destroy = false/g' {} \;
    
    echo "✅ prevent_destroy = false set on all resources"
    
else
    echo "❌ Invalid action. Use 'enable' or 'disable'"
    exit 1
fi

echo ""
echo "🔍 Current prevent_destroy settings:"
grep -r "prevent_destroy =" --include="*.tf" . | head -10
echo ""
echo "⚠️  Remember to run 'terraform plan' to validate the changes"
