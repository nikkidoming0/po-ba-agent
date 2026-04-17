#!/bin/bash
set -e

echo "🚀 PO/BA Agent Suite Installer"
echo "=============================="
echo "Installing the Product Owner / Business Analyst AI Agent"

echo ""
echo "Step 1/4: Setting up environment..."
if ! command -v gemini >/dev/null 2>&1; then
  if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Please install Node.js from https://nodejs.org"
    exit 1
  fi
  npm install -g @google/gemini-cli >/dev/null 2>&1
fi

echo ""
echo "Step 2/4: Account setup..."
gemini --version >/dev/null 2>&1 || true

echo ""
echo "Step 3/4: Installing skills..."

REPO_URL="https://github.com/nikkidoming0/po-ba-agent.git"   # ← CHANGE TO YOUR REPO

TEMP_DIR=$(mktemp -d)
git clone --depth 1 --sparse "$REPO_URL" "$TEMP_DIR" || {
  echo "❌ Failed to download skills. Make sure repo is public."
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
echo "✅ All skills installed!"

# STEP 4 - Safe Launch
echo ""
echo "Step 4/4: Launching PO/BA Agent from safe folder..."

cd ~
mkdir -p ~/po-ba-agent-workspace
cd ~/po-ba-agent-workspace

echo "🎉 Ready! The agent is starting..."
echo "You should see the list of skills below."

gemini << EOF
/skills
EOF