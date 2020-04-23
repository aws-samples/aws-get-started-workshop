---
title: 'History of Changes'
menuTitle: 'Changes'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

A history of notable changes to the guide.

|Date|Change|Description|Upgrading|
|----|------|-----------|---------|
|April 23 2020|**Introduce initial set of Service Control Policies (SCPs) and apply to team development environments**|The sample IAM SAML policy and permissions boundary policy for team development environments were streamlined through the removal of the VPC related deny permissions and the introduction of several AWS Organizations Service Control Policies (SCPs) to deny these actions summarily across AWS accounts in the `development` organizational unit (OU).|1. Follow the new instructions to create the SCPs and apply them to the `development` OU.<br><br>2. Redeploy the AWS SSO permission set for team development environment access using the updated sample policy.<br><br>3. Redploy the CloudFormation StackSet for the team development IAM permissions boundary using the updated sample policy.|
|April 22 2020|**AWS Control Tower supports reusing existing master AWS accounts**|Address scenarios where you might want to reuse an existing master AWS account with AWS Control Tower.|Applies only to new AWS environment build outs.|
|March 31 2020|**No longer share public subnets**|Share only private subnets with team development accounts so that builder teams can't enable Internet access to their development workloads.|Review the updated instructions. In Resource Access Manager in the Network account, remove sharing of the public subnets.|
|March 27 2020|**Enhance team development IAM policies with NotAction**|Using the AWS managed IAM policy developer oriented `PowerUserAccess` as a basis, make the SAML policy and permissions boundary more secure by default by patterning a portion of them after the PowerUser managed policy.|1. Redeploy the AWS SSO permission set for team development environment access using the updated sample policy.<br><br>2. Redploy the CloudFormation StackSet for the team development IAM permissions boundary using the updated sample policy.|
|March 15 2020|**Convert to Hugo static site generator**|Make it easier to browse the guide via a web site as compared to browsing markdown files in the git repository.|No changes necessary.|
|March 1 2020|**Initial form of team development access controls based on IAM permissions boundaries**|A means to enable builder teams with wide ranging access in their team development environments, but not able to modify the underlying foundation resources.|See the instructions for setting up access control for team development environments.|
