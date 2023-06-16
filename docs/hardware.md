# Hardware

The ESP32-S3-BOX is the primary supported hardware platform for Willow. It's what we develop on, it's what we target and it's what we support.

## ESP32-S3-BOX

Out of the box the [ESP32-S3-BOX](https://github.com/espressif/esp-box/blob/master/docs/hardware_overview/esp32_s3_box/hardware_overview_for_box.md) is near perfect for Willow. However, in a perfect world there is one manufacturing change we would make.

The green power LED on the top right of the enclosure is not connected via GPIO. Per the [schematic](https://github.com/espressif/esp-box/blob/master/hardware/esp32_s3_box_v2.5/schematic/SCH_ESP32-S3-BOX_V2.5_20211011.pdf) it is connected directly to a 3.3v buck converter coming from 5 VIN. Additionally, it is so bright you can see it from outer space. For many usage scenarios we hint that more advanced (and brave) users disable this LED.

How? By opening the case and de-soldering or (basically) breaking it off the PCB. The author has successfully done this across several boards mostly without issue. I say "mostly" because the enclosure of the ESP32-S3-BOX is 3D printed by Espressif. The two rear screws have a tendency to de-thread the plastic when removed. However, with a lot of shuffling around and testing the author has not observed any issues even with completely de-threaded screws - the retention design of the enclosure combined with the base stand seems to provide more than enough to hold the device together. However, it certainly makes it much more likely to not survive a fall or other kinds of abuse.

It is our hope that in future revisions Espressif connects this LED via GPIO so we can control its function, brightness, etc. Additionally, we suspect that with more ESP32-S3-BOX sales volume Espressif will likely move to injection molded plastic for the enclosure.

We haven't had any contact with Espressif about these changes and don't have any inside or additional information about when or if these changes will ever take place.

We are also reluctant to provide step-by-step instructions for this process at this time as per-usual opening an enclosure for any electronic device can potentially break it. We also don't know if there are any warranty, etc. issues in taking this step. If you know how to open the enclosure, disable the LED, and get the case back together successfully go for it!

### Speaking of GPIOs

As noted in the README the ESP32-S3-BOX exposes 16 rear GPIOs that enable users to have the best of both worlds - an attractive and ready to go enclosure that would not look out of place in any installation but also exposes more advanced "maker-type" functionality.

We are currently considering the best way to go about user control of these GPIOs. Ideally we could use esphome or some other established/standard way to configure them but we haven't completely thought this through yet...

### Power Supplies

As noted in the [README](https://github.com/toverainc/willow/blob/main/README.md) the ESP32-S3-BOX is very low power. It calls for 5V 1A power supply and we have observed the ESP32-S3-BOX using a fraction of that. However, we haven't been able to find readily-available (CHEAP) lower amperage (1A) USB-C power supplies for the ESP32-S3-BOX. If you know where to get one let us know!

## ESP32-S3-BOX-Lite

!!! danger "If you already have one you can try Willow out on it but we ***DO NOT*** recommend purchasing an ESP32-S3-BOX-Lite for Willow."

!!! note "It seems like people think Willow is as cool as we do!" 
    From what we can gather ESP32-S3-BOX hardware is practically sold out now. We are working to support the [ESP32-S3-BOX-Lite](https://github.com/espressif/esp-box/blob/master/docs/hardware_overview/esp32_s3_box_lite/hardware_overview_for_lite.md) with full functionality but the real goal is for Espressif to ramp up manufacturing of ESP32-S3-BOX - which shouldn't be hard for them as I think the only gaiting component is the plastic enclosure.

We don't primarily target the ESP32-S3-BOX-Lite for several reasons:

- The cost difference between the ESP32-S3-BOX and Lite is negligible
- No touchscreen
- No base stand
- Even Espressif seems to be dropping support for it in various frameworks and projects

As of this writing (May 15 2023) the current image boots and works on the ESP32-S3-BOX-Lite. You can build Willow for the ESP32-S3-BOX-Lite by selecting ***ESP32-S3-BOX-Lite*** under the ***Audio HAL*** section in the configuration main menu.

In the event there are supply issues with the ESP32-S3-BOX or the community shows interest we could fairly easily introduce official support for it BUT AGAIN we have no plans for this at this time and thus do not recommend purchasing it.

## Other ESP32-S3 Based Boards

The ESP32 S3 is what really "makes the magic happen" for Willow as the high speed PSRAM enables a lot of the more advanced "neural" features. It is certainly possible that Willow can run on other ESP32-S3 based boards but supporting these is currently solely the responsibility of the user.

In the future we may officially support other ESP32-S3 (or successor series) based boards but they are not supported at this time.

## Other Espressif Boards

Per the ESP ADF and ESP-SR documentation regular plain 'ol ESP32 boards can run some speech features. However, they are so limited the experience isn't what we would call acceptable to meet our goals of removing creepy corporate microphones from your environment without any compromises.

We have not investigated support for any other ESP32 based platforms such as the C series.