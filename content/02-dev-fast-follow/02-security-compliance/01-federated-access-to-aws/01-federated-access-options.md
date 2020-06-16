---
title: 'Federated Access to AWS Options'
menuTitle: 'Federated Access Options'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section addresses options and resources to enable your internal users federated access to your AWS environment by using an identity provider external to AWS. 

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

Presumably you are visiting this page because you are using [AWS SSO](https://aws.amazon.com/blogs/security/how-to-create-and-manage-users-within-aws-sso/) as a built-in Identity Provider and User Directory. Often, customers will choose to migrate to more enterprise solutions that meet the requirements detailed above. There are 3 common paths when deciding what to do with Federated Access to AWS. 

{{% notice warning %}}
Switching from AWS SSO to one of these other options will disrupt the way users and administrators log into the AWS console, see the *Migration From Use of Locally Managed Groups and Users in AWS SSO* section below.
{{% /notice %}}

* Use the built-in AWS SSO Identity service as an Identity Provider and Microsoft Active Directory (self-managed or AWS Managed Active Directory) as a centralized source of truth for user identity.
	* Customers often choose this option because they can maintain an existing source of truth for user identity hosted in a self-managed Active Directory Domain. In this design, a VPC is needed in a Shared Services VPC to host self-managed Active Directory or AWS Managed Active Directory with subnets shared to the AWS Master Account where AWS SSO will reside. [Learn more here.](/02-dev-fast-follow/02-security-compliance/01-federated-access-to-aws/02-aws-sso-ad.html)
		* [Connect AWS SSO to AWS Managed Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectawsad.html) running in a VPC in an Infrastructure Shared Services account with shared subnets to the Master Account.
		* [Connect AWS SSO to an On-Premises Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectonpremad.html) using a VPC in an Infrastructure Shared Services account that has an established VPN or Direct Connect connection to the on-premises datacenter. [Here is another blog](https://aws.amazon.com/blogs/security/how-to-connect-your-on-premises-active-directory-to-aws-using-ad-connector/) post with additional detail.
* Use the built-in AWS SSO Identity service as an Identity Provider and connect an external third party Identity Directory over a SAML federation.
	* This is a popular and recommended option for customers that already use AzureAD as a source of truth for Identity.
		* [Connect AWS SSO to AzureAD](https://aws.amazon.com/blogs/aws/the-next-evolution-in-aws-single-sign-on/) using AzureAD's SCIM (System for Cross-domain Identity Management) endpoint. This enables automated provisioning which is very useful for AWS Organizations with more than 20 Accounts!
		* [Connect AWS SSO to Okta](https://youtu.be/_zqHFlaqSTg) for automated provisioning using Okta's SCIM capability, enabling automated provisioning for organizations with more than 20 accounts.
* Use an external third party Identity Provider and a self-managed User Identity Directory (Microsoft Active Directory or LDAP)
	* If your Organization already utilizes a publicly accessible Identity Provider, you can continue to use this portal for federated access to AWS. This assumes the Identity Provider you are using has access to User Identities stored in a central source of truth, such as Active Directory. Common examples include: OneLogin, Okta, ADFS. See the [full list](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml_3rd-party.html) of third-party SAML 2.0 IdP's that work with AWS Federation.
		* [Connect your AWS accounts to Okta](https://support.okta.com/help/s/article/Support-for-Multiple-Accounts-in-AWS)
		* [Connect your AWS accounts to ADFS](https://aws.amazon.com/blogs/security/enabling-federation-to-aws-using-windows-active-directory-adfs-and-saml-2-0/)
		* [Connect your AWS accounts to OneLogin](https://onelogin.service-now.com/kb_view_customer.do?sysparm_article=KB0010344)


{{% notice info %}}
When new AWS Accounts are created in the Organization, there is configuration necessary to onboard it into the Identity Provider and create relative Active Directory Security Groups for each Role you wish you provision. This is called Manual Provisioning. For less than 20 AWS accounts this generally isn't a problem, however, when larger Enterprises start to create hundreds or even thousands of accounts, this creates unnecessary management overhead and requires an automated solution. AWS SSO and AzureAD support Automatic Provisioning. [Review the Considerations](https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-automatically.html).
{{% /notice %}}

### Multi-Factor Authentication

Multi-factor authentication (MFA) is supported with AWS SSO. If you choose to use a third party identity provider, review the documentation for that product on how to configure MFA. [See the User Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/enable-mfa.html) for MFA considerations and options on AWS SSO.

### Migration From Use of Locally Managed Groups and Users in AWS SSO

If you began using AWS SSO initially to configure single-sign-on for your AWS environment, you may be considering switching to Active Directory or another Identity Provider as the source of truth. Be sure that your Active Directory domain is configured with granular AD groups for (at least) your Master Account, but ideally all accounts you wish to manage with AWS SSO. Consider some best practices when using AWS SSO with Active Directory (either self-managed or AWS Managed Active Directory):

* Get granular for users and have overarching roles for the Cloud Center of Excellence team
* Group users into personas. Each persona will be assigned a Permission Set (or Role) in an account. Some default permissions sets in AWS SSO: AWSAdministratorAccess, AWSPowerUserAccess, AWSReadOnlyAccess, AWSOrganizationsFullAccess, AWSServiceCatalogAdminFullAccess, AWSServiceCataLogEndUserAccess.
* In Active Directory, create an AD Security Groups for each Account for each Permission Set following a naming convention: ***OrganizationName_AWSAccountName_PermissionSetRole***
	* Some Granular Examples: AWS_Network_Administrators, AWS_SharedServices_Administrators, AWS_Master_BillingAdmins, AWS_Network_NetworkAdmins
	* Some "overarching" Examples: AWS_GlobalAdministrators, AWS_GlobalNetworkAdmins, AWS_GlobalSecurityAdmins
* Considering creating new AD groups and permission sets for personas that don't come out of the box -- Developers, for example.
* Don't simply grant full Administrator to all users for an account. Taking the time to build out role-based access contributes to defense in depth, ensuring a more secure environment.

When you are ready to change AWS SSO over from the internal directory to Active Directory or a Third Party Identity Provider, take note of the implications of such a change **most notibly** all existing entitlements will be lost -- so have your AD groups configured and your Master Account root username, password and MFA handy in case you are logged out. Alternatively you could use an IAM User in the Master Account as a backup. [Follow this guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-change.html) to switch your AWS SSO identity source.

[![SSO to AD](/images/02-dev-fast-follow/02-security-compliance/01-federated-access-to-aws/awssso_converttoAD.png)](/images/02-dev-fast-follow/02-security-compliance/01-federated-access-to-aws/awssso_converttoAD.png)

{{% notice note %}}
The URL you were using to access AWS SSO may change and users may need to update their links.
{{% /notice %}}



As new AWS accounts are introduced, there will be some setup tasks necessary:
1) Creating AD groups that correspond to the Personas you want to provision
2) Adding AD Users to the group
3) Assigning the AD Group to a Permission Set for the new AWS Account in AWS SSO.

This could be automated when at scale to reduce overhead, as well as integration with Identity Management solutions.