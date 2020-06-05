---
title: 'Enhanced Security Monitoring and Compliance'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section addresses requirements, options, and resources to enable your Security and Cloud Administrators to extend the degree of preventative, detective, and corrective controls.

Support for custom AWS account baselines can be the means to roll out such controls, but this section focuses on what controls are of most interest.

## Examples

* An application requires a named IAM user to access the AWS platform with an API key and secret, configure additional alarms and logs when these credentials are used.
* Expunge default VPCs from all AWS accounts and AWS regions in those accounts.
* Restrict access to AWS services to only the enterprise’s IP addresses.
* Restrict access to workloads deployed to development AWS accounts to only the enterprise's public IP addresses.

## AWS Control Tower Guardrails

Review the [strongly recommended and elective guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails-reference.html) to determine if they provide value in your environment.
