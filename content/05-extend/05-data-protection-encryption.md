---
title: 'Data Protection and Encryption'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Using encryption to help protect your data in production is a common requirement. Transport Layer Security (TLS) is used with every AWS service.  In support of using TLS with both your own applications and resources configured via AWS services, you can use [AWS Certificate Manager](https://aws.amazon.com/certificate-manager) to manage certificates.  

In support of encryption at rest, you'll want to learn more about [AWS Key Management Service (KMS)](https://aws.amazon.com/kms). AWS Key Management Service (AWS KMS) is a managed service that makes it easy for you to create and control customer master keys (CMKs), the encryption keys used to encrypt your data.

Refer to the AWS documentation of the AWS services on which your workloads depend for more information on encryption capabilities.