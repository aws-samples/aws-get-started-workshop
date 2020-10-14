---
title: 'Set Up Test and Production Access'
menuTitle: '5. Set Up Test and Prod Access'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

In this step either Security or Cloud Administrators will onboard a limited set of responsible analysts who will have access to the workload environments.  We will introduce IAM Permission Boundaries on the workload organizational units to constrain the set of IAM permissions that can be granted.  This will enable the access necessary to manage operational events in the workload account.

This step should take about 30 minutes to complete.

## 1. Distribute Permissions Boundary to Workload Test and Prod OUs

In this step you'll use AWS CloudFormation StackSets to distribute an IAM permissions boundary policy to the test and production OUs.  This boundary policy will help ensure that workload admin teams using workload AWS accounts can't modify your foundation cloud resources.  
{{% notice tip %}}
Since the permissions boundaries are placed at the OU level, this step only needs to be done once.  It will automatically be applied to any accounts placed into these OUs in the future.
{{% /notice %}}

### Download AWS CloudFormation Template

Next, download the sample AWS CloudFormation template [`example-infra-team-dev-boundary.yml`](/code-samples/01-iam-policies/example-infra-team-dev-boundary.yml) to your desktop.

### Deploy Permissions Boundary as a StackSet

Create a StackSet to deploy the permissions boundary policy to all AWS accounts associated with the test OUs.

1. Select **`Create StackSet`**.
2. Select **`Upload a template file`**.
3. Select **`Choose file`** to select the downloaded template file from your desktop.
4. Select **`Next`**.
5. Enter a **`StackSet name`**. For example, **`example-infra-team-prod-boundary`**.

It's useful to prefix your custom cloud resources that live in a larger name space with your organization identifier and a qualifier such as **`infra`** to represent foundation resources. The important consideration is to be consistent with naming of foundation cloud resources so that you can apply IAM policies that will inhibit unauthorized modification of those resources.

6. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`pOrg`**|Replace **`example`** with your organization identifier or stock ticker if that applies. This value is used as a prefix in the name of IAM managed policy that is created by the template.|

Leave the other parameters at their default settings.

7. Select **`Next`**.
8. Leave the **`Permissions`** set to **`Service managed permissions`**.
9. Select **`Next`**.
10. In **`Deployment targets`**, select **`Deploy to organizational units (OUs)`**.
11. Enter the OU IDs of the test OUs that you created previously.  

If you didn't make a copy of the test OU IDs, open a new browser tab and access **`AWS Control Tower`**. Select **`Organizational units`**, and select each of the following test OUs to obtain its OU ID:

* **`workloads_prod`**
* **`workloads_test`**

12. In **`Specify regions`**, select your home AWS region.
13. Select **`Next`**.
14. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
15. Select **`Submit`**.

Proceed to the next step.

## 3. Create Workload Admin Permission Set in AWS SSO

Next, you'll create a custom permission set in AWS SSO to represent the initial iteration of an AWS IAM policy under which workload administrators will work in the workload specific AWS accounts.

### Download and Customize Sample IAM Policy

1. Download the sample policy [`example-infra-team-dev-saml.json`](/code-samples/01-iam-policies/example-infra-team-dev-saml.json) to your desktop.
2. Open the file and replace all occurrences of **`example`** with a reference to your own organization's identifier.

### Create Permission Set in AWS SSO

1. Access **`AWS accounts`** in AWS SSO.
2. Select **`Permission sets`**.
3. Select **`Create permission set`**.
4. Select **`Create a custom permission set`**.
5. Enter a **`Name`**. For example **`example-workload-admin-team-<workload_id>`**.
6. Enter a **`Description`**. For example, **`Day-to-day permission used by admins in their workload test and prod AWS accounts.`**.
7. Set the **`Session duration`** to the desired value.
8. Select the checkbox **`Create a custom permissions policy`**.
9. Open the sample policy file that you just customized in a text editor, copy, and paste the content.

{{% notice warning %}}
**Replace `example` with your own identifier:** Before you select **`Create`**, in the permissions policy, ensure that you replace all occurrences of **`example`** with your own organization's identifier.  Otherwise, the permission set will not work as expected.
{{% /notice %}}

10. Select **`Create`**.

Later, when you onboard the workload admin teams to the new workload AWS accounts, you'll reference this permission set.

## 4. Create Workload Admin Group in AWS SSO

Create a new group in AWS SSO for each of the builder teams and associate those groups with an initial set of permissions and their respective team development AWS accounts.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`Groups`** in AWS SSO.
7. Select **`Create group`**.
8. Provide a group name. For example, replacing `example` with your organization's identifier:
  * `example-<workload_id>-admin`
9. Provide a description. For example:
  * `<workload identifier> Admin Team`
10. Select **`Create`**.

## 5. Grant Workload Admin Groups Access to Workload AWS Accounts

Next, enable each team development group to access the associated team development AWS account.

1. Access **`AWS accounts`** in AWS SSO.
2. Select the checkbox next to the workload-specific AWS accounts. For example:
  * `<workload>-test`
  * `<workload>-prod`
3. Select **`Assign users`**.
4. Select **`Groups`**.
5. Select the checkbox next to the `example-<workload>-admin` group you created in step 1.  
6. Select **`Next: Permission sets`**.
7. Select the checkbox next to **`example-<workload>-admin-team`**.
8. Select **`Finish`**.

## 6. Add Team Members to Workload Admin Group
This assumes you've already created users in AWS SSO for team members who will administer the workload, or alternatively you've migrated to a federated access model.  If this is not the case, you can create new users by [following the process documented earlier in this guide.]({{< relref "05-onboard-builder-teams#create-builder-team-users" >}})
1. Access **`Groups`** in AWS SSO.
2. Select `example-<workload>-admin`.
3. Select **`Add users`**.
4. Select the checkbox for each foundation team member.
5. Select **`Add users`**.

The foundation team members will now have access to the workload-specific AWS accounts.