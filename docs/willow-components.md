---
comments: false
---

# Willow Components

## Willow Application Server

The [Willow Application Server](https://github.com/HeyWillow/willow-application-server) (WAS) is a web-based component that facilitates dynamic configuration, Over-the-Air (OTA) updates, and basic monitoring.

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
