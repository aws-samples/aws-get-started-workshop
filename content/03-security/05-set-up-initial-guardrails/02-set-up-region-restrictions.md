---
title: 'Set Up AWS Region Restriction Guardrail'
menuTitle: '2. Set Up Region Restriction'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section addresses how to set up restrictions as to which AWS Regions can be used throughout your AWS environment.
In order to ensure your resources are not accidentally created in the wrong region, you can setup a service control policy to disable those regions.
Below is an example of how you can implement this in an SCP as well as resource material to learn more on how this works.

Here is an example of a region restriction SCP.  This SCP is restricting the organization to only be able to use the `eu-central-1` and `eu-west-1` regions.
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAllOutsideEU",
            "Effect": "Deny",
            "NotAction": [
                "iam:*",
                "organizations:*",
                "route53:*",
                "budgets:*",
                "waf:*",
                "cloudfront:*",
                "globalaccelerator:*",
                "importexport:*",
                "support:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "eu-central-1",
                        "eu-west-1"
                    ]
                },
                "ArnNotLike": {
                    "aws:PrincipalARN": [
                        "arn:aws:iam::*:role/AWSControlTowerAdmin",
                        "arn:aws:iam::*:role/AWSControlTowerCloudTrailRole",
                        "arn:aws:iam::*:role/AWSControlTowerStackSetRole",
                        "arn:aws:iam::*:role/*ControlTower*",
                        "arn:aws:iam::*:role/*controltower*"
                    ]
                }
            }
        }
    ]
}
```

More details can be found [Control Tower Activation Day content](https://controltower.aws-management.tools/security/restrict_regions/) and in the [Control Tower AWS documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples.html#examples_general).

Below are additional resources to find out more on how to use region restrictions as well as whet the different details of the SCP are.
- [AWS Samples - AWS IAM Permission Guardrails](https://aws-samples.github.io/aws-iam-permissions-guardrails/)
- [AWS Organizations - General Examples](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples.html#examples_general)
- [AWS Security Blog - How to use service control policies to set permission guardrails across accounts in your AWS Organization](https://aws.amazon.com/blogs/security/how-to-use-service-control-policies-to-set-permission-guardrails-across-accounts-in-your-aws-organization/)