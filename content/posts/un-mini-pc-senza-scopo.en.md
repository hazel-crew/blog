---
title: "A mini PC with no purpose"
date: 2026-11-09
autori: ["Hazel", "Claude Code"]
tradotto: true
slug: a-mini-pc-with-no-purpose
---
A year ago a mini PC landed on the desk. Nothing special: an eight-core Ryzen, 32 GB of RAM, an SSD. Along with it came a UniFi router, the UCG-Max, and a fibre connection with 2.5 Gbit/s down and 1 up. No real plan. Hazel works in IT and knew the basics of Linux, but had never run a real server. There was the wish to learn something new, hands-on, and to understand how the things we use every day actually work. And a question that had been on Hazel's mind for a while: *"Where does my data end up? What if I kept it myself?"*

There was something else too. After a few hard years, personally and at work, Hazel was looking for a place to learn for the joy of it, where solving a problem felt rewarding and where the decisions were Hazel's own. The day job had become too tight a fit. So, alongside everyday life, a parallel one was born: Hazel-Lab.

Then came the more practical question: *"So what do I run on it?"* The answers came one piece at a time, almost always from GitHub: an open source project, a README to read all the way through, a community to ask when something didn't add up.

## The first lessons

- **Proxmox.** Instead of a plain operating system, a hypervisor: virtual machines and LXC containers, each with its own job. Breaking things hurts less when you can roll back to a snapshot.
- **Docker.** The first services in containers, the first `compose` files, the difference between a container, which you throw away and recreate, and the data it has to keep.
- **Self-hosting.** Home DNS, Home Assistant, a reverse proxy, a single login for every service. Every new service comes with a question: what if it breaks?
- **Backups.** The most important lesson: a backup you have never tried to restore is not a backup.

## Then the crew arrived

The bigger the lab grew, the bigger the boring part grew: checking logs, tracking changes, remembering why a configuration is the way it is. That is where the AI agents came in.

Not as a tool to ask something now and then, but as crew members with a role. The agents analyse, propose, execute once Hazel approves, and write everything down in the log. Hazel decides, knows the context and is accountable for what happens. The rules for working together are on [The method](../../metodo/) page.

## What you will find here

The journal of this adventure, one step at a time: how to build a homelab that holds up, what happens when something goes wrong, how a mistake becomes a rule. We don't claim to be experts: we learn by doing, and sometimes by getting it wrong.

*"Where does my data end up?"* A year later the answer is simpler: right here, on this desk, with a copy somewhere else and a log that remembers every change. We'll tell the rest as we go, mistakes included.

*Posts are published in Italian and English.*
