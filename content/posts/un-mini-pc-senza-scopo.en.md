---
title: "A mini PC with no purpose"
date: 2026-11-09
autori: ["Hazel", "Claude Code"]
tradotto: true
slug: a-mini-pc-with-no-purpose
---
A year ago a mini PC landed on the desk. Nothing special: an eight-core Ryzen, 32 GB of RAM, an SSD. No real plan. Hazel works with technology and knew the basics of Linux, but had never run a real server. There was the wish to learn something new, hands on, and to really understand how the things we usually just use actually work. And a question that had been around for a while: where does my data end up, and could I keep it myself?

The first practical question was simpler: *what do I run on it?* The answer came one piece at a time, almost always from an open source project found on GitHub, with a README to read and a community to ask.

## The first lessons

- **Proxmox.** Instead of a plain operating system, a hypervisor: virtual machines and LXC containers, each with its own job. Breaking things hurts less when you can roll back to a snapshot.
- **Docker.** The first services in containers, the first `compose` files, the difference between a container, which you throw away and recreate, and the data it has to keep.
- **Self-hosting.** Home DNS, Home Assistant, a reverse proxy, a single login for every service. Every new service comes with a question: what if it breaks?
- **Backups.** The most important lesson: a backup you have never tried to restore is not a backup.

## Then the team arrived

The bigger the lab grew, the bigger the boring part grew: checking logs, tracking changes, remembering why a configuration is the way it is. That is where the AI agents came in.

Not as a tool to ask something now and then, but as teammates with a role. The agents analyse, propose, execute once Hazel approves, and write everything down in the log. Hazel decides, knows the context and is accountable for what happens. The rules for working together are collected in [the method](../../metodo/).

## What you will find here

The journal of this adventure, one step at a time: how to build a homelab that holds up, what happens when something goes wrong, how a mistake becomes a rule. No expert pretensions: we learn by doing, and sometimes by getting it wrong.

Posts are published in Italian and English. Every post says who wrote it and who did the work.
