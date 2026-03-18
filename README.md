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

### 🔄 End-to-End Onboarding Flow

```mermaid
sequenceDiagram
    autonumber
    participant User as 👤 Developer
    participant BS as 🧩 Backstage (Scaffolder)
    participant GH_New as 📁 New Repo (quantum-lab-x)
    participant GH_Auto as ⚙️ Platform Automation Repo
    participant GH_Org as 🏢 GitHub Organization

    User->>BS: Fills Template (User, Repo, Team)
    
    Note over BS: Step 1: Fetch Onboarding Files
    BS->>BS: Processes Skeleton & Injects variables

    Note over BS: Step 2: Create Onboarding Repo
    BS->>GH_New: Creates Public Repo
    BS->>GH_New: Pushes CODEOWNERS & onboard.yml

    Note over BS: Step 3: Trigger GitHub Action
    BS->>GH_Auto: Dispatch workflow: create-team.yml
    
    Note over GH_Auto: Step 4: Org Automation
    GH_Auto->>GH_Org: Invite User to Org
    GH_Auto->>GH_Org: Create GitHub Team
    GH_Auto->>GH_Org: Add User to Team
    GH_Auto->>GH_New: Grant Team Access
    
    GH_Org-->>User: 📧 Invitation Email Sent
```


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
