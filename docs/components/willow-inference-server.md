---
comments: false
---

# Willow Inference Server (WIS)

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/PxCO5eONqSQ" title="Willow Inference Server WebRTC Demo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

[Willow Inference Server](https://github.com/toverainc/willow-inference-server)  (WIS) is a focused and highly optimized language inference server implementation. Our goal is to "automagically" enable performant, cost-effective self-hosting of released state of the art/best of breed models to enable speech and language tasks:

- Primarily targeting CUDA with support for low-end (cheap) devices such as the Tesla P4, GTX 1060, and up. Don't worry - it screams on an RTX 4090 too! [(See benchmarks)](#benchmarks). Can also run CPU-only.
- Memory optimized - all three default Whisper (base, medium, large-v2) models loaded simultaneously with TTS support inside of 6GB VRAM. ASR/STT + TTS + 13B LLM require roughly 18GB VRAM. Less for 7B, of course!
- ASR. Heavy emphasis - Whisper optimized for very high quality as-close-to-real-time-as-possible speech recognition via a variety of means (Willow, WebRTC, POST a file, integration with devices and client applications, etc). Results in hundreds of milliseconds or less for most intended speech tasks.
- TTS. Primarily provided for assistant tasks (like Willow!) and visually impaired users.
- LLM. Optionally pass input through a provided/configured LLM for question answering, chatbot, and assistant tasks. Built in support for quantization to int4 to conserve GPU memory.
- Support for a variety of transports. REST, WebRTC, Web Sockets (primarily for LLM).
- Performance and memory optimized. Leverages [CTranslate2](https://github.com/OpenNMT/CTranslate2) for Whisper support.
- [Willow](https://github.com/HeyWillow/willow) support. WIS powers the Tovera hosted best-effort example server Willow users enjoy.
- Support for WebRTC - stream audio in real-time from browsers or WebRTC applications to optimize quality and response time. Heavily optimized for long-running sessions using WebRTC audio track management. Leave your session open for days at a time and have self-hosted ASR transcription within hundreds of milliseconds while conserving network bandwidth and CPU!
- Support for custom TTS voices. With relatively small audio recordings WIS can create and manage custom TTS voices. See API documentation for more information.

With the goal of enabling democratization of this functionality WIS will detect available CUDA VRAM, compute platform support, etc and optimize and/or disable functionality automatically (currently in order - ASR, TTS, LLM). For all supported Whisper models (large-v2, medium, small, base, and tiny) loaded simultaneously current minimum supported hardware is GTX 1060 3GB (6GB for TTS). User applications across all supported transports are able to programmatically select and configure Whisper models and parameters (model size, beam, language detection/translation, etc) and TTS voices on a per-request basis depending on the needs of the application to balance speed/quality.

Note that we are primarily targeting CUDA - the performance, cost, and power usage of cheap GPUs like the Tesla P4 and GTX 1060 is too good to ignore. We'll make our best effort to support CPU wherever possible for current and future functionality but our emphasis is on performant latency-sensitive tasks even with low-end GPUs like the GTX 1070/Tesla P4 (as of this writing roughly $100 USD on the used market - and plenty of stock!).

## Getting Started

### Dependencies (run once for initial install)
For CUDA support you will need to have the NVIDIA drivers for your supported hardware. We recommend Nvidia driver version 530.

```bash
# Clone the WIS Repo:
git clone https://github.com/toverainc/willow-inference-server.git && cd willow-inference-server

# Ensure you have nvidia-container-toolkit and not nvidia-docker
# On Arch Linux:
yay -S libnvidia-container-tools libnvidia-container nvidia-container-toolkit docker-buildx

# Ubuntu:
./deps/ubuntu.sh
```
### Install, configure, and start WIS
```
# Install
./utils.sh install

# Generate self-signed TLS cert (or place a "real" one at nginx/key.pem and nginx/cert.pem)
./utils.sh gen-cert [your hostname]

# Start WIS
./utils.sh run
```

## Links and Resources

Willow: Configure Willow to use ```https://[your host]:19000/api/willow``` then build and flash.

WebRTC demo client: ```https://[your host]:19000/rtc```

API documentation for REST interface: ```https://[your host]:19000/api/docs```

## Configuration

System runtime can be configured by placing a ```.env``` file in the WIS root to override any variables set by ```utils.sh```. You can also change more WIS specific parameters by copying ```settings.py``` to ```custom_settings.py```.

## Windows Support

WIS has been successfully tested on Windows with WSL (Windows Subsystem for Linux). With ASR and STT only requiring a total of 4GB VRAM WIS can be run concurrently with standard Windows desktop tasks on GPUs with 8GB VRAM.

## Benchmarks

| Device   | Model    | Beam Size | Speech Duration (ms) | Inference Time (ms) | Realtime Multiple |
|----------|----------|-----------|----------------------|---------------------|-------------------|
| RTX 4090 | large-v2 | 5         | 3840                 | 140                 | 27x               |
| RTX 3090 | large-v2 | 5         | 3840                 | 219                 | 17x               |
| H100     | large-v2 | 5         | 3840                 | 294                 | 12x               |
| H100     | large-v2 | 5         | 10688                | 519                 | 20x               |
| H100     | large-v2 | 5         | 29248                | 1223                | 23x               |
| GTX 1060 | large-v2 | 5         | 3840                 | 1114                | 3x                |
| Tesla P4 | large-v2 | 5         | 3840                 | 1099                | 3x                |
| GTX 1070 | large-v2 | 5         | 3840                 | 742                 | 5x                |
| RTX 4090 | medium   | 1         | 3840                 | 84                  | 45x               |
| RTX 3090 | medium   | 1         | 3840                 | 140                 | 27x               |
| GTX 1070 | medium   | 1         | 3840                 | 424                 | 9x                |
| GTX 1070 | medium   | 1         | 10688                | 564                 | 18x               |
| GTX 1070 | medium   | 1         | 29248                | 1118                | 26x               |
| GTX 1060 | medium   | 1         | 3840                 | 588                 | 6x                |
| Tesla P4 | medium   | 1         | 3840                 | 586                 | 6x                |
| RTX 4090 | medium   | 1         | 29248                | 377                 | 77x               |
| RTX 3090 | medium   | 1         | 29248                | 520                 | 56x               |
| GTX 1060 | medium   | 1         | 29248                | 1612                | 18x               |
| Tesla P4 | medium   | 1         | 29248                | 1730                | 16x               |
| GTX 1070 | base     | 1         | 3840                 | 70                  | 54x               |
| GTX 1070 | base     | 1         | 10688                | 92                  | 115x              |
| GTX 1070 | base     | 1         | 29248                | 195                 | 149x              |
| RTX 4090 | base     | 1         | 180000               | 277                 | 648x (not a typo) |
| RTX 3090 | base     | 1         | 180000               | 435                 | 414x (not a typo) |
| RTX 3090 | tiny     | 1         | 180000               | 366                 | 491x (not a typo) |
| GTX 1070 | tiny     | 1         | 3840                 | 46                  | 82x               |
| GTX 1070 | tiny     | 1         | 10688                | 64                  | 168x              |
| GTX 1070 | tiny     | 1         | 29248                | 135                 | 216x              |
| Threadripper PRO 5955WX | tiny     | 1         | 3840                | 140                 | 27x              |
| Threadripper PRO 5955WX | base     | 1         | 3840                | 245                 | 15x              |
| Threadripper PRO 5955WX | small     | 1         | 3840                | 641                 | 5x              |
| Threadripper PRO 5955WX | medium     | 1         | 3840                | 1614                 | 2x              |
| Threadripper PRO 5955WX | large     | 1         | 3840                | 3344                 | 1x              |

As you can see the realtime multiple increases dramatically with longer speech segments. Note that these numbers will also vary slightly depending on broader system configuration - CPU, RAM, etc.

When using WebRTC or Willow end-to-end latency in the browser/Willow and supported applications is the numbers above plus network latency for response - with the advantage being you can skip the "upload" portion as audio is streamed in realtime!

We are very interested in working with the community to optimize WIS for CPU. We haven't focused on it because we consider medium beam 1 to be the minimum configuration for intended tasks and CPUs cannot currently meet our latency targets.

## Comparison Benchmarks

Raspberry Pi Benchmarks run on Raspberry Pi 4 4GB Debian 11.7 aarch64 with [faster-whisper](https://github.com/guillaumekln/faster-whisper) version 0.5.1. Canakit 3 AMP USB-C power adapter and fan. All models int8 with ```OMP_NUM_THREADS=4``` and language set as en. Same methodology as timing above with model load time excluded (WIS keeps models loaded). All inference time numbers rounded down. Max temperatures as reported by ```vcgencmd measure_temp``` were 57.9 C.

| Device   | Model    | Beam Size | Speech Duration (ms) | Inference Time (ms) | Realtime Multiple |
|----------|----------|-----------|----------------------|---------------------|-------------------|
| Pi       | tiny     | 1         | 3840                 | 3333                | 1.15x             |
| Pi       | base     | 1         | 3840                 | 6207                | 0.62x             |
| Pi       | medium   | 1         | 3840                 | 50807               | 0.08x             |
| Pi       | large-v2 | 1         | 3840                 | 91036               | 0.04x             |

## CUDA

We understand the focus and emphasis on CUDA may be troubling or limiting for some users. We will provide additional CPU vs GPU benchmarks but spoiler alert: a $100 used GPU from eBay will beat the fastest CPUs on the market while consuming less power at SIGNIFICANTLY lower cost. GPUs are very fundamentally different architecturally and while there is admirable work being done with CPU optimized projects such as [whisper.cpp](https://github.com/ggerganov/whisper.cpp) and CTranslate2 we believe that GPUs will maintain drastic speed, cost, and power advantages for the forseeable future. That said, we are interested in getting feedback (and PRs!) from WIS users to make full use of CTranslate2 to optimize for CPU.

### GPU Sweet Spot - October 2023

Perusing eBay and other used marketplaces the GTX 1070 seems to be the best performance/price ratio for ASR/STT and TTS while leaving VRAM room for the future. The author ordered an EVGA GTX 1070 FTW ACX3.0 for $120 USD with shipping and tax.

To support LLMs an RTX 3090/4090 is suggested. RTX 3090 being sold for approximately $800 as of this writing (10/14/2023).

## LLM

WIS supports LLM on compatible CUDA devices with sufficient memory (varies depending on model selected).

From WIS root:

```cp settings.py custom_settings.py```

Edit ```custom_settings.py``` and set ```chatbot_model_path``` to an AutoGPTQForCausalLM compatible model path from Hugging Face (example provided). The model will be automatically downloaded, cached, and loaded from Hugging Face. Depending on the GPTQ format and configuration for your chosen model you may need to also change ```chatbot_model_basename```. The various other parameters (temperature, top_p, etc) can also be set in ```custom_settings.py``` (defaults provided).

Make sure to set ```support_chatbot``` to ```True```.

Then start/restart WIS.

Once loaded you can view the chatbot API documentation at ```https://[your host]:19000/api/docs```.

## WebRTC Tricks

The author has a long background with VoIP, WebRTC, etc. We deploy some fairly unique "tricks" to support long-running WebRTC sessions while conserving bandwidth and CPU. In between start/stop of audio record we pause (and then resume) the WebRTC audio track to bring bandwidth down to 5 kbps at 5 packets per second at idle while keeping response times low. This is done to keep ICE active and any NAT/firewall pinholes open while minimizing bandwidth and CPU usage. Did I mention it's optimized?

Start/stop of sessions and return of results uses WebRTC data channels.

## WebRTC Client Library

See the [Willow TypeScript Client repo](https://github.com/toverainc/willow-ts-client) to integrate WIS WebRTC support into your own frontend.

## Fun Ideas

- Integrate WebRTC with Home Assistant dashboard to support streaming audio directly from the HA dashboard on desktop or mobile.
- Desktop/mobile transcription apps (look out for a future announcement on this!).
- Desktop/mobile assistant apps - Willow everywhere!

## The Future (in no particular order)

### Better TTS

We're looking for feedback from the community on preferred implementations, voices, etc. See the [open issue](https://github.com/toverainc/willow-inference-server/issues/60).

### TTS Caching

Why do it again when you're saying the same thing? Support on-disk caching of TTS output for lightning fast TTS response times.

### Support for More Languages

Meta released MMS on 5/22/2023, supporting over 1,000 languages across speech to text and text to speech!

### Code Refactoring and Modularization

WIS is very early and we will refactor, modularize, and improve documentation well before the 1.0 release.

### Chaining of Functions (Apps)

We may support user-defined modules to chain together any number of supported tasks within one request, enabling such things as:

Speech in -> LLM -> Speech out

Speech in -> Arbitrary API -> Speech out

...and more, directly in WIS!
