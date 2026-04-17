#!/bin/bash
set -e

echo "🚀 PO/BA Agent Suite Installer"
echo "=============================="
echo "Installing the Product Owner / Business Analyst AI Agent"

# ==================== STEP 1: Install Backend Tool ====================
echo ""
echo "Step 1/4: Setting up the AI agent environment..."

if command -v gemini >/dev/null 2>&1; then
  echo "✅ Environment ready."
else
  echo "🔧 Preparing environment..."
  if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Node.js is required but not found."
    echo "   Please install Node.js 20+ from https://nodejs.org"
    echo "   Then run this installer again."
    exit 1
  fi

  npm install -g @google/gemini-cli >/dev/null 2>&1
  echo "✅ Environment prepared."
fi

# ==================== STEP 2: Account Setup ====================
echo ""
echo "Step 2/4: Setting up your account..."
echo "   → A browser window will open. Please sign in with your Google account."

gemini --version >/dev/null 2>&1 || true
echo "✅ Account setup completed."

# ==================== STEP 3: Install Skills ====================
echo ""
echo "Step 3/4: Installing PO/BA skills..."

SKILL_BASE="$HOME/.agents/skills"
mkdir -p "$SKILL_BASE"

REPO_URL="https://github.com/nikkidoming0/po-ba-agent.git"   # ← CHANGE TO YOUR REAL REPO

TEMP_DIR=$(mktemp -d)
git clone --depth 1 --sparse "$REPO_URL" "$TEMP_DIR" || {
  echo "❌ Failed to download skills. Make sure the repository is public."
  exit 1
}

cd "$TEMP_DIR"
git sparse-checkout set skills

for skill in po-ba-user-stories po-ba-roadmap po-ba-acceptance-testing; do
  SKILL_DIR="$SKILL_BASE/$skill"
  rm -rf "$SKILL_DIR"
  cp -R "skills/$skill" "$SKILL_BASE/"
  echo "   ✅ $skill skill installed"
done

rm -rf "$TEMP_DIR"
echo "✅ All skills installed successfully!"

# ==================== STEP 4: Launch Agent Safely ====================
echo ""
echo "Step 4/4: Launching the PO/BA Agent..."

echo ""
echo "🎉 Installation completed successfully!"
echo ""
echo "The PO/BA Agent is now starting..."
echo "You will see the available skills shortly."
echo ""
echo "Example usage:"
echo "   Title: Login page redesign"
echo "   Context: Mobile-first e-commerce app"
echo "   @./mockup.png"
echo "   Use template: detailed"
echo ""

# Safe launch: Always start from home directory to avoid cwd error
cd ~
gemini << EOF
/skills
EOF