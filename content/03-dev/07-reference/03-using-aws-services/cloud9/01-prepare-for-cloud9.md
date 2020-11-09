---
title: "Establish IAM Service Role for AWS Cloud9"
menuTitle: "Prepare for AWS Cloud9"
disableToc: true
weight: 10
---

This section describes the one-time task to set up the automation to create an IAM service role for EC2 that needs to be performed by your Cloud Administration team in order for you to use AWS Cloud9 in your team development AWS accounts.

{{% notice info %}}
**Engage your Cloud Administration team for this one-time set up step:** Since elevated privileges are needed for this step, you'll need to engage your Cloud Administration team to address it. Once this step is addressed, you'll be able to self-service create Cloud9 environments in your team development AWS accounts.
{{% /notice %}}

{{< toc >}}

## 1. Review why an IAM service role is required

In your team development AWS accounts, you have access to only private subnets.  Although AWS Cloud9 supports the use of private subnets, Cloud9 requires creation of a Cloud9-specific IAM service role for EC2 to support use of private subnets.  Since the guardrails that apply to your team development AWS accounts don't allow you as a builder to create IAM roles that start with `AWS*`, you'll need to ask your Cloud Administration team to get the following role in place before you can use Cloud9 in your private development subnets.

## 2. Download AWS CloudFormation template

As a Cloud Administrator, you will use AWS CloudFormation to deploy a CloudFormation StackSet to your organization's management AWS account. This StackSet will be based on a CloudFormation template.

Download the following CloudFormation template to your desktop: [example-infra-team-dev-cloud9-service-role.yml](/code-samples/iam-roles/example-infra-team-dev-cloud9-service-role.yml)

## 3. Deploy a StackSet to provision the IAM role for Cloud9

Create a StackSet to deploy the IAM service role for EC2 to all of the AWS accounts associated with your development OUs.

1. As a **Cloud Administrator**, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Navigate to the **`CloudFormation`** service
5. Open the left menu and select **`StackSets`**

Now create the StackSet:

1. Select **`Create StackSet`**.
2. Select **`Upload a template file`**.
3. Select **`Choose file`** to select the downloaded template file from your desktop.
4. Select **`Next`**.
5. Enter **`example-infra-team-dev-cloud9-iam-role`** for the **`StackSet name`**. Replace **`example`** with your organizational identifier.
6. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`pPermissionsBoundaryName`**|Provide the name of the permissions boundary that has been used as a guardrail for your team development AWS accounts. For example, `example-infra-team-dev-boundary`, but replace `example` with your own organizational identifier.|

7. Select **`Next`**.
8. Leave the **`Permissions`** set to **`Service managed permissions`**.
9. Select **`Next`**.
10. In **`Deployment targets`**, select **`Deploy to organizational units (OUs)`**.
11. Enter the OU IDs of the development OUs that you created previously.  

If you didn't make a copy of the development OU IDs, open a new browser tab and access **`AWS Control Tower`**. Select **`Organizational units`**, and select each of the following development OUs to obtain its OU ID:

* **`infrastructure_dev`**
* **`workloads_dev`**

12. In **`Specify regions`**, select your home AWS region.
13. Select **`Next`**.
14. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
15. Select **`Submit`**.

Monitor the operation to create the StackSet. Select **`Stack instances`** tab to see the status of the stack being applied to the AWS accounts.

When this StackSet is created, the associated CloudFormation stack is applied to each of the AWS accounts currently associated with the specified OUs.  

Additionally, each time a new AWS account is added to the OUs, the CloudFormation stack will be automatically applied to it. When AWS accounts are removed from the OUs, the stack will be automatically removed from the AWS accounts.

Once the CloudFormation stack has been applied to an AWS account, the builders with access to the AWS account will be able to self-service create Cloud9 environments according to the instructions in the next section.