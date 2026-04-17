# PO/BA User Stories Agent Skill

An expert Product Owner and Business Analyst skill for the Gemini CLI. This agent converts high-level requirements, context, links, and images into well-structured, templated user stories and technical documentation.

## Features

- **Expert Analysis:** Acts as a Senior Business Analyst to breakdown complex requirements.
- **Multiple Templates:** Built-in support for standard, detailed, minimal, and Jira-style formats.
- **Custom Templates:** Define your own markdown structure for specific project needs.
- **Vision Support:** Can analyze attached images to include findings in user stories.
- **Context Aware:** Incorporates links and provided context into references.

## Installation

### Prerequisites

- [Gemini CLI](https://github.com/google/gemini-cli) installed and configured.

### Quick Install

Run the provided installation script to clone the skill into your local agents directory:

```bash
chmod +x install.sh
./install.sh
```

Alternatively, you can manually clone the repository into your skills directory:

```bash
mkdir -p ~/.agents/skills/po-ba-user-stories
git clone https://github.com/nikkidoming0/po-ba-agent.git ~/.agents/skills/po-ba-user-stories
```

## Usage

1. **Activate the Skill:**
   In your Gemini CLI session, activate the skill by name:
   ```
   activate_skill po-ba-user-stories
   ```
   *Note: You can also use the `/skills` command to see all installed skills.*

2. **Provide Requirements:**
   Provide your epic title, context, and any specific template requirements.

   **Example:**
   ```
   Create user stories for a new login page using the "detailed" template. 
   Include requirements for social login (Google/GitHub).
   ```

### Built-in Templates

Use the command `Use template: [NAME]` to specify a format:

- `standard_user_story`: Includes Epic, User Stories, AC, Implementation Guide, and References.
- `detailed`: INVEST compliant stories, Gherkin style AC, NFRs, and Image Analysis.
- `minimal`: Outputs user stories only.
- `jira_style`: Formatted using Jira's markup language (h3, h4, etc.).

### Custom Templates

You can provide a custom structure by pasting a markdown block:

```markdown
Use this custom template:
# {{epic}}
- Feature: {{feature_name}}
- Story: {{story}}
- AC: {{acceptance_criteria}}
```

## Input Handling

- **Images:** If you attach images, the agent will analyze them with vision and include findings in the relevant sections.
- **Links:** All provided URLs will be categorized in the References section.
- **Clarification:** If the input is ambiguous, the agent will ask 1-2 short questions before generating the stories.

---
*Created by [nikkidoming0](https://github.com/nikkidoming0)*
