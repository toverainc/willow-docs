---
comments: true
---

# How Does It Work

## Software Architecture

The various components and frameworks essentially come together like this:

The root of the project is the [Espressif Audio Development Framework](https://github.com/espressif/esp-adf) (ESP-ADF). We use the ESP-ADF because it enables fairly straightforward management of "audio pipelines" that we use for I2S access to the audio hardware, connection to the recorder, streaming to the inference server, and optional support of AMR-WB for audio compression. In the future for audio playback support, etc. we will have additional audio playback pipelines to stream response audio, music, etc.
The ESP-ADF then uses the ESP-IDF as a component. This is somewhat counter-intuitive as the ESP-ADF depends on the ESP IDF and one would think this would be the other way around.

We then (manually) pull in a more recent version of the ESP-SR Speech Recognition Framework. ESP-SR is what enables the [AFE (Audio Front End)](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/audio_front_end/README.html) that performs things such as AGC (Automatic Gain Control), etc. Additionally, it provides [wake word detection](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/wake_word_engine/README.html), local command recognition via [MultiNet](https://docs.espressif.com/projects/esp-sr/en/latest/esp32s3/speech_command_recognition/README.html), etc.

We also use various "managed components" to support things like the LCD, etc.
<!-- TODO: Make a pretty diagram/flow thing or something. -->

### What’s With the Goofy on the Wire Format?

Many developers are familiar with things like WebRTC. Again, due to my years in VoIP I certainly am. At first glance Willow may seem like a good application for WebRTC. 

Here's why it isn't:

WebRTC is very heavy. It mandates support for things such as ICE, DTLS, etc.

ICE often leads to long session establishment times because ICE candidates need to be collected and evaluated. Yes there is "Trickle ICE" but that's another rant for another day.

DTLS is fairly heavy too.

WebRTC is very cool and offers many advantages. However, most of those advantages relate to WebRTC's ability to establish bidirectional media stream flow between two previously unknown peer devices that can both be behind NAT. We don't have that issue as the streaming server is expected to either be local or at an establish address that isn't behind NAT.

However, because we do use HTTP (currently) you can still have both devices behind NAT as long as you properly forward HTTP/HTTPS through your NAT device.
None of this really applies if you are locally self-hosting your inference server.
So, in short, we feel that WebRTC isn't appropriate or necessary for Willow.

## Server Mode Flow

``` mermaid
graph TB
  A[wake word] --> B[start recording] --> C[stream in real time to inference server] --> D[VAD detects end of speech] --> E[end end chunk] --> F[server performs speech to text] --> G[JSON response with text and language] --> H[POST to configured server currently Home Assistant] --> I[display speech to text results and Home Assistant command success/failure]
```

## Local Mode Flow

``` mermaid
graph TB
 A[wake word] --> B[MultiNet] --> C[MultiNet returns detected command ID] --> D[look up corresponding text for command] --> E[POST to configured server currently Home Assistant] --> F[display speech to text results and Home Assistant command success/failure]
```

## Current Status

As of this writing (May 13 2023) Willow is based on the ADF 2.5 release. This release is fairly old and is based on IDF 4.4. There are many things to look forward to in the upcoming ADF 2.6 release which is based on ESP IDF 5.x. Support for ESP-IDF 5.x has been merged in the main ADF branch and we have a Willow branch where we have started initial work to support ADF 2.6.

We have a few outstanding issues that we feel are better off waiting for the release of ADF 2.6 before we begin work on them. We are following the progress of official ADF support for IDF 5.x and will merge our idf5 branch when we feel it is ready.