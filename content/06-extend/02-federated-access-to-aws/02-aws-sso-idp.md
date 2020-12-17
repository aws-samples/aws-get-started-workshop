---
title: 'AWS SSO and SAML 2.0 Identity Provider'
menuTitle: 'AWS SSO and SAML IdP'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is in the process of being drafted.
{{% /notice %}}

{{% notice info %}}
When new AWS Accounts are created in the Organization, there is configuration necessary to onboard it into the Identity Provider and create relative Active Directory Security Groups for each Role you wish you provision. This is called Manual Provisioning. For less than 20 AWS accounts this generally isn't a problem, however, when larger Enterprises start to create hundreds or even thousands of accounts, this creates unnecessary management overhead and requires an automated solution. AWS SSO and AzureAD support Automatic Provisioning. [Review the Considerations](https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-automatically.html).
{{% /notice %}}