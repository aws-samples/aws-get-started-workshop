---
title: 'Review Test and Production Environments Solution'
menuTitle: '1. Review Solution'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Beyond supporting initial development and early testing within the development environments, you will soon need to support formal testing and eventually production hosting of your new applications and data services.  The following diagram represents typical extensions to your cloud foundation and a new set of AWS accounts to support formal testing and production hosting environments.

[![Initial Test and Production Environments in Single AWS Region](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)

Key aspects of a solution that supports a typical transition toward support for several projects and their workloads progressing toward formal testing and production include:

## Separate AWS Accounts for Hosting test and Production Workloads

AWS best practices recommend isolating test and production workloads, data, and supporting cloud resources from each other and from development environments through the use of distinct AWS accounts.  Whether you choose to define test and production AWS hosting accounts based on the owning delivery teams, collections of related services, or another basis, will depend on your requirements.  Typically some analysis and design is needed to define the specific approach.

## Dedicated Account VPC

{{% notice tip %}}
**Understand whether the workload uses a VPC:** Not all AWS services use a Virtual Private Cloud.  Many workloads are entirely composed of "serverless" services like Lambda, DynamoDB, and S3.  In this case you can avoid provisioning a VPC in the workload accounts.
{{% /notice %}}

If the workload does require a VPC, your Network Administrators will create a VPC that resides in the test and prod workload accounts.  This will allow for more isolation and workload-specific VPC configuration than you would typically need in development scenarios

### Need For Public Subnets
A public subnet enables communication to and from the internet.  In certain hybrid networking scenarios, internet egress may be done by moving the traffic back on-premises in a "hairpin" architecture.  If this is the case, you may only need to provision private subnets in the workload accounts.

## Workload Administration Team Support
A role will be created to enable for administration and support of the deployed workload.  The intent is separation of duties from the Foundation and Development teams we created in previous sections.  The workload adminstration team may also take the primary brunt of deployment responsibilities, unless and until release management processes can be automated.
