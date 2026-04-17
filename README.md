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

Install the skill with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/nikkidoming0/po-ba-agent/dev/install.sh | bash
```

Alternatively, you can run the provided installation script locally:

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

## Input Handling (Images & Links)

The agent can process images and links to provide more accurate user stories and technical details.

### How to provide Images
You can provide images by dragging them into the chat or by referencing their local paths using the `@` symbol:

**Example 1: Drag and Drop**
> **Title:** New checkout flow
> **Context:** Mobile web app, improve conversion rate
> *[drag your screenshot or Figma export here]*
> **Use template:** detailed

**Example 2: Local File Reference**
> **Title:** Login screen redesign
> **Context:** Make it more secure and user-friendly
> `@./designs/login-v2.png`
> **Use template:** standard_user_story

**Supported Image Formats:**
- JPEG / JPG
- PNG
- GIF
- WebP

### How to provide Links
Include URLs directly in your request or prefix them with "Links:". The agent will categorize them in the References section.

**Example:**
> **Title:** Social login flow
> **Context:** Mobile-first e-commerce app. Support Google, Apple, and email/password. Must be accessible and secure.
> `@./login-screen-mockup.png`
> `@./figma-flow-diagram.png`
> **Links:** https://figma.com/design/abc123
> **Use template:** detailed

## Input Processing

- **Vision Analysis:** If you attach images, the agent will analyze them with vision and include findings in the relevant sections (e.g., Image Analysis or Acceptance Criteria).
- **References:** All provided URLs and image findings will be listed in the References & Attachments section.
- **Clarification:** If the input is ambiguous, the agent will ask 1-2 short questions BEFORE generating the stories.

---
*Created by [nikkidoming0](https://github.com/nikkidoming0)*
