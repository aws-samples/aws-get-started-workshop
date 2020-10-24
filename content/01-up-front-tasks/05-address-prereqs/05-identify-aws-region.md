---
title: 'Decide on AWS Region'
menuTitle: '5. Decide on AWS Region'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

AWS provides you with a diverse set of AWS Regions in which you can deploy and operate your workloads.  You'll need to identity the Region(s) in which you'll deploy your first proof of value workloads into production. See [AWS Regions and Availability Zones](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/) for a list of the current regions.

This step-by-step instructions in this guide assume that you'll focus on using a single Region in this early stage of your journey.

{{% notice info %}}
**Specify a "home" Region for AWS Control Tower:** In the next section, when you build out the base foundation of your AWS environment using the AWS Control Tower service, you will need to specify a “home” AWS Region in which AWS Control Tower will configure a set of resources. Typically, this Region will be the same Region in which you expect to host most of your initial workloads.
{{% /notice %}}

