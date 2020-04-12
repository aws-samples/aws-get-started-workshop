---
title: "Secure OS Access"
disableToc: true
weight: 40
---

## Secure Terminal Access for Linux and Windows

See [AWS Systems Manager Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html) to learn how to achieve secure terminal access to your Linux and Windows OS instances without the need to establish and maintain Internet-accesible bastion hosts.  In the Windows context, you're provided with a Powershell terminal.

## Secure Remote Desktop (RDP) Access for Windows

Session Manager can also be used to provide RDP access to your Windows instances. See [Forwarding Traffic Between a Local and Remote Port](https://aws.amazon.com/about-aws/whats-new/2019/08/now-forward-traffic-between-a-local-and-remote-port-using-session-manager/) for an overview of this solution and the [re:Invent 2019 lab](https://reinvent2019.aws-management.tools/mgt406/en/optional/step7.html) for a detailed example.