---
title: 'Review On-Premises Network Integration Use Cases'
menuTitle: 'Review Integration Use Cases'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section introduces a typical set of use cases that may lead your organization toward establishing network connectivity between your on-premises and AWS environments.

The following typical use cases are organized based on whether the motivation for connectivity is driven by users and workloads housed in either your AWS environment or your on-premises environment.  Often, more than several of these use cases will apply.

## AWS Users and Workloads Depend on On-premises Resources and Data

Your builders and workloads in your AWS environment have dependencies on services residing in your on-premises environment. For example:

**Application and/or Data Dependencies** - Workloads in your AWS environment need to access application and/or data services residing in your on-premises environment.

**Cloud Migration** - Your use of cloud migration services and tools such as (CloudEndure Migration](https://aws.amazon.com/cloudendure-migration/) may require connectivity between your on-premises workloads and your AWS environment.

**Access to Enterprise Builder Tools** - Builders and automated deployment tasks working in your AWS environment may need access to on-premises source code and artifact management services.

**Active Directory** - Users and workloads in your AWS environment may depend on your Active Directory (AD) services for authentication based on your centrally managed user identities and coarse grained authorization via centrally managed AD security groups.

**DNS** - Users and workloads in your AWS environment may need to use DNS to resolve domain names for services residing in your on-premises environment.

**Internet Ingress/Egress** - Builders and workloads residing in AWS and requiring ingress and/or egress access access to the Internet may initially depend on routing traffic through your existing on-premises network security proxying and filtering services.  Over a longer period of time, you may choose to house these services directly in your AWS environment.

## On-premises Users and Workloads Depend on AWS Workloads and Data

Your on-premises users and workloads have dependencies on workloads and data residing in your AWS environment. For example:

**Application and/or Data Dependencies** - Workloads in your on-premises environment may need to access application and/or data services residing in your AWS environment.

**Private Access to AWS Services** - Users and workloads in your on-premises environment may need private, non-Internet, means of accessing AWS service APIs. For example, via  [AWS PrivateLink](https://aws.amazon.com/privatelink/).

**DNS** - Users and workloads in your on-premises environment may need to use DNS to resolve domain names for services residing in your AWS environment.