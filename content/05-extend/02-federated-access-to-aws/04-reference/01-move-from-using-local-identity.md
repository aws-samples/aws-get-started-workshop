---
title: 'Moving From Locally Managed Identities in AWS to Other Sources'
menuTitle: 'Move from Local Identity Source in AWS SSO'
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

If you began using AWS SSO initially to configure single-sign-on for your AWS environment, you may be considering switching to Active Directory or another identity provider as the source of truth. 

Be sure that your Active Directory domain is configured with granular AD groups for (at least) your Master Account, but ideally all accounts you wish to manage with AWS SSO. Consider some best practices when using AWS SSO with Active Directory (either self-managed or AWS Managed Active Directory):

* Get granular for users and have overarching roles for the Cloud Center of Excellence team
* Group users into personas. Each persona will be assigned a Permission Set (or Role) in an account. Some default permissions sets in AWS SSO: AWSAdministratorAccess, AWSPowerUserAccess, AWSReadOnlyAccess, AWSOrganizationsFullAccess, AWSServiceCatalogAdminFullAccess, AWSServiceCataLogEndUserAccess.
* In Active Directory, create an AD Security Groups for each Account for each Permission Set following a naming convention: ***OrganizationName_AWSAccountName_PermissionSetRole***
	* Some Granular Examples: AWS_Network_Administrators, AWS_SharedServices_Administrators, AWS_Master_BillingAdmins, AWS_Network_NetworkAdmins
	* Some "overarching" Examples: AWS_GlobalAdministrators, AWS_GlobalNetworkAdmins, AWS_GlobalSecurityAdmins
* Considering creating new AD groups and permission sets for personas that don't come out of the box -- Developers, for example.
* Don't simply grant full Administrator to all users for an account. Taking the time to build out role-based access contributes to defense in depth, ensuring a more secure environment.

When you are ready to change AWS SSO over from the internal directory to Active Directory or a Third Party Identity Provider, take note of the implications of such a change **most notibly** all existing entitlements will be lost -- so have your AD groups configured and your Master Account root username, password and MFA handy in case you are logged out. Alternatively you could use an IAM User in the Master Account as a backup. [Follow this guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-change.html) to switch your AWS SSO identity source.

[![SSO to AD](/images/05-extend/02-federated-access-to-aws/awssso_converttoAD.png)](/images/05-extend/02-federated-access-to-aws/awssso_converttoAD.png)

{{% notice note %}}
The URL you were using to access AWS SSO may change and users may need to update their links.
{{% /notice %}}



As new AWS accounts are introduced, there will be some setup tasks necessary:
1) Creating AD groups that correspond to the Personas you want to provision
2) Adding AD Users to the group
3) Assigning the AD Group to a Permission Set for the new AWS Account in AWS SSO.

This could be automated when at scale to reduce overhead, as well as integration with Identity Management solutions.