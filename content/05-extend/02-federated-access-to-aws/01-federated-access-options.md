---
title: 'Review and Select Options for Federated Access with an Existing Identity Source'
menuTitle: 'Select Federated Access Option'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section introduces the options to enable your human users federated access to your AWS environment by using an identity source that is external to AWS Single Sign-On (AWS SSO). Once you've selected an option, further sections lead you through the process of setting up the desired option.

{{% notice info %}}
**Moving from using AWS SSO local identity store to an external identity source:** Earlier in this guide, you may have taken the default path to begin defining users and groups in the local identity source within AWS SSO.  This is a common initial step to help you quickly set up your AWS environment and provide you with the time to consider your options to reuse an existing identity source.  If you choose one of the AWS SSO options listed below, you will need to plan for the implications of the change. See [Considerations for Changing Your Identity Source](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-considerations.html) for details.
{{% /notice %}}

## Requirements

You may have one or more of the following requirements as you consider reusing your existing identity source to help control human access to your AWS environment:

**End User Requirements**
* Ease of requesting access to AWS via standard enterprise processes.
* Ease of authorized users using the AWS CLI, SDKs, and API based on their corporate identities and federated access.

**Security Requirements**
* Use your existing identity source and enterprise access control capabilities so that you can take advantage of your standard processes for defining, requesting, granting, and revoking access across all applications including your AWS environment.
* Avoid management of human user and group information within your AWS environment.
* Multi-factor authentication (MFA) for all human access to your AWS environment.
* Ease of mapping enterprise access control roles and entitlements to combinations of AWS accounts and IAM roles in those accounts.
* Ease of updating and distributing access permissions throughout your AWS environment.

**Operational requirements**
* Ease of extending and removing access as new AWS account are created and retired.

## Solution options

The following options are typically considered when you intend to reuse an existing identity source in support of your requirements for federated access to your AWS environment:

* SAML 2.0 Identity Provider with AWS SSO
* Microsoft Active Directory (AD) Directory with AWS SSO
* SAML Identity Provider with AWS IAM

In later sections, this guides goes into more detail on the first two options given that they suit the majority of customers' needs.

### Overview of options

The following decision tree provides a summary of your options based on your requirements.  Generally, if you already have a SAML identity provider (IdP) or intend to establish one, we recommend using your SAML IdP to enable reuse of your existing identity source.  If you don't plan on having a SAML IdP to use for this purpose, then you can integrate your existing AD with AWS SSO.

If you have specific SAML IdP needs that can't be met via integration with AWS SSO, then it's likely that you can use your SAML IdP directly with AWS IAM.  For example, if you need to integrate multiple SAML IdPs, then you would integrate those IdPs directly with AWS IAM.

[![Federated Access Options](/images/05-extend/02-federated-access-to-aws/federated-access-to-aws-decision-tree.png?height=500px)](/images/05-extend/02-federated-access-to-aws/federated-access-to-aws-decision-tree.png)

### SAML 2.0 Identity Provider with AWS SSO

If you either already have a SAML 2.0 IdP that you use in support of other enterprise applications or you plan to establish an IdP for this purpose, the most straightforward route is to use AWS SSO in conjunction with a SAML 2.0 IdP.

Review the [Connect to Your External Identity Provider](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-idp.html) for an overview of this option and a list of the supported identity providers.

Here are several examples of this option:
* [AzureAD](https://aws.amazon.com/blogs/aws/the-next-evolution-in-aws-single-sign-on/) using AzureAD's SCIM (System for Cross-domain Identity Management) endpoint. This enables automated provisioning which is very useful for AWS Organizations with more than 20 Accounts!
* [Okta](https://youtu.be/_zqHFlaqSTg) for automated provisioning using Okta's SCIM capability, enabling automated provisioning for organizations with more than 20 accounts.

### Microsoft Active Directory (AD) Directory with AWS SSO

If you don't already have a SAML 2.0 IdP that you use in support other enterprise applications and you don't plan to establish one, then you might consider integrating your Microsoft Active Directory (AD) directory with AWS SSO.  This option may be especially convenient if you already plan to have AD directory services in your AWS environment in support of workloads that depend on AD.

Review [Connect to Your Microsoft AD Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-ad.html) for an overview of this option.

### SAML Identity Provider with AWS IAM

If you have a requirement to use a SAML 2.0 IdP, but AWS SSO does not meet your needs, you can establish federated access directly via AWS IAM.  This option predates AWS SSO.

Review [Integrating third-party SAML solution providers with AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml_3rd-party.html) for an overview of this option.

In this option, you take on the responsibility of provisioning IAM SAML provider resources in each AWS account and managing the distribution of SAML IAM roles to each account.  Setting up and making use of end user to the AWS CLI, SDK, and APIs requires more work on your part.

AWS SSO provides some benefits over this traditional option:
* AWS SSO automatically provisions SAML provider resources in your AWS accounts.
* AWS SSO automatically distributes permissions to your AWS accounts.
* AWS SSO provides built-in support for your users to use AWS CLI, SDK, and API with federated access.
* AWS SSO integrated with AWS Organizations to ease federated access management in a multi-account environment.

There are a few considerations that might still lead you to use this traditional option:
* Your IdP of interest isn't yet supported by AWS SSO.
* You need to integrate multiple SAML 2.0 IdPs into your AWS environment.
* You need complete control over distribution and provisioning of federated access permissions via SAML IAM roles.

Here are several examples of using external SAML IdPs directly with AWS IAM:
* [Okta](https://support.okta.com/help/s/article/Support-for-Multiple-Accounts-in-AWS)
* [ADFS](https://aws.amazon.com/blogs/security/enabling-federation-to-aws-using-windows-active-directory-adfs-and-saml-2-0/)
* [OneLogin](https://onelogin.service-now.com/kb_view_customer.do?sysparm_article=KB0010344)

## Integrate your selected option

If you choose either of the first two options, you can proceed to one of the following sections to review the detailed architecture and setup steps:
 
* SAML 2.0 Identity Provider with AWS SSO (section forthcoming)
* [Microsoft Active Directory (AD) Directory with AWS SSO]({{< relref "03-aws-sso-ad" >}})