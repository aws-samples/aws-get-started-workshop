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

## Separate AWS Accounts for Shared Builder Services

Similarly, AWS best practices recommend that one or more separate AWS accounts are established to host shared builder services that are used to help build, test, and release your applications and cloud resources to the test and production hosting environments. Since CI/CD pipelines, source code management, artifact repositories, and other builder resources are considered production resources, they are not typically managed in development environments. Again, some degree of analysis and design is typically needed to identify the specific approach that best suits your requirements.

## Expanded Use of AWS Transit Gateway to Support Test and Production VPCs

If your test and production workloads need to integrate with on-premises resources and services, the AWS Transit Gateway configuration can be extended to enable routing between those environments.

## Cloud Hosted Internet Ingress and Egress Security Services
If your organization has strict requirements for securing Internet access, then hosting your enterprise standard security services in a dedicated set of VPCs managed within the **network-prod** AWS account is a common pattern.  This cloud hosted approach to securing Internet integration is more performant than depending on routing traffic back on-premises.

See the following AWS Blog posts up-to-date examples of how to use AWS Transit Gateway and third party products to support cloud-hosted ingress and egress security requirements:

* [How to Integrate Third-Party Firewall Appliances into an AWS Environment](https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-integrate-third-party-firewall-appliances-into-an-aws-environment/)
* [Securing VPC Egress Using IDS/IPS Leveraging Transit Gateway](https://aws.amazon.com/blogs/networking-and-content-delivery/securing-egress-using-ids-ips-leveraging-transit-gateway/)

## Dedicated Account VPC
{{% notice tip %}}
**Understand whether the workload uses a VPC:** Not all AWS services use a Virtual Private Cloud.  Many workloads are entirely composed of "serverless" services like Lambda, DynamoDB, and S3.  In this case you can avoid provisioning a VPC in the workload accounts.
{{% /notice %}}

If the workload does require a VPC, your Network Administrators will create a VPC that resides in the test and prod workload accounts.  This will allow for more isolation and workload-specific VPC configuration than you would typically need in development scenarios

### Need For Public Subnets
A public subnet enables communication to and from the internet.  In certain hybrid networking scenarios, internet egress may be done by moving the traffic back on-premises in a "hairpin" architecture.  If this is the case, you may only need to provision private subnets in the workload accounts.

## Workload Administration Team Support
A role will be created to enable for administration and support of the deployed workload.  The intent is separation of duties from the Foundation and Development teams we created in previous sections.  The workload administration team may also take the primary brunt of deployment responsibilities, unless and until release management processes can be automated.
