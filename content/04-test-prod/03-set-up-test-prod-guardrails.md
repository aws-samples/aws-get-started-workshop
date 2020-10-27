---
title: 'Set Up Test and Production Workload Guardrails'
menuTitle: '3. Set Up Test and Prod Guardrails'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

In this step your Security and Cloud Administrators will author and apply guardrails to protect the test and production workload organizational units.

This step should take about 20 minutes to complete.
{{< toc >}}

## 1. Review AWS Control Tower Optional Guardrails
AWS Control Tower comes with numerous optional guardrails that can be enabled on your OUs.  Many of these are strongly recommended.  As you come closer to running production workloads in AWS, you should become familiar with these and consider whether or not they should be applied.

Review [Guardrails in AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) and follow the documented process therein to apply them where deemed necessary.


## 2. Author Policy for Further Preventative Guardrails (If Required)
If the optional guardrails don't satisfy your governance requirements, you can create a Service Control Policy to enable preventative controls on all workload accounts.  Otherwise you may skip this step and proceed to step 3 below.

{{% notice tip %}}
**Avoid overly restrictive policies:** Because the policies are applied at the OU level, you  will generally want to avoid being overly restrictive.  SCPs will be applied to every account in the OU and cannot be overrode by individual accounts.  Cloud administrators can leverage IAM in the individual accounts to provide further workload-specific guardrails.  You can also use detective guardrails to trigger exception handling processes.
{{% /notice %}}

{{% notice tip %}}
The default configuration of AWS Organizations supports using SCPs to explicitly deny services and/or regions.  Please review [Strategies for using SCPs](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_strategies.html) for more details
{{% /notice %}}

### Example: Restriction on AWS Region Usage
One common use case of SCPs is to enforce workloads being placed in specific AWS Regions.  Here's an example policy that restricts deployments outside of US regions while still allowing AWS Control Tower to function.  The `StringNotLike` combines with the `aws:RequestedRegion` while excluding global services and AWS Control Tower execution roles.
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SCPRegionalDeny",
            "Effect": "Deny",
            "NotAction": [
                "a4b:*",
                "acm:*",
                "aws-marketplace-management:*",
                "aws-marketplace:*",
                "aws-portal:*",
                "awsbillingconsole:*",
                "budgets:*",
                "ce:*",
                "chime:*",
                "cloudfront:*",
                "config:*",
                "cur:*",
                "directconnect:*",
                "ec2:DescribeRegions",
                "ec2:DescribeTransitGateways",
                "ec2:DescribeVpnGateways",
                "fms:*",
                "globalaccelerator:*",
                "health:*",
                "iam:*",
                "importexport:*",
                "kms:*",
                "mobileanalytics:*",
                "networkmanager:*",
                "organizations:*",
                "pricing:*",
                "route53:*",
                "route53domains:*",
                "s3:GetAccountPublic*",
                "s3:ListAllMyBuckets",
                "s3:ListBuckets",
                "s3:PutAccountPublic*",
                "shield:*",
                "sts:*",
                "support:*",
                "trustedadvisor:*",
                "waf-regional:*",
                "waf:*",
                "wafv2:*",
                "wellarchitected:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1",
                        "us-east-2"
                    ]
                },
                "ArnNotLike": {
                    "aws:PrincipalARN": [
                        "arn:aws:iam::*:role/AWSCloudFormationStackSetExecutionRole",
                        "arn:aws:iam::*:role/AWSControlTowerExecution"
                    ]
                }
            }
        }
    ]
}
```

### SCP Example: Require Certain Type of EC2 Instance
EC2 Instance (Savings Plans)[https://aws.amazon.com/savingsplans/] provide the lowest prices, offering savings up to 72% in exchange for commitment to usage of individual instance families in a region.  Since savings plans can be shared amongst an entire organization, you might want to build a policy to ensure workloads are always using EC2s from the correct family.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "RequireR5InstanceType",
      "Effect": "Deny",
      "Action": "ec2:RunInstances",
      "Resource": "arn:aws:ec2:*:*:instance/*",
      "Condition": {
        "StringNotLike":{               	
          "ec2:InstanceType":"r5.*"
        }
      }
    }
  ]
}
```

{{% notice warning %}}
**Service Control Policies (SCPs) and AWS Control Tower:** You need to be very careful when using customer-managed SCPs with AWS Control Tower so that your SCPs do not conflict with the new AWS account baselining processes carried out by AWS Control Tower Account Factory. See [Controlling Builder Team Access]({{< relref "02-controlling-builder-team-access#scps" >}}) for further details and an example of how to avoid such potential conflicts.
{{% /notice %}}

### Create the SCPs
Once you've determined the correct content of the SCP that you want to apply to the `workloads` OUs, have your Cloud Administration team create it.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Organizations`**.
6. Select **`Policies`**.
7. Select **`Service control policies`**
8. Select **`Create policy`**.
9. Create a new SCP:
    * Policy name: **`example-workload-scp`**
    * Description: fill in based on the intent of your policy
    * Policy: Copy the content of the sample policy.

## 2. Apply Guardrails to Test and Prod Workload OUs

Using AWS Organizations, create Service Control Policies (SCPs) that will be applied to the `workloads_prod` and `workloads_test` organizational units.  Service Control Policies are the protective guardrails that define the maximum level of permission that can be granted.  When an SCP is applied to an OU, it will be effective to all accounts under that OU.  When you established the dev team account, you created SCPs to protect against creating and modifying foundation VPC networking resources.

{{% notice warning %}}
**Test your SCPs before using them in a production capacity.** Remember that an SCP affects every user and role and even the root user in every account that it's attached to.  Deploying and testing the workload to the workload's test account will exercise the SCP before it's applied to the production OU.
{{% /notice %}}

### Apply the SCPs to the `workloads` test and prod OU

1. Select **`Organize accounts`**.
2. In the Organization tree on the left, select the **`workloads_test`** OU.
3. On the right side of the console, select **`Service control policies`**.
4. On the right side of the console, select the **`Attach`** link next to the SCPs and select the SCP you created in step 1.

{{% notice warning %}}
**Test your SCPs before using them in production:** Remember that an SCP affects every user and role and even the root user in every account that it's attached to.  Deploying and testing the workload to the workload's test account will exercise the SCP before it's applied to the production OU.
{{% /notice %}}

Repeat the above step for the `workloads_prod` OU.

## 3. Distribute Permissions Boundary to Test and Prod OUs

In this step you'll use AWS CloudFormation StackSets to distribute an IAM permissions boundary policy to the test OUs.  This boundary policy will help ensure that workload admin teams using workload AWS accounts can't modify your foundation cloud resources.

In a later section, when you create several team test AWS accounts, you will associate the AWS accounts with the test OUs. Any AWS account that is added to the test OUs will automatically be configured with the IAM permissions boundary policy resource.  Similarly, when an AWS account is removed from the OUs, the IAM permissions boundary policy resource will be automatically removed from the AWS account.

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

{{% notice tip %}}
If you didn't make a copy of the test OU IDs, open a new browser tab and access **`AWS Control Tower`**. Select **`Organizational units`**, and select each of the following OUs to obtain its OU ID:

* **`workloads_prod`**
* **`workloads_test`**

OUs entered should be in the format `ou-xxxx-yyyyyyy`
{{% /notice %}}
12. In **`Specify regions`**, select your home AWS region.

{{% notice tip %}}
Because IAM is a global service, you only create the policies in one region and they will be accessible in all other regions for the given account.  If you try to create in a second region, they will fail.
{{% /notice %}}
13. Select **`Next`**.
14. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
15. Select **`Submit`**.

Since you have not yet created the team test AWS accounts, this CloudFormation StackSet won't create CloudFormation stacks in the team test AWS accounts until those AWS accounts are created in a subsequent section.

Proceed to the next step.

## 4. Create Workload Admin Team Permission Set in AWS SSO

Next, you'll create a custom permission set in AWS SSO to represent the initial iteration of an AWS IAM policy under which builder team members will work in the workload production AWS accounts.

### Download and Customize Sample IAM Policy

1. Download the sample policy [`example-infra-team-dev-saml.json`](/code-samples/iam-policies/example-infra-team-dev-saml.json) to your desktop.
2. Open the file and replace all occurrences of **`example`** with a reference to your own organization's identifier.

### Create Permission Set in AWS SSO
1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Single Sign-On`** service.
6. Access **`AWS accounts`** in AWS SSO.
7. Select **`Permission sets`**.
8. Select **`Create permission set`**.
9. Select **`Create a custom permission set`**.
10. Enter a **`Name`**. For example **`example-infra-team-test`**.
11. Enter a **`Description`**. For example, **`Day-to-day permission used by admins in their workload test and prod AWS accounts.`**.
12. Set the **`Session duration`** to the desired value.
13. Select *both* checkboxes under  **`What policies do you want to include in your permission set`**.
14. Under **`Attach AWS Managed polices`, search for `SystemAdministrator` and select it.
15. Open the sample policy file that you just customized in a text editor, copy the content.
16. Paste it into the textbox under **`Create a custom permissions policy`**

{{% notice warning %}}
**Replace `example` with your own identifier:** Before you select **`Create`**, in the permissions policy, ensure that you replace all occurrences of **`example`** with your own organization's identifier.  Otherwise, the permission set will not work as expected.
{{% /notice %}}

15. Select **`Create`**.

Later, when you onboard the workload admin teams to the new workload AWS accounts, you'll reference this permission set.
