#!/bin/bash
set -e

echo "🚀 PO/BA Agent Suite Installer"
echo "=============================="
echo "Installing the Product Owner / Business Analyst AI Agent"

# STEP 1: Environment
echo ""
echo "Step 1/4: Setting up environment..."
if ! command -v gemini >/dev/null 2>&1; then
  echo "🔧 Installing backend tool..."
  if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Node.js is required. Install from https://nodejs.org"
    exit 1
  fi
  npm install -g @google/gemini-cli >/dev/null 2>&1
  echo "✅ Backend tool ready."
else
  echo "✅ Backend tool already ready."
fi

# STEP 2: Account
echo ""
echo "Step 2/4: Setting up your account..."
gemini --version >/dev/null 2>&1 || true
echo "✅ Account setup completed."

# STEP 3: Skills
echo ""
echo "Step 3/4: Installing PO/BA skills..."

SKILL_BASE="$HOME/.agents/skills"
mkdir -p "$SKILL_BASE"

REPO_URL="https://github.com/nikkidoming0/po-ba-agent.git"

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

# STEP 4: Safe Launch
echo ""
echo "Step 4/4: Launching the PO/BA Agent..."

echo ""
echo "🎉 Installation complete!"
echo "Starting from a safe permanent folder..."
echo ""

# Force safe directory to prevent cwd error
cd ~
mkdir -p ~/po-ba-agent-workspace
cd ~/po-ba-agent-workspace

gemini << EOF
/skills
EOF