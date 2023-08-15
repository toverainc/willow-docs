---
comments: true
---

# What Willow Is (And Isn’t)

Willow itself is not a complete and direct replacement for Amazon Echo/Google Home. Willow has a fairly limited focus:

- Support wake word to start recording.
- Use VAD to know when you stop talking.
- Get the cleanest, highest quality audio possible.
- Do something useful with the audio (stream to a server for speech to text or use local command recognition).
- Send the output text to something to do actually do something.
- Display the command results (and in the future) play back any audio that comes back from the command server (such as text to speech output).
- Provide an interface for feedback via the LCD display and speaker output.

That's it!

See the [Home Assistant](features/Home-Assistant.md) section for more details on what really does the heavy lifting here.

## The Future (in no particular order)

### Multiple Languages

Willow supports UTF characters and our Willow Inference Server supports all the languages of Whisper. We have some polishing to do here but it is coming very soon. For the interface language on device we're looking for translation help!

### Performance Improvements

Willow and Willow Inference Server/Multinet already provide "faster-than-Alexa" responsiveness for a voice user interface. However, there are multiple obvious optimizations we're aware of:

- ESP ADF pipeline handing (we're waiting on ESP-ADF 2.6 with ESP-IDF 5)
- Websockets for inference server (avoids TLS handshake and connection establishment for each session)
- Code in general (we're new to ESP IDF and it could use review)
- Various performance-related sdkconfig parameters (again, we're new to ESP IDF)
- Likely many, many more

These enhancements alone should dramatically improve responsiveness.

### No CUDA

The [Willow Inference Server](willow-inference-server.md) will run CPU only but the performance on CPU is not comparable to heavily optimized implementations like [whisper.cpp](https://github.com/ggerganov/whisper.cpp). For an Alexa/Echo competitive voice interface we currently believe that our approach with CUDA or local Multinet (up to 400 commands) is the best approach. However, we also understand that isn't practical or preferred for many users. Between on device Multinet command recognition and further development on CPU-only Whisper implementations, ROCm, etc. we will get there. That said, if you can make the audio streaming API work you can use any speech to text and text to speech implementation you want!

### TTS Output

Given the capabilities of Whisper speech commands like "What is the weather in Sofia, Bulgaria?" are transcribed but need to match a command (like a Home Assistant intent or openHAB Action Template Interpreter) on the destination. Our inference server implementation has a text to speech engine we will be utilizing. In the event the final response to a given command results in audio output we can play that via the speakers in the ESP BOX (not yet supported).

### Higher Quality Audio Output

The ESP BOX supports Bluetooth. In applications where higher quality audio is desired (music streaming, etc.) we can support pairing to Bluetooth speaker devices. Who knows? Eventually we may even design our own device with better internal speakers...

### LCD and Touchscreen Improvements

The ESP BOX has a multi-point capacitive touchscreen and support for many GUI elements. We currently only provide basic features like touch screen to wake up, a little finger cursor thing, and a Cancel button to cancel/interrupt command streaming. There's a lot more work to do here!

### Buttons

The ESP BOX has buttons and who doesn't like configuring buttons to do things?!

### Audio on device

We have built in success and error tones but we would like to include audio for basic error and status conditions on the device. This will depend on our default text to speech engine selection so we can ensure we provide a consistent voice user interface and experience.

### Easy Start

Docker, building, configuring, flashing, etc. is a pain. There are several approaches we plan to take to avoid this and ease the barrier to entry for users to get started.

### Dynamic Configuration

With something like a Willow Home Assistant or openHAB component and websocket support we can enable all kinds of interesting dynamic configuration updates and tighter overall configurations.

### Over the Air Firmware Updates

ESP IDF and ESP BOX has robust support for over the air firmware (OTA) updates. Down the road we will support them.

### Multiple Devices

The good news is the far-field wake word recognition and speech recognition performance is very good. The bad news is if you have multiple devices in proximity they are all likely to wake and process speech simultaneously. Commands will still work but multiple confirmation/error beeps and hammering your destination command endpoint is less than ideal. We have a few ideas about dealing with this too.

### Custom Wake Word

Espressif has a [wake word customization service](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/wake_word_engine/ESP_Wake_Words_Customization.html) that enables us (and commercial users) to create custom wake words. We plan to create a "Hi Willow" or similar wake word and potentially others depending on input from the community.

### GPIO

The ESP BOX provides 16 GPIOs to the user that are readily accessed from sockets on the rear of the device. We plan to make these configurable by the user to enable all kinds of interesting maker/DIY functions.
