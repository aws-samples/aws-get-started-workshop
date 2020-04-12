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

---
**Review Notes: For now add ideas and references to existing publicly available resources**

Let's build up ideas and refine as we go.

---

## Requirements

*...use the CAF perspectives to represent the typical set of customer requirements...*

## Solution Options and Resources

*...defer to existing documentation including decision trees, blog posts, formal AWS docs, etc. as much as feasible...*

### Migration From Use of Locally Managed Groups and Users in AWS SSO

*...if the customer started with the use of locally managed users and groups in AWS SSO, highlight considerations when miograting to the use of external identity providers either via AWS SSO or traditional federated access to AWS outside of AWS SSO...*