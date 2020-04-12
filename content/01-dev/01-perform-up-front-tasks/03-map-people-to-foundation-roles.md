---
title: "Map People to Foundation Functional Roles"
menuTitle: "3. Map People to Roles"
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step you will identify the people on your nascent cloud foundation team who will play an initial set of functional roles in establishing, securing, and maintaining the cloud foundation so that your expectations are set in terms of accountability, ownership, and required skills and training.

A subsequent section of this guide helps you tie these functional roles to specific permissions on the AWS platform. 

## Start With a Small Foundation Team

Typically, several capable infrastructure oriented engineers are identified to play the role of the initial set of cloud administrators. Playing this role effectively requires that it is treated as a full-time assignment.

In some cases, where the people resources can be made available and there’s a business need in this early stage, several technologists from your Security team may take on the functional role of Security Administration from the start.  In other cases, in this early stage, that functional role may be delegated to the same people who are playing the role of Cloud Administration.

Even in cases where roles are initially played by the same people, it’s recommended that you start with a separate set of functional roles so that, in the spirit of separation of duties, the access permissions are separated from the start and pave the way for an easier transition to a broader set of administrative teams as your adoption of the cloud expands.

A common mistake made in this early stage of the journey is to assume that people playing certain functional roles in your existing on-premises environment must play a set of corresponding functional roles in the cloud.  Although eventually many of your infrastructure and security people may transition to functional roles in managing your use of cloud resources, to start, it’s a best practice to have a small number of close-knit technical people manage your initial adoption of the cloud.

## Map People to Typical Starter Foundation Functional Roles
The following table lists a typical set of minimal functional roles to own and manage your initial iteration of your cloud foundation. You should be able to identify 1-2 people in your organization who will play these functional roles and have these responsibilities for at least this stage of your cloud adoption journey.

|Foundation Functional Role	|Description	|Responsibilities	|
|---	|---	|---	|
|**Cloud Administration**|Write access to cloud foundation resources.|<p>* Create and manage shared cloud infrastructure. For example, AWS accounts and shared networking resources.<br><br>* Onboard new development teams on usage of their cloud development environments.<br><br>* Manage IP address CIDR block allocations.</p>|
|**Security Administration**|Write access to cloud foundation security resources.|<p>* Become skilled in AWS security including IAM.<br><br>* Provision and manage IAM roles and policies.<br><br>* Create and manage baseline security policies in AWS.<br><br>* Analyze access and configuration logs.<br><br>* Monitor and respond to AWS usage security events.<br><br>* Learn and promote cloud security best practices.</p>|
|**Cost Management**|Write access to cost budgets and reporting.|<p>* Monitor overall clound spend.<br><br>* Create, manage, and ensure access to cost and budget reports.<br><br>* Learn and apply fundamentals of cloud cost optimization practices.|
|**Audit**|Read only access to all AWS resources.|Periodically review environment configuration and data hosted in AWS for compliance.	|

## Define Additional Foundation Functional Roles Over Time

When adoption of the cloud expands and the foundation becomes more capable and complicated, you may chose to introduce additional foundation functional roles to spread the ownership and work of managing the foundation across more teams. 

For example, a Network Administration functional role played by Network Engineering team members may be useful as the cloud foundation networking capabilities expand over time. 

Another common example is for your Security Incident Response team to become more directly involved in the cloud and have a corresponding Incident Response functional role with appropriate access permissions.

## Use Separate Builder Team Functional Roles

In addition to the foundation functional roles listed above, a later section in this guide will help you represent builder team oriented functional roles to be used by teams that need to experiment, develop, and test early forms of business applications, data services, and/or foundation capabilities.

People playing foundation functional roles will also be granted access to builder team oriented functional roles so that they can select the proper set of permissions depending on which functional role they are playing at a given time. For example, a person who is playing the Cloud Administration functional role will assume the associated permissions when they are performing cloud administration work, but will assume a different set of permissions when performing development and early testing work to help evolve the foundation.