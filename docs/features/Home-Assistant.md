---
comments: true
---

# Home Assistant

## The Year of Voice!

Home Assistant has taken on the task of doing the heavy lifting with privacy focused, user controlled speech interfaces. Willow truly stands on the shoulders of this giant. Willow would not be useful without all of the hard work of the Home Assistant team over the years.

All of the developers in the Willow project have enjoyed the use of Home Assistant over the years and in my case, for nearly a decade. It's amazing!

## Why Willow? Where does it fit in?

The Home Assistant team has made incredible progress on speech this year! We're aware they're working on things like wake word, etc. We started work on Willow because we love Home Assistant and we've always thought the ESP32-S3-BOX hardware was cool and a perfect fit for use with it.

However, as limited in focus as Willow is it turns out this isn't an easy task. The ESP32-S3-BOX hardware is very, very capable but the development environment is somewhat challenging for someone like myself who at best can whip up a quick and dirty Python script. C! Microcontroller! Balancing IRAM vs PSRAM! All kinds of overlapping frameworks! Flashing, and flashing, and flashing during dev! It's been a journey but we are happy with the initial results.

The Home Assistant project has spoken of the concept of "voice satellites". From what I can gather the thinking is this:

- They target a bunch of platforms, including relatively light ones like the Raspberry Pi.
- These voice satellites can be placed throughout an environment to pretty much do what Willow does.
- They already have a cool demo of the M5stack (integrated with esphome!) with push to talk!

Problem is you're not going to replace Amazon Echo without wake word, VAD, LCD display, etc. As noted by the Home Assistant team these features are surprisingly difficult to implement (from what I remember their anticipated speech and wake engine is proprietary). From what I understand they're working on support of these with the Raspberry Pi.

However, we feel using a Raspberry Pi or similar device isn't well suited for this task:

- Due to supply chain issues they are difficult to come by.
- By the time you factor in the board, SD card, enclosure, power supply, LCD display, microphones, etc, etc the BOM (bill of materials) is significantly more expensive (likely 3x) than the ESP32-S3-BOX hardware.
- It's very "DIY" and for many people would result in a mess of wires or at best a 3D printed case.
- There are acoustic challenges to provide high quality far-field audio. All kinds of audio stuff involving the enclosure, etc that I don't understand.
- It's relatively heavy from a power consumption standpoint.

Knowing the awesomeness that is Home Assistant and the team I'm sure they're working on these issues and will have their own complete solution soon.

# The future

We would love to work with the Home Assistant team to enable tighter integration of Willow with Home Assistant as a "voice satellite". This could enable such things as:

- Use your Home Assistant server/HASSIO as the inference server for Willow.
- Configure Willow completely through Home Assistant.
- Use any of the Home Assistant TTS/STT components.
- Flash Willow to supported hardware directly via Home Assistant (like esphome).
- Much, much more!

# Other Platforms
We feel Willow has the potential to enable all kinds of interesting voice applications outside of use with Home Assistant (commercial or otherwise). We welcome work on Willow integrations/modules as it makes sense - other HA systems, generic inputs/outputs, other protocols, custom applications, etc.