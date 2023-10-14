---
comments: false
---

# What Willow Is (And Isn’t)

Willow itself is not a complete and direct replacement for Amazon Echo/Google Home. Willow has a fairly limited focus:

- Support wake word to start capturing speech.
- Use VAD to know when you stop talking.
- Get the cleanest and highest quality audio possible.
- Do something useful with the audio (stream to a server for speech to text or use local command recognition).
- Send the output text to something to do actually do something.
- Depending on configuration either play success/failure tone or speak output with TTS from WIS.
- Show speech transcript and command status on display.

That's it!

## The Future (in no particular order)

### No CUDA

The [Willow Inference Server](components/willow-inference-server.md) will run CPU only but the performance on CPU is not comparable to heavily optimized implementations like [whisper.cpp](https://github.com/ggerganov/whisper.cpp). For an Alexa/Echo competitive voice interface we currently believe that our approach with CUDA or local Multinet (up to 400 commands) is the best approach. However, we also understand that isn't practical or preferred for many users. Between on device Multinet command recognition and further development on CPU-only Whisper implementations, ROCm, etc. we will get there. That said, if you can make the audio streaming API work you can use any speech to text and text to speech implementation you want!

### LCD and Touchscreen Improvements

The ESP BOX has a multi-point capacitive touchscreen and support for many GUI elements. We currently only provide basic features like touch screen to wake up, a little finger cursor thing, and a Cancel button to cancel/interrupt command streaming. There's a lot more work to do here!

### Buttons

The ESP BOX has buttons and who doesn't like configuring buttons to do things?!

### Custom Wake Word

Espressif has a [wake word customization service](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/wake_word_engine/ESP_Wake_Words_Customization.html) that enables us (and commercial users) to create custom wake words. We plan to create a "Hi Willow" or similar wake word and potentially others depending on input from the community.

### GPIO

The ESP BOX provides 16 GPIOs to the user that are readily accessed from sockets on the rear of the device. We plan to make these configurable by the user to enable all kinds of interesting maker/DIY functions.
