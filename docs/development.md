---
comments: false
---

# Development

Configuring and building Willow for the ESP BOX hardware family is a multi-step process that is required if you want to do Willow development. We've provided a helper script to make things easier.

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
git clone https://github.com/HeyWillow/willow.git && cd willow
```

### Build Willow Development Docker Container

We use [Docker](https://www.docker.com/) (also supports [Podman](https://podman.io/)) for the build container. To build the container with Docker:

```sh
./utils.sh build-docker
```

### Start Willow Development Docker Container

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

!!! note "ESP BOX-3 NOTE!!!"
    You will need to build specifically for the ESP BOX-3. From the main menu, select:

    ***Audio HAL ---> Audio Board ---> ESP32-S3-BOX-3***

!!! note "ESP BOX LITE NOTE!!!"
    You will need to build specifically for the ESP BOX LITE. From the main menu, select:

    ***Audio HAL ---> Audio Board ---> ESP32-S3-BOX-Lite***

Return to main menu and continue.

### Willow Configuration

Navigate to ***Willow Configuration*** to enter your Wi-Fi SSID and password (supports 2.4 GHz Wi-Fi with WPA/WPA2/WPA3 authentication), and your Willow Application Server URL.

Once you've provided these press ++q++ and save when prompted.

### Build and Exit Container

```sh
./utils.sh build
```

When the build completes successfully you can exit the container.

## Flash Willow to Your Device

It's getting real now - plug the ESP BOX in!

### Set Serial Port

Back on the host docker:

To do anything involving the serial port you will need to set the `PORT` environment variable for all further invocations of `utils.sh`.

With recent versions of `tio` you can use `tio -L` to list available ports. On Linux you can check `dmesg` and look for the path of the recently connected ESP BOX (furthest at the bottom, hopefully). On Linux it's usually `/dev/ACM*` and on Mac it's `/dev/cu.usbmodem*`.

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

For out of the box/factory new ESP BOX hardware you will need to (one time) erase the factory flash before flashing Willow:

```sh
./utils.sh erase-flash
```

Once you have done that you can flash

```sh
./utils.sh flash
```

It should flash and connect you to the serial monitor.

!!! note "If you're encountering flashing issues due to USB passthrough use `willow-dist.bin` and flash it from a another computer"

#### Flash from Another Device

If you want to quickly and easily flash multiple devices or distribute a combined firmware image you can use the `dist` arguments to `utils.sh`:

`./utils.sh dist` - builds the combined flash image (`willow-dist.bin`)

`./utils.sh flash-dist` - flashes the combined flash image 

This combined firmware image can be used with any ESP flashing tool.

#### Advanced Options

`utils.sh` will attempt to load environment variables from `.env`. You can define your `PORT` here to avoid needing to define it over and over.

The ESP-IDF, ESP-ADF, ESP-SR, LVGL, etc. libraries have a plethora of configuration options. DO NOT change anything outside of _Willow Configuration_ (other than wake word) unless you know what you are doing.

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

In some hardware combinations the ESP BOX can be stubborn and won't successfully flash.

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

