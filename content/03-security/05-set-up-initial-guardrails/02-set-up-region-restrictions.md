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

{{< toc >}}

## 1. ...


https://controltower.aws-management.tools/security/restrict_regions/
https://aws-samples.github.io/aws-iam-permissions-guardrails/
https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples.html#examples_general
https://aws.amazon.com/blogs/security/how-to-use-service-control-policies-to-set-permission-guardrails-across-accounts-in-your-aws-organization/
https://asecure.cloud/a/scp_whitelist_region/

sample: (https://forums.aws.amazon.com/thread.jspa?messageID=896784)
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
}
}
}
]
}






https://aws-samples.github.io/aws-iam-permissions-guardrails/







