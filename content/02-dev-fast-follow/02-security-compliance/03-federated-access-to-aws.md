---
title: "Federated Access to AWS Platform"
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section addresses options and resources to enable your internal users federated access to your AWS environment by using an identity proivider external to AWS. 

## Out of Scope: Application Level Federated Access

The section does not address federated access in support or your applications hosted on AWS. Although your enterprise identity and access management solution may also be used in support of application level federated access, different considerations and mechanisms come into play in this simialr, but different use case.

## Motivation and Common Practices
It is common practice for organizations to reuse their existing enterpise identity and access management solution to form the basis of controlling access to the AWS platform.  Doing so, reuses existing security controls, lifecycle management practices, and audit processes.

The source of truth for users and group-based entitlement definitions is often based in Active Directory (AD) and commonly exposed via SAML-based Identity Providers (IdPs) for integration with publicly accessible services including SaaS services and cloud platforms such as AWS.

AD security groups are often used to represent entitlements that are mapped to permissions in a given application, product, or cloud platform. In an enterprise's access management solution such entitlements are associated with roles that are associated with people and teams.  As people and teams change, their associated roles are reviewed and membership is either manually or automatically changed so that access to entitlements is automatically updated.



## Requirements

Generally customers have the following requirements regarding identity when embarking on the cloud journey, as it relates to perspectives in the [AWS Cloud Adoption Framework](https://aws.amazon.com/professional-services/CAF/):

1. Simple and scalable access to the AWS console or API. (Business)
2. Ability for Account Owners and an IT Identity Team to manage access. (People)
3. Cascade down job hirings, terminations, or job-change-transfer events to take effect on downstream applications to stay compliant. (Governance)
4. Reuse of an existing centralized directory as a source of truth for users. (Platform) 
5. Granular access control to the role level, following the Organization's role-based-access-control requirements. (Security)
6. Minimum maintenance going forward as accounts are added or removed. (Operations)



## Solution Options and Resources

Customers will usually choose 1 of 3 paths when deciding what to do with Federated Access to AWS:

* Use the built-in AWS SSO Identity service as both an Identity Provider and User Directory
	* This is the [fastest way to get started](https://aws.amazon.com/blogs/security/how-to-create-and-manage-users-within-aws-sso/), but does not leverage an existing user directory or Identity Provider. Many enterprises consider this is a short-term option to get off the ground quickly.
* Use the built-in AWS SSO Identity service as an Identity Provider and Microsoft Active Directory (self-managed or AWS Managed Active Directory) as a centralized source of truth for user identity.
	* Customers often choose this option because they can maintain an existing source of truth for user identity hosted in a self-managed Active Directory Domain. In this design, a VPC is needed in the AWS Master account to link to self-managed Active Directory or AWS Managed Active Directory. Learn more here.
		* [Connect AWS SSO to AWS Managed Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectawsad.html) running in a VPC in the Master account
		* [Connect AWS SSO to an On-Premises Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectonpremad.html) using a VPC in the Master Account that has an established VPN or Direct Connect connection to the on-premises datacenter
		* [Connect AWS SSO to AzureAD](https://aws.amazon.com/blogs/aws/the-next-evolution-in-aws-single-sign-on/)
* Use an external third party Identity Provider and a self-managed User Identity Directory (Microsoft Active Directory or LDAP)
	* If your Organization already utilizes a publicly accessible Identity Provider, you can continue to use this portal for federated access to AWS. This assumes the Identity Provider you are using has access to User Identities stored in a central source of truth, such as Active Directory. Common examples include: OneLogin, Okta, ADFS. See the [full list](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml_3rd-party.html) of third-party SAML 2.0 IdP's that with with AWS Federation.
		* [Connect your AWS accounts to Okta](https://support.okta.com/help/s/article/Support-for-Multiple-Accounts-in-AWS)
		* [Connect your AWS accounts to ADFS](https://aws.amazon.com/blogs/security/enabling-federation-to-aws-using-windows-active-directory-adfs-and-saml-2-0/)
		* [Connect your AWS accounts to OneLogin](https://onelogin.service-now.com/kb_view_customer.do?sysparm_article=KB0010344)
		
{{% notice info %}}
A key point for any solution not using AWS SSO: When new AWS Accounts are created in the Organization, there is configuration necessary to onboard it into the Identity Provider and create relative Active Directory Security Groups for each Role you wish you provision. This is called Manual Provisioning. For less than 20 AWS accounts, this generally isn't a problem. When larger Enterprises start to create hundreds or even thousands of accounts, this creates unnecessary management overhead and requires an automated solution. AWS SSO and AzureAD support Automatic Provisioning. [Review the Considerations](https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-automatically.html).
{{% /notice %}}

### Migration From Use of Locally Managed Groups and Users in AWS SSO

*...if the customer started with the use of locally managed users and groups in AWS SSO, highlight considerations when miograting to the use of external identity providers either via AWS SSO or traditional federated access to AWS outside of AWS SSO...*