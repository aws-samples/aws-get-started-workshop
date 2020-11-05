---
title: 'Set Up Team Development Environment Guardrails'
menuTitle: '3. Set Up Team Dev Guardrails'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section your Security and Cloud Administrators will provision resources to act as overall guardrails for controlling access within your team development AWS accounts. 

Service control policies (SCPs) are used to constrain the ability to modify cloud networking resources in your team development environments. An IAM permissions boundary is distributed as a means to constrain your builders from modifying foundation resources in your team development environment.

This step should take about 20 minutes to complete.

{{% notice tip %}}
**Learn more about guardrails:** See [Security Guardrails]({{< relref "03-security-guardrails" >}}) for an introduction to the use of guardrails that you can apply to your AWS environments.  Guardrails provide a means for your Security and Cloud Administrators to apply overall controls on what can be done in your AWS environment. You might start with a basic set of guardrails and expand them as you gain experience and your needs evolve.
{{% /notice %}}

{{< toc >}}

## 1. Apply Service Control Policies (SCPs)

{{% notice tip %}}
**Automated provisioning of resources:** Ideally, you would use automation to deploy policies and other configurations to your AWS accounts. [Customizations for AWS Control Tower](https://aws.amazon.com/solutions/customizations-for-aws-control-tower/) is an AWS solution that uses AWS services including AWS CodePipeline and [AWS Control Tower Lifecycle Events](https://docs.aws.amazon.com/controltower/latest/userguide/lifecycle-events.html) to help you more efficiently manage these types of resources as code and via pipelines. Both the SCPs and IAM permissions boundary policy resources addressed below are candidates for using this automation solution.
{{% /notice %}}

Using AWS Organizations, create several Service Control Policies (SCPs) that will initially be applied to the `workloads_dev` OU.  Combined, these SCPs will disallow any user from creating and modifying foundation VPC networking resources in standard team development AWS accounts.

Since you'll likely want your Cloud Foundation team members to be able to develop and test changes to foundation VPC resources in their team development AWS accounts, it's recommended that you don't want to apply the SCPs to the `infrastructure_dev` OU.

{{% notice tip %}}
**Service Control Policies (SCPs):** If you'd like to learn more about SCPs, see [Managing AWS Organizations policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html).
{{% /notice %}}

{{% notice tip %}}
**Review the sample team development access controls:** See [Controlling Builder Team Access]({{< relref "02-controlling-builder-team-access" >}}) for a detailed explanation of the requirements and sample implementation of how you can provide freedom to your builder teams in their team development AWS accounts, but inhibit them from adversely impacting the security of your overall AWS environment.
{{% /notice %}}

{{% notice warning %}}
**Service Control Policies (SCPs) and AWS Control Tower:** You need to be very careful when using customer-managed SCPs with AWS Control Tower so that your SCPs do not conflict with the new AWS account baselining processes carried out by AWS Control Tower Account Factory. See [Controlling Builder Team Access]({{< relref "02-controlling-builder-team-access#scps" >}}) for further details and an example of how to avoid such potential conflicts.
{{% /notice %}}

### Create the SCPs

Either open in a separate browser tab or download to your desktop the following sample SCPs:
* [`example-infra-scp-vpc-core.json`](/code-samples/scps/example-infra-scp-vpc-core.json)
* [`example-infra-scp-vpc-boundaries.json`](/code-samples/scps/example-infra-scp-vpc-boundaries.json)

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Organizations`**.
6. Select **`Policies`**.
7. Select **`Service control policies`**
8. Select **`Create policy`**.
9. Create a new SCP:
    * Policy name: **`example-infra-scp-vpc-core`** 
    * Description: **"Deny creation of and changes to core VPC resources"**
    * Policy: Copy the content of the sample policy.
10. Repeat steps 8-9 in order to create the second SCP:
    * Policy name: **`example-infra-scp-vpc-boundaries`** 
    * Description: **"Deny creation of and changes to boundary VPC resources"**
    * Policy: Copy the content of the sample policy.

### Apply the SCPs to the `workloads_dev` OU

1. Select **`Organize accounts`**.
2. In the Organization tree on the left, select the **`workloads_dev`** OU.
3. On the right side of the console, select **`Service control policies`**.
4. On the right side of the console, select the **`Attach`** link next to the SCPs
    * **`example-infra-scp-vpc-core`**
    * **`example-infra-scp-vpc-boundaries`**

## 2. Distribute Permissions Boundary to Development OUs

In this step you'll use AWS CloudFormation StackSets to distribute an IAM permissions boundary policy to the development OUs.  This boundary policy will help ensure that builder teams using team development AWS accounts can't modify your foundation cloud resources.

In a later section, when you create several team development AWS accounts, you will associate the AWS accounts with the development OUs. Any AWS account that is added to the development OUs will automatically be configured with the IAM permissions boundary policy resource.  Similarly, when an AWS account is removed from the OUs, the IAM permissions boundary policy resource will be automatically removed from the AWS account.

### Enable Trusted Access in AWS Organizations

First, enable the AWS CloudFormation service to automatically configure permissions required to use the CloudFormation StackSets feature to deploy stacks to AWS accounts in your AWS organization.

1. Navigate to **`AWS CloudFormation`**.
2. Select **`StackSets`**.
3. Select **`Enable trusted access`**.

{{% notice info %}}
**This is a one time operation:** If you'd like more background, see [Enabling Trusted Access with AWS Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-enable-trusted-access.html).
{{% /notice %}}

### Download AWS CloudFormation Template

Next, download the sample AWS CloudFormation template [`example-infra-team-dev-boundary.yml`](/code-samples/iam-policies/example-infra-team-dev-boundary.yml) to your desktop.

### Deploy Permissions Boundary as a StackSet

Create a StackSet to deploy the permissions boundary policy to all AWS accounts associated with the development OUs. 

1. Select **`Create StackSet`**.
2. Select **`Upload a template file`**.
3. Select **`Choose file`** to select the downloaded template file from your desktop.
4. Select **`Next`**.
5. Enter a **`StackSet name`**. For example, **`example-infra-team-dev-boundary`**. 

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
11. Enter the OU IDs of the development OUs that you created previously.  

If you didn't make a copy of the development OU IDs, open a new browser tab and access **`AWS Control Tower`**. Select **`Organizational units`**, and select each of the following development OUs to obtain its OU ID:

* **`infrastructure_dev`**
* **`workloads_dev`**

12. In **`Specify regions`**, select your home AWS region.
13. Select **`Next`**.
14. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
15. Select **`Submit`**.

Since you have not yet created the team development AWS accounts, this CloudFormation StackSet won't create CloudFormation stacks in the team development AWS accounts until those AWS accounts are created in a subsequent section.