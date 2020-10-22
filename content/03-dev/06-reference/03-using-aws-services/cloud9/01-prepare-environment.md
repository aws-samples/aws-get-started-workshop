---
title: "Prepare Dev Workload OU for AWS Cloud9"
menuTitle: "Prepare Dev Workload OU for AWS Cloud9"
disableToc: true
weight: 10
---

## Configure IAM Roles for Cloud9 Private Subnet Instances
The following task is required if you are intending to deploy Cloud9 instances in the shared private subnets.  The Cloud Administration team will need to onboard the necessary IAM roles to enable Cloud9 to be accessed via [AWS Systems Manager](https://aws.amazon.com/systems-manager).

### Download CloudFormation Template
Download the following file to your desktop: [cloud9-roles.yaml](/code-samples/iam-roles/cloud9-roles.yaml)

### Deploy as StackSet
Create a StackSet to deploy the permissions boundary policy to all AWS accounts associated with the development OUs.
1. As a **Cloud Administrator**, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Navigate to the **`CloudFormation`** service
5. Open the left menu and select **`StackSets`**
6. Select **`Create StackSet`**.
7. Select **`Upload a template file`**.
8. Select **`Choose file`** to select the downloaded template file from your desktop.
9. Select **`Next`**.
10. Enter **`cloud9-iam-roles`** for the **`StackSet name`**.
11. Select **`Next`**.
12. Leave the **`Permissions`** set to **`Service managed permissions`**.
13. Select **`Next`**.
14. In **`Deployment targets`**, select **`Deploy to organizational units (OUs)`**.
15. Enter the OU IDs of the development OUs that you created previously.  

IAM users in the **`workload_dev`** OUs should now be able to spin up instances of Cloud9 using the procedure in the following page
