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

In this step either Security or Cloud Administrators will onboard a limited set of responsible analysts who will have access to the workload environments.  We will introduce IAM Permission Boundaries on the workload organizational units to constrain the set of IAM permissions that can be granted.  This will enable the access necessary to manage operational events in the workload account.

This step should take about 30 minutes to complete.

## 1. Assemble Onboarding Documentation

Work with your cross-functional colleagues in Security, Compliance, and Finance to assemble the basic form of a getting started document and share it with the members of the initial builder teams so that they understand the fundamentals of their responsibilities, access permissions, and how to access and begin using their team development AWS accounts.

See the [Example Getting Started Guide for Builder Team Members]({{< relref "01-getting-started-guide-builder-team-members.md" >}}) as a recommended starting point.

## 2. Create Workload Admin Group in AWS SSO

Create a new group in AWS SSO for each of the builder teams and associate those groups with an initial set of permissions and their respective team development AWS accounts.

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
  * `<workload identifier> Admin Team`
10. Select **`Create`**.

## 3. Grant Workload Admin Groups Access to Workload AWS Accounts

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

## 4. Add Team Members to Workload Admin Group
This assumes you've already created users in AWS SSO for team members who will administer the workload, or alternatively you've migrated to a federated access model.  If this is not the case, you can create new users by [following the process documented earlier in this guide.]({{< relref "06-onboard-builder-teams#create-builder-team-users" >}})
1. Access **`Groups`** in AWS SSO.
2. Select `example-<workload>-admin`.
3. Select **`Add users`**.
4. Select the checkbox for each foundation team member.
5. Select **`Add users`**.

The foundation team members will now have access to the workload-specific AWS accounts.

## 5. Brief Workload Admins

Meet with the builder team members to brief them on their access and other topics covered in the [Example Getting Started Guide for Builder Team Members]({{< relref "01-getting-started-guide-builder-team-members" >}}).