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

## 🔄 Onboarding Workflow Architecture
sequenceDiagram
    autonumber
    participant User as 👤 Developer
    participant BS as 🧩 Backstage
    participant GH_New as 📁 New Project Repo
    participant GH_Auto as ⚙️ Automation Repo
    participant GH_Org as 🏢 GitHub Org

    User->>BS: Submit Onboarding Form
    
    rect rgb(240, 240, 240)
        Note over BS: Scaffolder Phase
        BS->>BS: Fetch & Template Files
        BS->>GH_New: Create Repo & Push Code
    end

    BS->>GH_Auto: Dispatch 'create-team.yml'
    
    rect rgb(230, 245, 230)
        Note over GH_Auto: GitHub Actions Phase
        GH_Auto->>GH_Org: Invite User
        GH_Auto->>GH_Org: Create Team
        GH_Auto->>GH_Org: Add User to Team
        GH_Auto->>GH_New: Grant Team Permissions
    end
    
    GH_Org-->>User: 📧 Invitation Sent

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

🚀 **Step-by-Step Execution**

### 1️⃣ User Triggers Onboarding
The user selects the **“Onboard User to Org”** tile in the Backstage UI.

* **GitHub Username**: The individual to be invited.
* **Repository Name**: The target project repository.
* **Team Name**: The specific GitHub team to manage the repo.

### 2️⃣ Backstage Scaffolder Executes Template
* **Step A (Fetch): Loads configuration from onboarding-skeleton/ and injects variables like githubUser.

* **Step B (Publish): Creates the repository quantum-lab-x/<repoName> with repoVisibility: public.

### 3️⃣ CODEOWNERS Applied Automatically
The template automatically generates the .github/CODEOWNERS file during the push:

* **Path: .github/CODEOWNERS
* **Content: * @quantum-lab-x/{{ values.teamName }}

### 4️⃣ Trigger GitHub Actions Automation
Backstage uses the github:actions:dispatch action to trigger the create-team.yml workflow.

* ** Target Repo: quantum-lab-x/platform-automation
* ** Event: workflow_dispatch

### 5️⃣ GitHub Actions Executes Org-Level Automation
Using the ORG_ADMIN_TOKEN stored as an Org Secret, the workflow executes:

* ** Invite User: Sends an official invitation to the organization.
* ** Create Team: Provisions the team quantum-lab-x/<teamName>.
* ** Add Member: Assigns the user to the new team.
* ** Grant Access: Links the team to the new repository with Push permissions.

✅ Final Automated State

---

## ✅ Final Automated State

| Component | Status | Description |
| :--- | :--- | :--- |
| **Repository** | ✅ Created | Hosted under quantum-lab-x |
| **Team** | ✅ Created | Dynamic name based on input |
| **User** | ✅ Invited | Official Org invitation sent |
| **Membership** | ✅ Added | User added to the new team |
| **Repo Access** | ✅ Granted | Team has write access to repo |

---
