---
title: 'Set Up Test and Production Workload Guardrails'
menuTitle: '2. Set Up Test and Prod Guardrails'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section your Security and Cloud Administrators will provision an initial set of security guardrails for controlling access within your test and production workloads AWS accounts.

{{% notice tip %}}
**Learn more about guardrails:** See [Environment Guardrails]({{< relref "03-guardrails" >}}) for an introduction to the use of guardrails that you can apply to your AWS environments.  Guardrails are governance rules for security, operations, and compliance that customers can select and apply enterprise-wide or to specific groups of accounts. You might start with a basic set of guardrails and expand them as you gain experience and your needs evolve.
{{% /notice %}}

This step should take about 15 minutes to complete.

## Distribute permissions boundary to test and production OUs

We recommend that you apply at least the following guardrail that will help inhibit your workload administrators from modifying the underlying foundation of the test and production workloads environments.

In this step you'll use AWS CloudFormation StackSets to distribute an IAM permissions boundary policy to the test and production workloads OUs.

In a later section, when you create your initial set of test and production workloads AWS accounts, you will associate the AWS accounts with the test and production workloads OUs. 

Any AWS account that is added to the test and production workloads OUs will automatically be configured with the IAM permissions boundary policy resource.  Similarly, when an AWS account is removed from the OUs, the IAM permissions boundary policy resource will be automatically removed from the AWS account.

### Download AWS CloudFormation Template

Next, download the sample AWS CloudFormation template [`example-infra-team-dev-boundary.yml`](/code-samples/iam-policies/example-infra-team-dev-boundary.yml) to your desktop.

### Deploy Permissions Boundary as a StackSet

Create a StackSet to deploy the permissions boundary policy to all AWS accounts associated with the test OUs.
1. Navigate to **CloudFormation** from the Services menu.
2. Pull out the left menu and select **`StackSets`**.
3. Select **`Create StackSet`**.
3. Select **`Upload a template file`**.
4. Select **`Choose file`** to select the downloaded template file from your desktop.
5. Select **`Next`**.
6. Enter a **`StackSet name`**. For example, **`example-infra-team-prod-boundary`**.

It's useful to prefix your custom cloud resources that live in a larger name space with your organization identifier and a qualifier such as **`infra`** to represent foundation resources. The important consideration is to be consistent with naming of foundation cloud resources so that you can apply IAM policies that will inhibit unauthorized modification of those resources.

7. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`pOrg`**|Replace **`example`** with your organization identifier or stock ticker if that applies. This value is used as a prefix in the name of IAM managed policy that is created by the template.|

Leave the other parameters at their default settings.

8. Select **`Next`**.
9. Leave the **`Permissions`** set to **`Service managed permissions`**.
10. Select **`Next`**.
11. In **`Deployment targets`**, select **`Deploy to organizational units (OUs)`**.
12. Enter the OU IDs of the test OUs that you created previously.  

{{% notice tip %}}
If you didn't make a copy of the test OU IDs, open a new browser tab and access **`AWS Control Tower`**. Select **`Organizational units`**, and select each of the following OUs to obtain its OU ID:

* **`workloads_prod`**
* **`workloads_test`**

OUs entered should be in the format `ou-xxxx-yyyyyyy`
{{% /notice %}}
13. In **`Specify regions`**, select your home AWS region.

{{% notice info %}}
Because IAM is a global service, you only create the policies in one region and they will be accessible in all other regions for the given account.  If you try to create in a second region, they will fail.
{{% /notice %}}

14. Select **`Next`**.
15. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
16. Select **`Submit`**.

Since you have not yet created the test and production workload AWS accounts, this CloudFormation StackSet won't create CloudFormation stacks in the test and production workloads AWS accounts until those AWS accounts are created in a subsequent section.