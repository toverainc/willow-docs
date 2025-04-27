---
comments: false
title: Quick Start Guide
---

# Quick Start Guide

## Overview
Willow is more than the software that runs on the device. Willow has a couple of [additional components](willow-components.md) to enable full Willow functionality.

The [Willow Application Server](components/willow-application-server.md) is required to manage and configure your Willow devices and needs to be installed before you can flash them.

## Install WAS
We provide a WAS docker image to get you up and running quickly. To start:

```
docker run --detach --name=willow-application-server --pull=always --network=host --restart=unless-stopped --volume=was-storage:/app/storage ghcr.io/heywillow/willow-application-server
```

### Access WAS

To access your running WAS instance you will need to know the IP address/host of the machine running WAS. If you don't know the IP address you can start by trying the IP address of the default interface.

On the machine running the WAS container:

```
ip route get 1.1.1.1 | grep -oP 'src \K\S+'
```

For example, if this command outputs 192.168.1.1 your WAS URL is ```http://192.168.1.1:8502```

Open your WAS address in a web browser on a network that can reach it.

### Configuring Willow with WAS

When running WAS for the first time you will be instructed to go to the Configuration tab. In the Configuration tab, you will have to configure the WAS URL and Wi-Fi credentials in the Connectivity section and click Save when done. 

Then expand the Main settings section, choose your Willow Command Endpoint, and enter the required details to connect to it. As we implemented connectivity checks, these details will have to be correct. Click Save here as well. When both Connectivity and Main settings are saved, a link to Willow Web Flash will appear in the Configuration tab. Open this link.

!!! warning
    At the time of writing, only Chrome (or Chromium), Edge and Opera support the Web Serial API. You *must* use one of these browsers for Willow Web Flash.

## Flash Willow from Willow Web Flash

In Willow Web Flash, first click Connect. Select your Willow device port from the pop-up and click Pair. Input fields for the WAS URL and Wi-Fi credentials should appear. Enter the correct Wi-Fi credentials, verify the WAS URL, select the hardware you are trying to flash, and click Flash. This will do a full flash of your new Willow device so it will take a few minutes. Once flashing finishes the device should boot Willow and connect to your WAS instance. Head back to the WAS web interface and verify your Willow device is connected in the Home or Clients tab.

## Enjoy your new Willow Voice Assistant!

Once your Willow device is flashed and connected to WAS you can dynamically update its settings. Applying changes will reboot the device with the new settings. Should you enter a wrong WAS URL or Wi-Fi credentials, you will have to do a full flash with Willow Web Flash again to recover your Willow device.

Your Willow device is now up and running. If you want to completely self host Willow you can install and configure some additional components:

## Join our official Discord!

Stop by, say hello, chat directly with Willow developers, get support, and keep up with all things Willow!

<iframe src="https://discord.com/widget?id=1161666824178503720&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe>

## Recommended - Deploy your own Willow Inference Server (WIS)

By default Willow uses a [Willow Inference Server](components/willow-inference-server.md) hosted by Tovera so users can get up and running quickly. However, the entire goal of Willow is to be completely under your control and self-hosted. With the Tovera hosted WIS instance you're just sending your audio to us instead of Amazon, Google, etc! We don't log or store anything but we strongly encourage users to setup and configure their own WIS instance.

## Optional - Deploy your own Willow Web Flasher

It may seem strange to enter your Wi-Fi credentials in a random web page but with our [hosted web flasher](https://flash.heywillow.io) your configuration values never leave your browser. You can verify this by inspecting the code in your browser or viewing the network traffic with browser developer tools.

We provide this hosted flashing interface because browsers have very strict rules and requirements when running the Web Serial standard that our flashing tool uses to access your local Willow devices from the browser.

If you can manage the TLS certificate issues, etc you can deploy your own Willow Web Flash tool anywhere you want. Get started by visiting the [Willow Web Flash Git repository](https://github.com/toverainc/willow-web-flash).
