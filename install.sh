#!/bin/bash
set -e

echo "🚀 Installing PO/BA User Stories Agent Skill..."

SKILL_DIR="$HOME/.agents/skills/po-ba-user-stories"

if [ -d "$SKILL_DIR" ]; then
  echo "Skill already exists. Updating..."
  cd "$SKILL_DIR" && git pull
else
  git clone https://github.com/YOURUSERNAME/po-ba-agent-skills.git "$SKILL_DIR"
fi

echo "✅ Skill installed successfully!"
echo "Run: gemini"
echo "Then type: /skills  (you should see po-ba-user-stories)"