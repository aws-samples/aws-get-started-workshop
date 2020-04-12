---
title: "Using AWS Services in Team Development Environments"
menuTitle: "Using AWS Services"
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

The following documents address how builders can access a variety of AWS services in a self-service manner in their team development AWS accounts.

## Special Considerations

Why do buider teams need special instructions to use AWS services in their team development AWS accounts?

**Use of Shared Private Subnets**

Since you may come across examples and documentation that includes creation of VPC resources and you don't have permissions to create VPC resources in team development AWS accounts, you will need to understand how to reuse the existing shared private subnets to which your teams have access in your team development AWS accounts.

**Creation of AWS Service IAM Roles**

Since the use of many AWS services entails the creation of AWS service specific IAM roles and your ability to create IAM roles requires that you associate the development IAM boundary policy to all roles, the process for configuring IAM service roles needs to be addressed.

Refer to [Controlling Development Team Access]({{< relref "02-controlling-builder-team-access" >}}) for more background on permissions provided to builder teams in development AWS accounts and the role of AWS IAM boundary policies.

## Using AWS Services

The following documents provide tips on using AWS services given the constraints of team development AWS accounts.

{{% children showhidden="false" %}}
