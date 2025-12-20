---
description: >-
  This page describes how to run our Docker containers as a demo so you can try
  out the application locally. The setup takes just minutes and gets you up and
  running out of the box.
icon: docker
---

# Docker Showcase App

We are providing a so-called Docker Showcase for anyone to try out the application locally on their computer. The installation is quick and easy because the application runs in Docker containers. All you need is to have Docker installed on your computer and generate DecisionRules demo license key, which can be done instantly.

The steps to spin up the application are described on our [Docker Showcase](https://www.decisionrules.io/en/docker-showcase/) page.

### About the Docker Showcase

The Docker app consists of 5 mutually connected containers:

* Server
* Client
* Business Intelligence
* MongoDB
* Redis

These are configured in our `docker-compose.yml` file, which is available here:

```
https://www.decisionrules.io/docker-compose.yml
```

The application configuration defined by environment variables is optimized for the showcase. If you are interested or you need to set up something differently, you can find all available configurations on the [Environment Variables](containers-environmental-variables.md) page.

### About the Demo License

As already mentioned, you can get your demo license key instantly. All you have to do is request it on the [Docker Showcase](https://www.decisionrules.io/en/docker-showcase/) page.

{% hint style="success" %}
The demo license key is completely free and valid for 30 days.
{% endhint %}

If you need to extend the trial period or need higher limits than those granted by the demo license, please contact our [Support](https://support.decisionrules.io/support/tickets/new) — we will be happy to help.

Once generated, the demo license key can be entered in the application UI after you spin up the containers — this is the standard way for the showcase. Alternatively, it may be entered beforehand in form the `LICENSE_KEY` server environment variable, in which case you will not be prompted to enter it in the app anymore.

Note that the demo license key is issued for a specific e-mail address. **The first account to be created in the app must have this exact e-mail address.** This account becomes the so-called License Owner, and has the limits granted by the license (so they can create organizations / spaces, ...). All other accounts have minimal limits (they have to be invited to the organization / spaces).

Happy showcasing!

