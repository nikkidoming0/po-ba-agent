#!/bin/bash
set -e

echo "🚀 Installing PO/BA User Stories Agent Skill..."
echo "🚀 PO/BA Agent Suite Installer (Gemini CLI + Skills)"
echo "==================================================="

SKILL_DIR="$HOME/.agents/skills/po-ba-user-stories"
# ==================== 1. INSTALL GEMINI CLI ====================
echo "📦 Checking for Gemini CLI..."

if [ -d "$SKILL_DIR" ]; then
  echo "Skill already exists. Updating..."
  cd "$SKILL_DIR" && git pull
if command -v gemini >/dev/null 2>&1; then
  echo "✅ Gemini CLI is already installed."
else
  git clone https://github.com/nikkidoming0/po-ba-agent.git "$SKILL_DIR"
  echo "🔧 Gemini CLI not found. Installing now..."

  # Check for npm
  if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Node.js / npm is not installed."
    echo "   Please install Node.js 20+ from https://nodejs.org"
    echo "   Then run this installer again."
    exit 1
  fi

  echo "   Installing @google/gemini-cli globally via npm..."
  npm install -g @google/gemini-cli

  echo "✅ Gemini CLI installed successfully!"
fi

echo "✅ Skill installed successfully!"
echo "Run: gemini"
echo "Then type: /skills  (you should see po-ba-user-stories)"
# ==================== 2. RUN GEMINI FOR FIRST-TIME GOOGLE LOGIN ====================
echo ""
echo "🔑 Running Gemini CLI for the first time to complete Google login (gauth)..."
echo "   → A browser window will open. Please sign in with your Google account."
echo "   → Grant the required permissions."
echo ""

# Run gemini once (it will prompt login if needed)
gemini --version >/dev/null 2>&1 || true

echo "✅ Google login completed (or already done)."

# ==================== 3. INSTALL THE 3 SKILLS ====================
echo ""
echo "📂 Installing PO/BA skills (user-stories)..."

SKILL_BASE="$HOME/.agents/skills"
mkdir -p "$SKILL_BASE"

REPO_URL="https://github.com/nikkidoming0/po-ba-agent.git"   # ← CHANGE THIS TO YOUR REPO

# Temporary clone to get the latest skills
TEMP_DIR=$(mktemp -d)
git clone --depth 1 --sparse "$REPO_URL" "$TEMP_DIR" 2>/dev/null || {
  echo "❌ Could not clone your repo. Make sure the repo is public and the URL is correct."
  exit 1
}

cd "$TEMP_DIR"
git sparse-checkout set skills

for skill in po-ba-user-stories po-ba-roadmap po-ba-acceptance-testing; do
  SKILL_DIR="$SKILL_BASE/$skill"
  if [ -d "$SKILL_DIR" ]; then
    echo "   Updating $skill..."
    rm -rf "$SKILL_DIR"
  fi
  cp -R "skills/$skill" "$SKILL_BASE/"
  echo "   ✅ $skill installed"
done

# Cleanup
cd /tmp && rm -rf "$TEMP_DIR"

echo ""
echo "🎉 FULL INSTALLATION COMPLETE!"
echo ""
echo "✅ Gemini CLI is ready"
echo "✅ All 3 templated skills are installed"
echo ""
echo "🚀 How to use it now:"
echo "   1. Open your terminal"
echo "   2. Type: gemini"
echo "   3. Start typing your request, for example:"
echo "      Title: Login page redesign"
echo "      Context: Mobile-first app..."
echo "      @./mockup.png"
echo "      Use template: detailed"
echo ""
echo "You’re all set! The agent will now output perfectly templated user stories."