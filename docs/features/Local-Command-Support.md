---
comments: true
---

# Local Command Support

## MultiNet

Willow supports "local command recognition" via the [MultiNet](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/getting_started/readme.html) model provided by [ESP-SR](https://github.com/espressif/esp-sr).

## Why It's Cool

Willow hardware can do completely local command detection with MultiNet. This has many advantages:

- No additional servers.
- FAST response time. Seriously, it's unbelievably fast!
- With up to 400 commands it's quite usable.
- Better "fuzzy" matching. Like any inference model, MultiNet returns probability based on speech input. This has the effect of having better "fuzzy matching" for detected speech. So things like "turn on upstairs lights" will likely match a grammar definition of "turn on upstair light" (for example).

## MultiNet Status

MultiNet support in Willow is beta (in a project that is beta).

## Using MultiNet

You can try MultiNet by enabling it in the Willow Configuration section during ```./utils.sh config```. You need to make sure you're using the PCM codec, which will enable an additional configuration option called "Use local command detection via MultiNet".

With some hacky stuff in ```utils.sh build``` and a disgusting Python script when enabled we will try to do the following:

- Connect to your configured Home Assistant instance and get your entities (currently only lights and switches).
- Build the ESP-SR MultiNet English grammar file with the structure "TURN ON $ENTITY_FRIENDLY_NAME" and "TURN OFF $ENTITY_FRIENDLY_NAME".
- As of this writing the MultiNet model only returns the command ID (1-400) associated with the grammar entry.
- We hack around this by also generating a header file with a map of command ID to friendly text to show on the display/send to the server (Home Assistant).
- The Python script is fairly conservative because we don't want to crash the device. If this auto configuration results in more than 200 entities (400 max, TURN ON + TURN OFF / 2 = 200) the script will exit and the build will fail.

This is very ugly for a variety of reasons and we're looking for help in this area!

### Caveats

- The models provided by Espressif only support English and Chinese. Willow currently only supports English.
- We have not tested this with a wide variety of Home Assistant configurations.
- It's very possible (almost certain) it won't work with one or more of your entity names. For example, the MultiNet model only supports numbers expressed as words (300 = THREE HUNDRED) and only supports commands with a maximum of 63 characters.
- Because of this issues our auto generation script will drop entities with numbers in their friendly names as we've observed in our testing many entities with friendly names end up running over the 63 character limit anyway.
- It currently only supports light and switch entities (no reason it can't support others, we're just being cautious).
- It has a very fixed command format (TURN ON/TURN OFF).
- It currently doesn't allow users to manually edit names, entities, and grammar.
- It does very little error checking and you can crash the ESP device fairly easily with unexpected language model definitions/grammar format.
- Entities and grammar are only defined at build time. The MultiNet model supports defining commands dynamically at runtime and we are investigating approaches to enable automatic definition of entity additions/deletions/changes.

In the future we hope to address these issues with a nice configuration interface for users to define commands and broader dynamic/runtime configuration support.