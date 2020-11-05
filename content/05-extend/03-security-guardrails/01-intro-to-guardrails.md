---
title: 'Introduction to Security Guardrails for Your AWS Environment'
menuTitle: 'Introduction to Guardrails'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

## 1. Review AWS Control Tower strongly recommended and elective guardrails

AWS Control Tower provides a set of mandatory guardrails that are always applied.  You also have the option to enable strongly recommended and elective guardrails. You should review [Guardrails in AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) for how guardrails work in AWS Control Tower and review the [Guardrail Reference](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails-reference.html) to determine if any of the built-in guardrails are of interest to you at this time.

If any of these guardrails are of interest to you, you should consider applying them first to your test environments to validate that they meet your needs. See [Enabling Guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html#enable-guardrails) for more information.

{{% notice tip %}}
**Consider guardrails for your team development environments:** You may also find that some of the guardrails will be useful to apply to your team development environments.
{{% /notice %}}

## 2. Review other example guardrails

Beyond the guardrails that are available through AWS Control Tower, see [AWS IAM Permissions Guardrails](https://aws-samples.github.io/aws-iam-permissions-guardrails/guardrails/scp-guardrails.html) for additional examples of guardrails in the form of service control policies (SCPs) you may want to consider for your test and production environments.

If you don't need to apply additional guardrails at this time, you can skip to the next step.

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

## 3. Apply Guardrails to Test and Prod Workload OUs

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