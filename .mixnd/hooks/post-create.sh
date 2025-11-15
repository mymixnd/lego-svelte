#!/bin/bash
# Post-creation hook - runs after app resources are created
# Environment variables are set by mixnd-cli

set -e

echo "Running post-creation setup..."

# Link to Supabase project and push migrations
if [ -n "$SUPABASE_PROJECT_REF" ]; then
    echo "Linking to Supabase project: $SUPABASE_PROJECT_REF"
    pnpm exec supabase link --project-ref "$SUPABASE_PROJECT_REF"

    echo "Pushing database migrations..."
    pnpm exec supabase db push

    echo "✓ Database migrations complete"
else
    echo "⚠ SUPABASE_PROJECT_REF not set, skipping migrations"
fi

echo "✓ Post-creation setup complete"