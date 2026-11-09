---
title: "Two Pi-holes, one Unbound and an address that kept vanishing"
date: 2026-11-09T15:00:00+01:00
autori: ["Hazel", "Claude Code"]
tradotto: true
slug: two-pi-holes-one-unbound
---
The first real service in Hazel-Lab was DNS. Not by chance: if the question was *"Where does my data end up?"*, DNS is the first place to look. Every website you open, every app that connects, every device that "phones home" goes through it first. Whoever answers DNS queries knows a lot about what happens on a network.

The recipe, the one many self-hosters recommend, looked simple: [**Pi-hole**](https://github.com/pi-hole/pi-hole) to block ads and trackers, [**Unbound**](https://github.com/NLnetLabs/unbound) as a recursive resolver, so queries don't have to go to Google or Cloudflare.

It looked simple. It turned into the story of Hazel's first three mistakes, and of what they taught us.

## Mistake #1: a virtual machine for everything

Hazel figured one thing out early: if DNS stops, for everyone at home "the internet is down". So there were two Pi-holes right from the start.

Two DNS servers, though, bring a new problem straight away: they have to say the same thing. A blocklist added to only one, a forgotten exception, a missing local name, and devices get different answers depending on which server they ask. That's where [**nebula-sync**](https://github.com/lovelaze/nebula-sync) came in, copying the configuration from one Pi-hole to the other.

So the first version of the home DNS looked like this: **two virtual machines** for the Pi-holes, **a third virtual machine** just for nebula-sync, and an LXC container for Unbound.

The instinct was right, the execution wasn't. Here is the first mistake: a whole VM for such a lightweight service means a full operating system to update, reserved RAM and disk, slow boots. And a whole VM for a program that now and then copies a few settings from one server to another is little short of a monument to waste.

It would take a while to realise that. How we got out of it is the subject of the next post.

## An address that never changes

There was still the question of the address. Clients need to know whom to ask, and if the configured server goes down, they don't always switch to the second one quickly. The answer was [**keepalived**](https://github.com/acassen/keepalived): a shared virtual IP address that normally lives on the first Pi-hole and moves to the second if the first one fails. As far as the home network was concerned, there was a single DNS server, always on.

*"Two servers, in sync, behind an address that never changes. This time it's done right."*

## Mistake #2: one Unbound behind two Pi-holes

Unbound, on the other hand, was a single instance in its own dedicated LXC container. Both Pi-holes forwarded their queries to it. Hazel had doubled the piece in front and left the one behind it single, without noticing: this was the most important mistake.

The problem showed up in a strange way: every now and then, the Unbound container **lost its IP address**. It didn't matter whether the address was set statically in Proxmox or reserved on the router: at some point it vanished and Unbound was no longer reachable.

Looking back, we're not the only ones. The Proxmox and LXC forums have quite a few reports of Debian containers that lose their address after a few hours, or don't get one at all at boot. Unbound adds one more ingredient: the Debian package installs a helper service, `unbound-resolvconf`, that touches the system's DNS configuration and inside a container doesn't always get along with the way networking is managed. In the documented cases the fix is to disable that service, or to manage the container's network with `ifupdown` instead of `systemd-networkd`. Whether that was exactly our case we'll never know: that container no longer exists.

Whatever the cause, the result was crystal clear. Both Pi-holes were up, in sync, reachable at the virtual address, and unable to resolve anything. At home, for everyone, the internet simply didn't work. All the redundancy built upstream depended on a single container downstream. The system looked doubled, but it had a single point of failure right in the middle.

The lesson goes well beyond DNS: **redundancy only counts if it covers the whole chain.** Two copies of one piece are no use if the next piece is a single one.

## Mistake #3: five pieces to do one thing

Two Pi-holes, nebula-sync, keepalived, Unbound: running the home DNS took five components, each with its own configuration, its own updates and its own ways of breaking. Every problem had been solved by adding a piece, and every piece added was one more place where something could go wrong. That was the third mistake: chasing problems one at a time without stepping back to look at the whole.

## The truth we'd rather not say out loud

There's a detail we've elegantly glossed over so far. Two Pi-holes, a program keeping them in sync, a virtual address hopping from one to the other: all this redundancy runs on the **same mini PC**. Same power supply, same system disk, same power socket behind the desk.

We built a DNS that survives a container failure. A host failure, on the other hand, it handles with great consistency: everything goes down together, in perfect sync. A kernel update with a reboot, a ten-second power cut, a foot catching the cable, and redundancy becomes a philosophical concept.

*"So I have two DNS servers for when one breaks… but not for when the house they live in breaks."*

Does it still make sense? Yes, but for the right reason. Two servers on the same host protect you from a container that hangs, an update gone wrong, a configuration mistake on one of the two: all things that happen in a homelab far more often than a mini PC dying. Protecting against the rest takes a second node and a UPS. They're on the wish list, along with a NAS. More on that another time.

## What we take away

- **DNS is critical infrastructure.** At home it gets noticed more than any other service, because when it stops it feels like everything has stopped. Hazel's partner can tell you all about it.
- **VM or container?** For a lightweight service, an LXC container is almost always the right choice.
- **Redundancy means synchronisation.** Two servers saying different things are a new problem, not a solution.
- **Look for the weak link.** Before calling something "redundant", follow a request from start to finish and ask: if this piece goes down, what happens?
- **Know what you're protected from.** Two copies on the same host protect against software failures, not hardware ones. That's perfectly fine, as long as you don't kid yourself.
- **Fewer pieces, fewer failures.** Sometimes the best fix isn't adding a component, but removing four.

*"Five pieces to do one thing. There had to be a simpler way."*

There was. But to find it, Hazel first had to learn a thing or two about containers. That's the story of the next post.
