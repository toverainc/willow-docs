---
comments: true
title: Quick Start Guide
---

# Foreword

The initial Willow release was very much developer / early adopter focused. The on-boarding process was quite cumbersome, and not really targeted at end users. We have tried improving the on-boarding process, and we believe we are ready to release this new and improved version. This quick start guide will initially be very brief. It will be expanded and improved based on user feedback. Initial feedback by early testers has been very positive.

Before we start, we'll briefly talk about the main components used and their purpose.

## Willow Application Server

The [Willow Application Server](https://github.com/toverainc/willow-application-server) (WAS) is a web-based component that facilitates dynamic configuration, Over-the-Air (OTA) updates, and basic monitoring.

## Willow Web Flash

[Willow Web Flash](https://github.com/toverainc/willow-web-flash) is a web-based component that facilitates the initial flash of the Willow firmware image on supported hardware. It uses the [Web Serial API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Serial_API), which is only available on secure websites. As any secure website requires TLS certificates, which is not something we can expect end users to deal with themselves, we provide [a public instance of Willow Web Flash](https://flash.heywillow.io/). It will require entering your Wi-Fi credentials, as they need to be injected in the Willow firmware image before flashing it, but these credentials will never leave your browser. Willow Web Flash is based on Espressif's [esptool-js](https://github.com/espressif/esptool-js), and is 100% open source. You can inspect the source to validate our claim the Wi-Fi credentials never leave the browser.

## How it works

Using Willow with WAS consists of a few steps:

* deploy WAS from our published container image
* configure your Wi-Fi credentials, the WAS URL for your Willow device(s), and the Willow settings
* head to Willow Web Flash from the link provided in WAS and flash Willow
* once the initial flash via Willow Web Flash is done, Willow can be updated Over-the-Air from WAS, and using Willow Web Flash should only be needed for recovery in case something goes wrong

We have tried to make the experience as easy as possible.
* we try to guess the WAS URL
* we check connectivity for the various URLs configured in WAS
* we pass the WAS URL to Willow Web Flash and save it in local browser storage
  (for security reasons we do not pass the Wi-Fi credentials)

# Quick Start Guide

Now that we explained the basic workings of the new on-boarding process, let's get started!

## Deploy and configure WAS

### Deploy

```
docker run --detach --name=willow-application-server --pull=always --network=host --restart=unless-stopped --volume=was-storage:/app/storage ghcr.io/toverainc/willow-application-server:main
```

### Configure settings

Head over to the WAS web interface (http://your_was_host:8501). When running WAS for the first time, you will be instructed to go to the Configuration tab. In the Configuration tab, you will have to configure the WAS URL and Wi-Fi credentials in the Connectivity section and click Save when done. Then expand the Main settings section, choose your Willow Command Endpoint, and enter the required details to connect to it. As we implemented connectivity checks, these details will have to be correct. Click Save here as well. When both Connectivity and Main settings are saved, a link to Willow Web Flash will appear in the Configuration tab. Open this link.

!!! warning
    At the time of writing, only Chrome (or Chromium), Edge and Opera support the Web Serial API. You *must* use one of these browsers for Willow Web Flash.

## Flash Willow from Willow Web Flash

In Willow Web Flash, first click Connect. Select your Willow device from the pop-up, and click Pair. Input fields for the WAS URL and Wi-Fi credentials should appear. Enter the correct Wi-Fi credentials, verify the WAS URL, select the hardware you are trying to flash, and finally click Flash. As this will do a full flash, the process will take a few minutes. When done, the device should run Willow and connect to your WAS instance. Head back to the WAS web interface, and verify your Willow device is connected in the Home or Clients tab.

## Enjoy your new Willow Voice Assistant

Once your Willow device is flashed and connected to WAS, you can dynamically update its settings. Applying changes will reboot the device with the new settings. Should you enter a wrong WAS URL or Wi-Fi credentials, you will have to do a full flash via Willow Web Flash again.


