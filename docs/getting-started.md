# Getting Started

Configuring and building Willow for the ESP BOX is a multi-step process. We're working on improving that but for now...

## Build Willow

### Install System Dependencies

We use [tio](https://github.com/tio/tio) as a serial monitor so you will need to install that.

=== "Ubuntu/Debian"

    ```sh
    sudo apt-get install tio
    ```

=== "Arch Linux"

    ```sh
    yay -S tio
    ```

=== "Mac (with homebrew)"

    ```sh
    brew install tio
    ```

### Clone Willow Repo

```sh
git clone https://github.com/toverainc/willow.git && cd willow
```

### Set Up Docker Container

We use [Docker](https://www.docker.com/) (also supports [Podman](https://podman.io/)) for the build container. To build the container with Docker:

```sh
./utils.sh build-docker
```

Once the container has finished building you will need to enter it for all following commands:

```sh
./utils.sh docker
```

### Install Build Environment

Once inside the container install the environment:

```sh
./utils.sh install
```

## Start Configuration

Start the Willow configuration process:

```sh
./utils.sh config
```

!!! note "ESP BOX LITE NOTE!!!"
    You will need to build specifically for the ESP BOX LITE. From the main menu, select:

    ***Audio HAL ---> Audio Board ---> ESP32-S3-BOX-Lite***

Return to main menu and continue.

### Willow Configuration

Navigate to ***Willow Configuration*** to enter your Wi-Fi SSID and password (supports 2.4 GHz Wi-Fi with WPA/WPA2/WPA3 authentication), and your Willow Inference Server URI (best-effort Tovera hosted example provided).

#### Smart Home Software

=== "Home Assistant"

    For Home Assistant you will also need to create a [long lived access token](https://developers.home-assistant.io/docs/auth_api/#long-lived-access-token) and configure your server address. By default we use ```homeassistant.local``` which should use mDNS to resolve your local Home Assistant instance. Put your long lived access token in the text input area. We recommend testing both your Home Assistant server address and token before flashing.

    If your Home Assistant instance requires TLS make sure to select it.

=== "openHAB"

    openHAB also requires an [API token](https://www.openhab.org/docs/configuration/apitokens.html). Enter the URI of your openHAB instance without any paths. As usual both HTTP and HTTPS are supported. Willow will send text output to the default HLI interpreter you have configured on openHAB (we've done the most testing with HAbot and the built-in interpreter). Like Home Assistant we recommend testing both your server address and access token before flashing.

=== "Generic REST Interface"

    Willow supports sending of detected speech to any REST API endpoint via POST. You can define the URL of your API endpoint (HTTP or HTTPS) and select from no authentication, HTTP Basic, or provide a raw Authentication: header for Bearer and other mechanisms.

There are also various other configuration options for speaker volume, display brightness, NTP, etc.

#### Wake Word

If you want to change the wake word from the default ***Hi ESP*** you can navigate from the main menu to ***ESP Speech Recognition --> Select wake words --->*** and select ***Alexa*** or whichever. 

!!! note "If changing the wake word *ALWAYS* use the ```wn9``` variants."

Once you've provided those, press ++q++ and save when prompted.

### Build and Exit Container

```sh
./utils.sh build
```

When the build completes successfully you can exit the container.

## Install Willow to ESP32-S3-BOX

It's getting real now - plug the ESP32-S3-BOX in!

### Set Serial Port

Back on the host docker:

To do anything involving the serial port you will need to set the `PORT` environment variable for all further invocations of `utils.sh`.

With recent versions of `tio` you can use `tio -L` to list available ports. On Linux you can check `dmesg` and look for the path of the recently connected ESP32-S3-BOX (furthest at the bottom, hopefully). On Linux it's usually `/dev/ACM*` and on Mac it's `/dev/usbmodem*`.

!!! tip "Examples"

    === "Linux"

        ```sh
        export PORT=/dev/ttyACM0
        ```

    === "Mac"

        ```sh
        export PORT=/dev/cu.usbmodem2101
        ```

### Flash

For out of the box/factory new ESP32-S3-BOX hardware you will need to (one time) erase the factory flash before flashing Willow:

```sh
./utils.sh erase-flash
```

Once you have done that you can flash:

```sh
./utils.sh flash
```

It should flash and connect you to the serial monitor.

#### Advanced Usage

`utils.sh` will attempt to load environment variables from `.env`. You can define your `PORT` here to avoid needing to define it over and over.

The ESP-IDF, ESP-ADF, ESP-SR, LVGL, etc. libraries have a plethora of configuration options. DO NOT change anything outside of "Willow Configuration" (other than wake word) unless you know what you are doing.

If you want to quickly and easily flash multiple devices or distribute a combined firmware image you can use the `dist` arguments to `utils.sh`:

`./utils.sh dist` - builds the combined flash image (`willow-dist.bin`)

`./utils.sh flash-dist` - flashes the combined flash image

This combined firmware image can be used with any ESP flashing tool like the web based [ESP Tool](https://espressif.github.io/esptool-js/) so you can send firmware images to your less technical friends! Just make sure to erase the flash first and use offset `0x0` with those tools as we include the bootloader.

## Let's Talk!

If you have made it this far - congratulations! You will see serial monitor output ending like this:

```sh
I (10414) AFE_SR: afe interface for speech recognition

I (10424) AFE_SR: AFE version: SR_V220727

I (10424) AFE_SR: Initial auido front-end, total channel: 3, mic num: 2, ref num: 1

I (10434) AFE_SR: aec_init: 1, se_init: 1, vad_init: 1

I (10434) AFE_SR: wakenet_init: 1

MC Quantized wakenet9: wakeNet9_v1h24_hiesp_3_0.63_0.635, tigger:v3, mode:2, p:0, (May  5 2023 20:32:52)
I (10704) AFE_SR: wake num: 3, mode: 1, (May  5 2023 20:32:52)

I (13:26:42.433) AUDIO_THREAD: The feed_task task allocate stack on external memory
I (13:26:42.434) AUDIO_THREAD: The fetch_task task allocate stack on external memory
I (13:26:42.442) AUDIO_THREAD: The recorder_task task allocate stack on external memory
I (13:26:42.451) WILLOW: app_main() - start_rec() finished
I (13:26:42.457) AUDIO_THREAD: The at_read task allocate stack on external memory
I (13:26:42.466) WILLOW: esp_netif_get_nr_of_ifs: 1
I (13:26:42.471) WILLOW: Startup complete. Waiting for wake word.
```

You should see some help text on the display to use your configured wake word. Try some built in Home Assistant [Intents](https://www.home-assistant.io/integrations/conversation/) like:

- "(Your wake word) Turn on bedroom lights"
- "(Your wake word) Turn off kitchen lights"

The available commands and specific names, etc. will depend on your Home Assistant or openHAB configuration.

You can also provide free-form speech to get an idea of the accuracy and speed provided by our inference server implementation. The commands will fail unless you've defined them in Home Assistant or openHAB but the display will show the speech recognition results to get your imagination going.

You can now repeat the erase and flash process for as many devices as you want!

### Exit Serial monitor

To exit `tio` you need to press ++ctrl+t++ and then ++q++. Or you can unplug your device and ```tio``` will wait until you reconnect it.

### Start Serial monitor

If you want to see what your device is up to you can start the serial monitor anytime:

```sh
./utils.sh monitor
```

### Things Went Sideways - Reset!

In the event your environment gets out of whack we have a helper to reset:

```sh
./utils.sh destroy
```

As the plentiful messages indicate it's a destructive process but it will reset your environment. After it completes you can start from the top and try again.

### Recovery

Recover from a bad flash or persistent flash failures.

In some hardware combinations the ESP32-S3-BOX can be stubborn and won't successfully flash.

In these cases, press the BOOT/CONFIG button (top button on the left side) while powering up the device, then:

Erase the flash:

```sh
./utils.sh erase-flash
```

!!! tip 
    Depending on how tight of a boot loop your device is in, you may need to run `erase-flash` multiple times to get the timing right. It will eventually "catch" and successfully erase the flash.

    When it reports successful erase you can flash again with:
    ```sh 
    ./utils.sh flash
    ```

## Development

Development usually involves a few steps:

1. Code - do your thing!
2. Build
3. Flash

Unless you change the wake word and/or are using local command recognition ([Multinet](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/speech_command_recognition/README.html)) you can selectively flash only the application partition. This avoids long flash times with the WakeNet and MultiNet model partition, etc...

- `./utils.sh build`
- `./utils.sh flash-app`