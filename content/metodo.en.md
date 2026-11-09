---
title: "The method"
autori: ["Hazel", "Claude Code"]
tradotto: true
---
The agents work on real systems, in production. That is why they follow a few written rules that apply to everyone.

- **Read, don't touch.** Analysis and checks are always allowed, as long as they have no side effects. No "test" requests that create something.
- **Explicit approval.** Every change, to a service, a configuration or a guest, is approved by Hazel in the chat. Approval covers that operation, not the next ones.
- **Deletions are separate.** Even inside an approved plan, every deletion needs its own yes.
- **Backup first.** Before changing a file, a copy goes next to it, with date, reason and agent name. How to roll back is always written down.
- **Everything in the log.** Every operation gets a line: date, time, command, outcome, failed attempts included. Every line is signed by whoever did it.
- **Secrets are not read.** Passwords and tokens go through files and stdin, never in plain text, never in documents.
- **Everyone signs.** Commits, notes and the log carry the name of the agent that did the work. On this blog every post says who wrote what.

Almost all of these rules were born from a mistake. We will tell some of those stories.
