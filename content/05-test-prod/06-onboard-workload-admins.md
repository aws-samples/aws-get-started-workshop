---
title: 'Onboard Workload Admins to Test and Production AWS Accounts'
menuTitle: '6. Onboard Workload Admins'
disableToc: true
weight: 60
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

In this step either Security or Cloud Administrators will onboard your team members who will be granted access to administer your initial workloads in your test and production environments. 

This step should take about 30 minutes to complete.

## 1. Assemble onboarding documentation

Work with your cross-functional colleagues in Security, Compliance, and Finance to assemble the basic form of a getting started document and share it with the members of the initial builder teams so that they understand the fundamentals of their responsibilities, access permissions, and how to access and begin using their test and production workloads AWS accounts.

## 2. Create workload administrator group(s) in AWS SSO

Create a new group in AWS SSO for each of the groups of people would need administrative access to manage your initial workloads.  Associate these groups with an initial set of permissions and the respective test and production workloads AWS accounts.

Initially, you might need only a single workload administrator group.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`Groups`** in AWS SSO.
7. Select **`Create group`**.
8. Provide a group name. For example, replacing `example` with your organization's identifier:
  * `example-<workload_id>-admin`
9. Provide a description. For example:
  * `<workload identifier> Administrators`
10. Select **`Create`**.

## 3. Grant workload administrator groups access to test and production workload AWS accounts

Next, enable each workload administrator group to access the associated test and production workloads AWS accounts.

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

## 4. Add team members to the workload administrators group(s)

This assumes you've already created users in AWS SSO for team members who will administer the workload, or alternatively you've migrated to a federated access model.  If this is not the case, you can create new users by [following the process documented earlier in this guide.]({{< relref "06-onboard-builder-teams#create-builder-team-users" >}})

1. Access **`Groups`** in AWS SSO.
2. Select `example-<workload>-admin`.
3. Select **`Add users`**.
4. Select the checkbox for each team member who's expected to administer your workloads.
5. Select **`Add users`**.

The team members will now have access to the workload-specific test and production workloads AWS accounts.

## 5. Brief workload administrators

Meet with the team members who have been granted access to brief them on their access and their responsibilities.