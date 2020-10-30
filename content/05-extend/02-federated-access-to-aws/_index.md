---
title: 'Federated Access to Your AWS Environment Using an Existing Identity Source'
menuTitle: 'Federated Access to AWS'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}
 
Earlier in this guide, you may have followed the set up instructions to use AWS Single Sign-on (AWS SSO) with locally managed users and groups to provide federated access to your AWS accounts. This access provides authorized human users with the ability to interact with AWS service APIs and manage AWS resources within your AWS accounts.  Users might use the AWS management console, AWS CLI, AWS SDKs, or direct integration with AWS service APIs to interact with your AWS environment.

The approach of managing users and groups locally in AWS SSO can act as a useful starting point until you have the time to plan and coordinate the work required to reuse your existing identity source. This section addresses how you can establish federated access to your AWS environment by reusing your existing enterprise identity source. 

## Benefits of using your existing identity source

By using your existing identity source, users who need direct access to your AWS environment can be granted access via your standard enterprise access control procedures and reuse their standard corporate identities to access your AWS environment. Your existing security controls, lifecycle management practices, and audit processes can all be reused in this approach.

The source of truth for your users and group-based entitlement definitions are often managed in Active Directory (AD) and commonly exposed via SAML-based Identity Providers (IdPs) for integration with publicly accessible services including SaaS services and cloud environments such as AWS.

AD security groups are often used to represent entitlements that are mapped to permissions in a given application, product, or cloud environment. In an enterprise's access management solution such entitlements are associated with functional roles that are associated with people and teams.  As people and teams change, their associated roles are reviewed and group membership is either manually or automatically changed so that access to entitlements is automatically updated.

{{% notice info %}}
**Out of scope: Application level federated access:** This section does not address federated access in support or your applications hosted on AWS. Although your enterprise identity and access management solution may also be used in support of application level federated access, different considerations and tools come into play in this similar, but different use case. For example, you might be managing a commercial off-the-shelf (COTS) application or tool that integrates directly with either SAML-based identity providers (IdPs) or LDAP-enabled directory services for user authentication and group-based access control.  If your application depends on LDAP, then you might consider the [AWS Directory Service](https://aws.amazon.com/directoryservice) to help you manage Active Directory in your AWS environment.  You might also have newly developed web and mobile applications that benefit from user authentication, federated access, and integration with AWS Identity and Access Management (AWS IAM).  In these cases, you might make use of [Amazon Cognito](https://aws.amazon.com/cognito/) to quickly and easily add these capabilities to your web and mobile applications.
{{% /notice %}}

## Using your existing identity source

{{% children showhidden="false" %}}
