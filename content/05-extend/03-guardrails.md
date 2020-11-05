---
title: 'Security, Operations, and Compliance Guardrails for Your AWS Environment'
menuTitle: 'Environment Guardrails'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section introduces guardrails, highlights how a set of predefined guardrails are readily available via AWS Control Tower, and provides reference to additional examples of guardrails.

{{< toc >}}

## Introduction to guardrails

Guardrails are governance rules for security, operations, and compliance that customers can select and apply enterprise-wide or to specific groups of accounts. 

Guardrails protect users from making dangerous choices. While they can generally be overridden, we recommend that you make guardrails visible to the users of your AWS environment, so that they understand the choices they are making. A good guardrail should focus on the threat model and help mitigate a threat while using the underlying capability. As opposed to the guardrail either summarily denying use of a capability or making it impractical to use the capability.

## Types of guardrails

Guardrails are classified as either preventative or detective. 

**Preventive guardrails** establish intent and prevent deployment of resources that don’t conform to your policies. For example, require AWS CloudTrail to be enabled in all accounts. 

**Detective guardrails** continuously monitor deployed resources for nonconformance and generate alerts when nonconformance is detected.  You can automate response to alerts to take action. For example, disallow public read access to Amazon S3 buckets.

## Implementation forms of guardrails

Guardrails are commonly implemented in the form of:

* AWS Organizations service control policies (SCPs)
* AWS Config rules
* AWS IAM permission boundaries

If you used this guide to set up your team development environments, you've already experienced deploying SCPs and an IAM permission boundary to help constrain the overall access in your team development environments.

## Using service control policies (SCPs)

You should review [Service control policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) for an introduction to SCPs.  Additionally, review [Strategies for using SCPs](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_strategies.html) to learn more about the differences between allow and deny lists.

Since an SCP that is applied to an AWS Organizations OU will automatically apply to every account in the OU, you should be careful about testing and applying SCPs.

## AWS Control Tower and guardrails

AWS Control Tower provides a built-in set of mandatory guardrails that are always applied to your AWS environment.  You also have the option to enable strongly recommended and elective guardrails. 

You should review [Guardrails in AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) for how guardrails work in AWS Control Tower.

You should also review the [AWS Control Tower Guardrail Reference](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails-reference.html) to determine if any of the built-in guardrails are of interest to you at this time.

If any of these guardrails are of interest to you, you should consider applying them to the OUs in your AWS environment based on your requirements. In generally, it's recommended that you apply largely the same guardrails across your test and production environments so that your teams can test changes to their workloads in the context of the same or very similar guardrails that are in effect in your production environments.

Since guardrails apply to an OU and the AWS accounts in the OU, you should test guardrails in your development and test environments before applying them to your production OUs.

See [Enabling Guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html#enable-guardrails) for more information.

For an end-to-end example of using guardrails with AWS Control Tower, see [How to Detect and Mitigate Guardrail Violation with AWS Control Tower](https://aws.amazon.com/blogs/mt/how-to-detect-and-mitigate-guardrail-violation-with-aws-control-tower/).

## Other example guardrails

Beyond the guardrails that are available through AWS Control Tower, see 

* [Example service control policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples.html)
* [AWS IAM Permissions Guardrails](https://aws-samples.github.io/aws-iam-permissions-guardrails/guardrails/scp-guardrails.html) for common examples of guardrails in the form of service control policies (SCPs).

## Using custom SCPs with AWS Control Tower

When you're using AWS Control Tower, you need to be very careful when using your own custom SCPs.  You'll need to ensure that your custom SCPs do not conflict with the new AWS account baselining processes carried out by AWS Control Tower's Account Factory.

Since your custom SCPs applied to OUs would be applied automatically as soon as an AWS account joins the OU, they will likely be in effect before the Control Tower Account Factory completes its baseline tasks. If there's a conflict between your customer SCP and the actions that the Account Factory needs to perform, provisioning of the new account may fail.

In the following partial example of an SCP, note the use of a condition on the policy so that AWS Control Tower's use of its own AWS CloudFormation StackSet execution role is excluded from the policy.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
...
            ],
            "Resource": "*",
            "Condition": {
                "ArnNotLike": {
                    "aws:PrincipalARN": [
                        "arn:aws:iam::*:role/AWSControlTowerExecution"
                    ]
                }
            }
        },
        ...
```