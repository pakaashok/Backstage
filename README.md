# [Backstage](https://backstage.io)

This is your newly scaffolded Backstage App, Good Luck!

To start the app, run:

```sh
yarn install
yarn start
```

# 🧩 🏗️ Organization Onboarding Workflow

## 🎯 Objective
Automate GitHub onboarding for the **quantum-lab-x** organization using **Backstage** and **GitHub Actions**.

---

## 🔄 End-to-End Flow
> **User** → **Backstage Template** → **GitHub Repo Creation** → **GitHub Actions** → **Org Setup**

### 📊 Visual Workflow (Architecture)

```mermaid
graph TD
    A[User Selection: Onboarding Tile] --> B[Backstage Scaffolder]
    B --> C[Step 1: Fetch Skeleton Files]
    B --> D[Step 2: Create Public Repo]
    D --> E[Trigger: github:actions:dispatch]
    E --> F[Workflow: create-team.yml]
    F --> G[GitHub API: Invite User]
    F --> H[GitHub API: Create Team]
    F --> I[GitHub API: Assign Team to Repo]
    F --> J[GitHub API: Add User to Team]
```

🚀 Step-by-Step Execution
1️⃣ User Triggers Onboarding
The user selects the “Onboard User to Org” tile in Backstage.

**Inputs: GitHub Username, Repository Name, and Team Name.
