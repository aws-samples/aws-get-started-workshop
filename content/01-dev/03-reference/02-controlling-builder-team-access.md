---
title: "Controlling Builder Team Access to Development Environments"
menuTitle: "Controlling Builder Dev Access"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

The sample IAM policies and Service Control Policies (SCPs) described in this document are intended to be used as a starting point for how you might control builder team access in team development AWS accounts so that builders have the freedom to get many things done on their own, but are constrained from adversely impacting the security and stability of the underlying foundation.

Your organization is expected to understand these sample policies in detail before potentially applying them.  

As you progress on your journey, managing and controlling changes to these types of policies will be a critical responsibility of your foundation team.  Typically, only your Cloud Security team would have the permissions needed to create and update such policies.

{{< toc >}}

## Goals

The overall intent of the policies is to enable your builders to have broad permissions to innovate, experiment, develop, and perform early testing in their team development AWS accounts while being prevented from adversely impacting the overall security and the stability of the underlying foundation of those AWS accounts.

These policies are not intended to be applied beyond team development AWS accounts.  For example, it's a best practice for organizations to apply strict policies for the creation and management of cloud resources in formal pre-production test and production AWS accounts.

## Requirements

The following requirements are intended to provide a practical sense of the access that you may consider providing to builder teams.

### Disallow Access

**Disallow Modification of Foundation Resources:** For example:
* Foundation IAM roles and policies.
* AWS account settings.
* AWS Control Tower CloudFormation StackSet stack instances.

**Disallow Creation of Sensitive IAM Resources:**  For example:
* IAM Users: Given the use of AWS SSO for human user login, there's generally no need for IAM users.
* IAM SAML Providers: Creation of these resources could enable external entities access to your AWS account.

**Disallow Privilege Escalation:** Inhibit builders from creating and using IAM roles that circumvent these requirements.

**Disallow Creation and Management of VPC Resources:** Since builders already have read only access to the centrally managed development VPC and supporting network resources, builders should not generally need to create and manage VPC resources. A key exception to this requirement is that your foundation team members will typically need the ability to have write access to VPC resources so that they can experiment, develop, and perform early testing of changes to VPC resources before rolling them into your standard foundation.

### Allow Access

**Allow Wide Range of AWS Services Subject to Organizational Policies:**  Allow for use of a wide range of AWS services with the expectation that AWS Organizations Service Control Policies (SCPs) will be used to restrict the overall set of AWS services that are accessible for any AWS account in the "development" organization.

**Allow Creation of IAM Service Roles and Policies:** In development environments builders should be able to experiment, develop, and test solutions without depending on other teams to get things done.

Since this work often entails creation of workload specific IAM service roles and policies, builders should be able to create and manage these resources on their own subject to the constraint that builders must not be able to escalate their privileges to circumvent other policies.

For example, it's a common need to be able to define workload specific IAM service roles and policies and attach the roles to Amazon EC2 instances and Lambda functions.

**Allow Read Only Access to IAM Roles and Policies:** Allow builders to browse and review IAM resources so that they know what is available to potentially reuse and can learn from existing examples.

**Allow Access to Billing and Cost Information** So that builders can monitor and manage their cloud spend.

### User Experience

**Avoid Prematurely Requiring Standard Resource Naming and Tagging:** Although your organization will find value in the introduction of cloud resource naming and tagging standards in support of a variety of needs, these standards are not necessary to impose sufficient constraints on builders at this early stage in your journey.

However, it is important that foundation resources adhere to a naming convention so that IAM policies can be defined to inhibit unauthorized modification of those resources.

### Assumptions

**Consider Similar but Different Policies for Foundation Team Development:** Since your cloud foundation team members are also builders and they will need additional acccess in their foundation team development AWS account to develop and test chnges to the foundation, a derivative of these sample policies may be warranted for this group of builders.  

As a best practice, when foundation team members are doing day-to-day development of Infrastructure as Code (IaC), they should not be using their administrative access roles and permissions.  

Instead, foundation team members should use their team development oriented role for their day-to-day development and only assume the escalated privileges of their Cloud Administrator and similar roles when they need to perform their cloud administration duties.

## Common Scenarios

There are two common scenarios that these access requirements are intended to address:

* Builders working directly with AWS services.
* Builders creating and using workload specific IAM service roles and policies.

### Builders Working Directly with AWS Services

When your builders experiment and formally develop with AWS services, the IAM SAML role and policies under which they work in their team development AWS account needs access to a variety of AWS services.

### Builders Creating and Using Workload Specific IAM Service Roles and Policies

When builders are formally developing and performing preliminary testing of AWS service configurations, they often need to define and configure IAM service roles and customer managed policies that are specific to their workloads. 

Once the workload specific IAM service roles and policies are created, they are associated with AWS services so that those services can operate with the appropriate permissions. Instead of relying on a central team to develop and test workload specific IAM service roles and policies, this workload specific work is best performed by the builder teams that are also developing the workloads.

Typically, before workload specific IAM service roles and policies are used in more strictly controlled pre-production test and production environments and associated AWS accounts, organizations implement either human powered workflows or, in more advanced cases, highly automated code pipelines to review and test workload specific IAM service roles and policies.

#### Creating IAM Service Roles

When experimenting, developing, and testing workload specific IAM service roles and policies, builders use a variety of tools including:

* AWS Management Console.
* AWS CLI or SDKs.
* AWS CloudFormation or other Infrastucture as Code (IaC) tools such as Terraform.

IaC tools are typically used before workload specific IAM service roles and policies can be promoted to pre-production test and production environments.

#### Using IAM Service Roles

The following scenarios are just a few examples of when a builder team would associate an IAM service role with an AWS service:

* Deploy EC2 instance and associate an instance profile.
* Deploy a Lambda function.
* Deploy a Cloud9 IDE workspace.
* Deploy a Redshift cluster to support data warehousing use cases.
* Deploy containers to Amazon ECS and EKS container orchestration services.

{{% notice tip %}}
**Best practice to use IAM service roles vs "service accounts":** In all of these examples, it's a best practice to use customer managed IAM service roles and policies and the associated short term credentials to permit the workload access to other cloud resources on which they depend. This approach is more managable and secure than the complexity and risks associated with managing and using workload specific "service accounts" in the form of IAM users and long term  AWS access keys.
{{% /notice %}}

## Sample Implementation

This section provides an overview of the sample policies and then walks through each set of policies in detail.

### Overview of the Implementation

In support of the requirements described above, two IAM policies and two Service Control Policies (SCPs) are used:

|Policy|Purpose|Usage|Sample Code|
|------|-------|-----|-----------|
|**Team Development IAM SAML Policy**|A JSON format IAM policy used for control human user access to team development AWS accounts.|This policy is used to create a custom permission set in AWS SSO that is associated with team development groups and team development AWS accounts. AWS SSO converts this policy into an IAM SAML role that is applied when user's access the team development AWS accounts.|[`example-base-team-dev-saml.json`](/code-samples/01-iam-policies/example-base-team-dev-saml.json)|
|**Team Development IAM Permissions Boundary**|A customer managed IAM permissions boundary policy that is used to control permissions of IAM service roles created by team development users in their team development AWS accounts.|This AWS CloudFormation template forms the basis of a CloudFormation StackSet that is applied to all team development AWS accounts.|[`example-base-team-dev-boundary.yml`](/code-samples/01-iam-policies/example-base-team-dev-boundary.yml)|
|**Networking Core SCP**|A JSON format SCP used to disallow creating and updating VPC core resources such as VPCs, subnets, route tables, etc.|Initially, in the context of this guide, this SCP is used to ensure that all users - both builder teams and foundation team members cannot create and modify these resources in team development AWS accounts.<br><br>If and when you encounter other situations for which this SCP would apply, you can reuse the SCP.|[`example-base-scp-vpc-core.json`](/code-samples/02-scps/example-base-scp-vpc-core.json)|
|**Networking Boundaries SCP**|A JSON format SCP used to disallow creating and updating VPC boundary resources such as Internet Gateways, NAT Gateways, Transit Gateways, Site-to-Site VPN Connections, DirectConnect, etc.|Initially, in the context of this guide, this SCP is used to ensure that all users - both builder teams and foundation team members cannot create and modify these resources in team development AWS accounts. <br><br>If and when you encounter other situations for which this SCP would apply, you can reuse the SCP.|[`example-base-scp-vpc-boundaries.json`](/code-samples/02-scps/example-base-scp-vpc-boundaries.json)|

#### Provisioning the Policies

If you followed the steps in section [6. Set Up Team Development Environment Access Controls]({{< relref "07-set-up-team-dev-env-access-control" >}}), you already provisioned the SCPs, associated the SCPs with the `development` OU, provisioned the team development IAM SAML policy as an AWS SSO permission set, and provisioned the permissions boundary policy via an AWS CloudFormation StackSet.  The result of those steps is that the SCPs are automatically applied to all AWS accounts in the `development` OU and the supporting IAM policies are available in each of the team development AWS accounts.

The following diagram shows how the IAM policy and permissions boundary were provisioned in the earlier step.

[![Team Development Access Policy Provisioning](/images/01-dev/team-dev-access-provisioning.png)](/images/01-dev/team-dev-access-provisioning.png)

#### Using the Policies

The following diagram depicts how a builder team member accesses their team development AWS account, interacts with AWS services and is contrained by what they can do through both the IAM SAML role under which they are working and the permissions boundary policy and IAM service roles under which AWS services are working on their behalf.

A key element of this sample solution is the use of [AWS IAM Permissions Boundaries](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) to enable delegation of permissions management to builders, but also constrain the overall scope of their access and the access of AWS services working on their behalf.  

The SCPs you provisioned earlier add an extra layer of control to what any user can do in the team development accounts.

In this scenario, we're delegating a degree of permissions management to builder team members in their team development AWS accounts so that they can create and manage workload specific IAM service roles, but at the same time using a permissions boundary to constrain what actions services associated with those roles can perform and the resources that can be affected.

[![Team Development Access Policy Usage](/images/01-dev/team-dev-access-usage.png)](/images/01-dev/team-dev-access-usage.png)

1. Builder authenticates via AWS SSO.

2. Via the AWS SSO portal, the builder selects their authorized combination of team development AWS account and team development IAM SAML role.

3. Once the builder has been authenticated and gained access to their team development AWS account, they are working based on the intersection of the permissions of the team development IAM SAML role and any applicable Service Control Policies (SCPs) associated with team development AWS accounts. They can interact with AWS services and create and manage resources subject to those permissions.

4. When a builder needs to create a workload specific IAM service role, the permissions boundary policy referenced in the IAM SAML role under which they are working requires that they attach the permission boundary with any newly created IAM service role. If the permissions boundary is not attached, creation of the role will fail.

5. The builder passes a newly created workload specific IAM service role to an AWS service and resource.

6. Since the workload specific IAM service role has an attached boundary policy, AWS will constrain the resource to being able to access only those services and resources that are the intersection of the permissions allowed by the boundary policy, applicable SCPs, and the IAM service role.

{{% notice info %}}
**Learn more about permissions boundaries:** [AWS IAM Permissions Boundaries](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html).
{{% /notice %}}

### IAM SAML Policy Walkthrough

[`example-base-team-dev-saml.json`](/code-samples/01-iam-policies/example-base-team-dev-saml.json)

Each section of the sample policy is explained here.

#### Allow Virtually All AWS Services

Start by allowing full access to all AWS service resources and actions, but disallow access to actions for all "iam", "organizations", and "account" resources.  

This first permission is patterned after a portion of the [AWS Managed Policy Developer Power User](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_developer-power-user).  

{{% notice tip %}}
**Depend on AWS Organizations Service Control Policies (SCPs) for AWS Account-wide Constraints:** As mentioned above, it's a best practice to use AWS Organizations SCPs to provide an overarching constraint on which AWS services can be used in a given AWS ccount. Instead of over complicating the following policy with fine grained lists of allowed or disallowed AWS services, it's best practice to defer to SCPs to control which AWS services can be used at all in the team development AWS accounts.
{{% /notice %}}

```
        {
            "Sid": "AllowAllWithExceptions",
            "Effect": "Allow",
            "NotAction": [
                "iam:*",
                "organizations:*",
                "account:*"
            ],
            "Resource": "*"
        },
```

#### Allow Typical IAM and Read Only Organizations and Account Actions

A subset of the following permissions is taken from the AWS managed Developer Power User policy. In support of this use case where the intent is to provide builders in their team development AWS accounts a limited degree of self-service write access to create, update, and delete their workload specific IAM service roles, additional permissions have been added.

```
            "Sid": "AllowCommonOps",
            "Effect": "Allow",
            "Action": [
                "iam:Get*",
                "iam:List*",
                "iam:PassRole",
                "iam:CreateServiceLinkedRole",
                "iam:DeleteServiceLinkedRole",
                "iam:CreateInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:AddRoleToInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "organizations:DescribeOrganization",
                "account:ListRegions"
            ],
            "Resource": "*"
        },
```

#### Allow Creation of Customer Managed Policies

Allow builders to develop and test customer managed policies as long as the name of the policies don't conflict with the foundation policies.

{{% notice tip %}}
**Importance of Standardized Naming of Foundation Resources:** In several of the following permissions examples, note the use of a naming convention for customer-managed foundation policies and roles.  The example naming convention shown below is simply `<org identifier>-base-...` where `base` is shorthand for "foundation".
{{% /notice %}}

```
        {
            "Sid": "AllowPolicyCrud",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:DeletePolicy",
                "iam:CreatePolicyVersion",
                "iam:DeletePolicyVersion"
            ],
            "NotResource": "arn:aws:iam::*:policy/example-base-*"
        },
```

#### Allow Creation of IAM Roles Only When Permissions Boundary is Attached

Allow builders to create IAM roles only if the standard team development permissions boundary policy is attached at role creation time and the role name does not overlap with the foundation namespace.

```
       {
            "Sid": "AllowRoleWithPBs",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy"
            ],
            "NotResource": "arn:aws:iam::*:role/example-base-*",
            "Condition": {
                "StringLike": {
                    "iam:PermissionsBoundary": "arn:aws:iam::*:policy/example-base-team-dev-boundary"
                }
            }
        },
```

#### Allow Write Access to Non-Foundation Roles

Allow builders to further modify non-foundation IAM roles.

```
        {
            "Sid": "AllowRoleOther",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteRole",
                "iam:UpdateRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:PutRolePermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary",
                "iam:TagRole",
                "iam:UntagRole"
            ],
            "NotResource": "arn:aws:iam::*:role/example-base-*"
        },
```

#### Deny Deletion of Permissions Boundary Policies from IAM Roles

Ensure that once a permissions boundary policy has been attached to a role, builders cannot delete it.  Builders can still delete the role itself which will automatically remove the attached permissions boundary policy.

```
       {
            "Sid": "DenyDeletionPBs",
            "Effect": "Deny",
            "Action": "iam:DeleteRolePermissionsBoundary",
            "Resource": "*"
        }, 
```

#### Deny Write Access to Billing Resources

```
        {
            "Sid": "DenyBillingWrite",
            "Effect": "Deny",
            "Action": [
                "aws-portal:ModifyAccount",
                "aws-portal:ModifyBilling",
                "aws-portal:ModifyPaymentMethods"
            ],
            "Resource": "*"
        },   
```

#### Deny Write Access to AWS Platform Roles

```
        {
            "Sid": "DenyFoundationIamRoleWrite",
            "Effect": "Deny",
            "Action": [
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:UpdateRole",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:UpdateAssumeRolePolicy",
                "iam:PutRolePermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary",
                "iam:TagRole",
                "iam:UntagRole"
            ],
            "Resource": [
                "arn:aws:iam::*:role/stacksets*",
                "arn:aws:iam::*:role/AWS*",
                "arn:aws:iam::*:role/aws*"
            ]
        },
```

#### Deny Write Access to CloudFormation StackSet Stacks

Ensure that foundation related CloudFormation stack instances that have been created via CloudFormation StackSets cannot not be modified.

```
        {
            "Sid": "DenyStackSetWrite",
            "Effect": "Deny",
            "Action": [
                "cloudformation:DeleteStack",
                "cloudformation:UpdateStack"
            ],
            "Resource": "arn:aws:cloudformation::*:stack/StackSet-*"
        },
```

### Permissions Boundary Walkthrough

[`example-base-team-dev-boundary.yml`](/code-samples/01-iam-policies/example-base-team-dev-boundary.yml)

Since the overall intent in this development environment scenario is to enable AWS services acting on behalf of the builders to have similar access permissions as the builders themselves, the permissions boundary policy has similar permissions as the IAM SAML policy for builder team members.  

The main difference is that write access to all IAM resources is disallowed in the sample permissions boundary policy. For example, since there was no requirement to enable AWS services to create roles and policies on behalf of builders, disallowing role creation inhibits builders from creating roles that could circumvent the policies.

```
            {
              "Sid": "AllowAllWithExceptions",
              "Effect": "Allow",
              "NotAction": [
                "iam:*",
                "organizations:*",
                "account:*"
              ],
              "Resource": "*"
            },
            {
              "Sid": "AllowIamReadOnly",
              "Effect": "Allow",
              "Action": [
                "iam:Get*",
                "iam:List*"
              ],
              "Resource": "*"
            },
            {
              "Sid": "DenyWriteAccessStackSets",
              "Effect": "Deny",
              "Action": [
                "cloudformation:DeleteStack",
                "cloudformation:UpdateStack"
              ],
              "Resource": "arn:aws:cloudformation::*:stack/StackSet-*"
            },
            {
              "Sid": "DenyVPCWrite",
              "Effect": "Deny",
              "Action": [
                ...same as in the IAM SAML policy shown above...
              ],
              "Resource": "*"
            }
```

### Service Control Policies (SCPs) Walkthrough

These are the SCPs you created and initially associated with the `development` OU:

* [`example-base-scp-vpc-core.json`](/code-samples/02-scps/example-base-scp-vpc-core.json)
* [`example-base-scp-vpc-boundaries.json`](/code-samples/02-scps/example-base-scp-vpc-boundaries.json)

SCPs look very similar to IAM policies. See [Managing AWS Organizations policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html) for more details on using SCPs.

These particular SCPs could be combined into a single SCP if so desired, but were split apart in case you might want to deny creating and updating boundary vs core VPC resources in your other AWS accounts and OUs in the future. i.e. a single SCP can be mapped to multiple OUs and/or AWS accounts.

Since the IAM SAML policy described earlier does not inhibit creation and updating of VPC resources not covered by these SCPs, when these SCPs are applied to the `development` OU, builder team members have the ability to create and update EC2 related networking resources such as Elastic Network Interfaces (ENIs), securitu groups, and other commonly used EC2 instance related network resources.

The following excerpt is representative of these two SCPs in that it simply denies a set of VPC resource related actions in any AWS account to which the SCP is applied.

{{% notice tip %}}
**Enable AWS Control Tower to perform its new AWS account baselining:** In the network oriented SCPs, you will note the use of a condition on each policy so that AWS Control Tower's use of its own AWS CloudFormation StackSet execution role is excluded from each policy.  Since AWS Control Tower's Account Factory performs an initial baselining of VPC resources, it needs some degree of write access to VPC resources when it provisions new AWS accounts. Since the sample SCPs are applied automatically as soon as an AWS account joins the `development` OU, they will likely be in effect before the Account Factory completes its baseline tasks.
{{% /notice %}}

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "ec2:CreateVpc",
                "ec2:CreateDefaultVpc",
                "ec2:DeleteVpc",
                "ec2:AssociateVpcCidrBlock",
                "ec2:DisassociateVpcCidrBlock",
                "ec2:ModifyVpcAttribute",
                "ec2:MoveAddressToVpc",
                "ec2:ModifyVpcTenancy",
                "ec2:RestoreAddressToClassic",
                "ec2:AttachClassicLinkVpc",
                "ec2:EnableVpcClassicLink",
                "ec2:EnableVpcClassicLinkDnsSupport",
                "ec2:CreateFlowLogs",
                "ec2:DeleteFlowLogs",
                "ec2:AssociateDhcpOptions",
                "ec2:CreateDhcpOptions",
                "ec2:DeleteDhcpOptions"
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

### Example Test Cases

#### Builders Working Directly with AWS Services

This set of test cases depends on the team development IAM SAML role's policies.

As a builder, attempt to perform actions with a variety of AWS services.

Only those explicitly disallowed actions listed earlier in this document should be inhibited.

#### Builders Creating and Using IAM Service Roles and Policies for Their Workloads

This set of test cases depends on the AWS IAM permissions boundary being deployed and referenced in the team development IAM SAML role's policies.

##### Creating IAM Managed Policies

Builders create IAM managed policies via the following tools:

* AWS Management Console.
* AWS CLI or SDKs.
* AWS CloudFormation or other Infrastucture as Code (IaC) tools such as Terraform.

##### Creating IAM Service Roles

Builders create IAM service roles and policies via the following tools.  Builders attempt to create IAM service roles with and without the permissions boundary. All attempts to create IAM service roles without the permissions boundary will fail.

* AWS Management Console.
* AWS CLI or SDKs.
* AWS CloudFormation or other Infrastucture as Code (IaC) tools such as Terraform.

Variations:
* Use include inline policies.
* Attach both AWS and customer managed IAM policies.

##### Using IAM Service Roles

Builders associate IAM service roles to AWS resources and then attempt to access allowed and disallowed actions on resources.

* Deploy EC2 instance and associate an instance profile.
* Deploy a Lambda function.
* Deploy a Cloud9 IDE workspace (same as EC2 use case).
* Deploy a Redshift cluster to support data warehousing use cases.
* Deploy containers to Amazon ECS and EKS container orchestration services.

##### Using the IAM Policy Simulator

Builders testing IAM policies via the [IAM Policy Simulator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html) in the AWS Management Console.

#### Disallowed Actions

* Deleting permissions boundary policy from existing IAM service role.
* Modifying foundation and AWS IAM roles.
  * Delete foundation and AWS IAM roles.
  * Attaching and detaching managed policies.
  * Adding and removing inline policies.
* Creating and deleting IAM SAML providers.
* Creating, updating, and deleting IAM users and groups.
