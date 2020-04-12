---
title: "Onboard Foundation Team"
pre: "4. "
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step either your Security or Cloud Administrators will onboard the few people that make up the initial foundation team so that they can stop using system users and start using their own user accounts to manage the foundation.

This step should take about 20 minutes to complete.

{{< toc >}}

## 1. Create AWS SSO Users for Foundation Team Users

In prepartion for adding foundation team users to AWS SSO, decide on the format of the user name.  Typically, the user name will simply be the user's corporate email address that is often used for SaaS services.

Next, access the AWS SSO service to begin adding an AWS SSO user for each foundation team member:

1. If you don't already have a personal user account with administrator access, sign in to the AWS SSO URL for your environment using the **`AWS Control Tower Administrator`** user.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`Users`** in AWS SSO.
7. Select **`Add user`**.
8. Specify a user name and complete at least the other required fields.
9. Select **`Next: Groups`**.
10. Select the checkbox for each corresponding AWS SSO group based on [Mapping of Functional Roles to AWS SSO Groups]({{< relref "03-set-up-aws-platform-access-controls.md#2-map-foundation-functional-roles-to-existing-aws-groups" >}}).
11. Select **`Add user`**.

## 2. Onboard Your Foundation Team Members 

Reach out to each foundation team member to inform them of the context of the email message they received, what they should do next, and what access they have been granted.

Their initial sign on experience will consist of:

1. Receiving the email invitation to the AWS SSO service.
1. Clicking on the **`Accept invitation`** link to set their initial password.
3. Being directed to AWS SSO landing page where they can select from the set of AWS accounts for which they have access.
4. Selecting from the permissions that they can assume for each AWS account.
5. Using either the AWS Management Console or AWS CLI/API to access each AWS account.

Inform the foundation team members that use of MFA is required and how they can [register an MFA device](https://docs.aws.amazon.com/singlesignon/latest/userguide/how-to-register-device.html) on their own via the AWS SSO service.

## 3. Stop Using the AWS Control Tower Administrative User

Since you've onboarded foundation team members with the appropriate permissions, as a security and compliance best practice, there's no longer any reason for your Cloud Administrators to use the AWS Control Tower Administrator user. 

From this point forward, the vast majority of your work to administer and manage your AWS environment should be done via your personal users that are defined in AWS SSO.  By using personal users, all operations will be auditable and tied to specific individuals.

## 4. Brief Foundation Team Members

Meet with the foundation team members to brief them on their access, responsibilities, and other topics covered in the [Example Getting Started Guide for Foundation Team Members]({{< relref "01-getting-started-guide-foundation-team-members.md" >}}).