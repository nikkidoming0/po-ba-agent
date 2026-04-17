#!/bin/bash
set -e

echo "🚀 PO/BA Agent Suite Installer"
echo "=============================="
echo "This will install Gemini CLI and the 3 PO/BA skills"

# ==================== STEP 1: Gemini CLI ====================
echo ""
echo "Step 1/4: Checking & Installing Gemini CLI..."

if command -v gemini >/dev/null 2>&1; then
  echo "✅ Gemini CLI is already installed."
else
  echo "🔧 Installing Gemini CLI..."
  if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Node.js/npm is not installed."
    echo "   Please install Node.js 20+ from https://nodejs.org"
    echo "   Then run this installer again."
    exit 1
  fi

  npm install -g @google/gemini-cli
  echo "✅ Gemini CLI installed successfully!"
fi

# ==================== STEP 2: Google Login ====================
echo ""
echo "Step 2/4: Running Gemini CLI for Google account login..."
echo "   → A browser window will open. Please sign in and grant permissions."

gemini --version >/dev/null 2>&1 || true
echo "✅ Google login completed."

# ==================== STEP 3: Install Skills ====================
echo ""
echo "Step 3/4: Installing PO/BA skills (user-stories, roadmap, acceptance-testing)..."

SKILL_BASE="$HOME/.agents/skills"
mkdir -p "$SKILL_BASE"

# ←←← CHANGE THIS TO YOUR ACTUAL REPO URL ←←←
REPO_URL="https://github.com/nikkidoming0/po-ba-agent.git"

TEMP_DIR=$(mktemp -d)
git clone --depth 1 --sparse "$REPO_URL" "$TEMP_DIR" || {
  echo "❌ Failed to download skills from repo."
  echo "   Make sure the repository is public and the URL is correct."
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

# ==================== STEP 4: Run Gemini ====================
echo ""
echo "Step 4/4: Launching Gemini CLI..."

echo "🎉 Installation completed!"
echo ""
echo "Gemini is now starting..."
echo "You can start using the PO/BA agent right away."
echo ""
echo "Example usage:"
echo "   Title: User authentication flow"
echo "   Context: Mobile e-commerce app"
echo "   @./login-mockup.png"
echo "   Use template: detailed"
echo ""

# Final step: Launch gemini
gemini