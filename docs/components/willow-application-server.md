---
comments: false
---

# Willow Application Server  (WAS)

The Willow Application Server provides:

- Dynamic configuration. Update the configuration across all of your devices with a single click.
- Updates. WAS can fetch the most recent Willow releases and apply them to your devices over the air.

## Getting Started

We have tried to simplify the onboarding process as much as possible. It is no longer required to build Willow yourself.
All you have to do is run Willow Application Server and connect to it. From there, you will be guided to the Willow Web Flasher, which will download a Willow dist image from Github, inject your Wi-Fi credentials into the NVS partition, and flash it to your device.

### Running WAS

```
docker run --detach --name=willow-application-server --pull=always --network=host --restart=unless-stopped --volume=was-storage:/app/storage ghcr.io/toverainc/willow-application-server
```

### Building WAS
```
git clone https://github.com/toverainc/willow-application-server.git && cd willow-application-server

./utils.sh build
```

### Start
```./utils.sh run```

## Configure and update Willow devices
Visit ```http://my_was_host:8502``` in your browser.

## OTA
We list releases with OTA assets. Select the wanted release and click the OTA button. If the release is not already cached in WAS, WAS will download the binary from Github and cache it, then instruct Willow to start OTA with the URL of the cached asset. This makes it possible to run Willow in an isolated VLAN without Internet access.

To use a self-built binary for OTA, place it in the the ota/local directory of the was-storage volume using the following filenames:
* willow-ota-ESP32_S3_BOX.bin
* willow-ota-ESP32_S3_BOX_LITE.bin

To copy the file to the running container:

```
docker cp build/willow.bin willow-application-server:/app/storage/ota/local/willow-ota-ESP32_S3_BOX.bin
```

## WAS Command Endpoint mode

Initially, Willow could only connect to command endpoints directly. With the introduction of WAS, we also introduced an experimental feature named _WAS Command Endpoint mode_. With this feature enabled, WAS will connect to the command endpoint instead. There are several advantages to this approach:

* adding support for new command endpoints will be done in WAS (Python), which should be easier than adding it to Willow (C)
* reduced resource usage on the Willow device
* the hardware running WAS will almost always be much more powerful than the device running Willow, which improves the overal performance and latency

To enable the feature, go to _Configuration_, _Advanced_, check the WAS Command Endpoint checkbox, and click _Save settings & apply everywhere_.

In the future, WAS Command Endpoint mode will be unconditionally enabled, and other endpoints will be removed from Willow.
