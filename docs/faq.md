---
comments: false
title: Frequently Asked Questions
---

# Frequently Asked Questions (FAQ)

## Overview

We've received a lot of interest from users and many of these users have asked some great questions!

### What about custom wake words?

The Willow project is able to make custom wake words and potentially open this process to end-users in the future. However, our focus is on usability and practicality with real-world voice interface and assistant use cases. We have a lot to do to achieve our goal of matching and eventually beating commercial solutions and wake words don't contribute to this goal. We understand why users are interested in them but our emphasis is on how well your voice assistant actually works in the real world - not what you call it.

### How do you make money?

From inception Willow has been designed, built, and tested for use in commercial applications (healthcare, retail, hospitality, etc). That said it's also very clearly useful for home automation tasks and other consumer applications. We support Home Assistant, for example, because all of the Willow developers use and love Home Assistant! Of course we want to use Willow in our homes with Home Assistant just like many of you do.

We have no plans whatsoever to ever monetize our consumer (Home Assistant, etc) user base. While there are a lot of different open source monetization strategies we feel that when it comes to direct monetization of end-users of open source it can be difficult to fairly balance free and open source with paid components/functionality. We think a clear line between functionality with open source Willow and some of the more advanced functionality of a commercial version (RBAC, advanced integrations, management, monitoring, etc) is much fairer to open source users and easier to balance.

**Our commitment: Open Source Willow users can enjoy Willow forever without worrying we're going to segment meaningful functionality or come back and try to shake them down later.**

In short, think Fedora and Red Hat Enterprise Linux.

### Why the ESP-BOX?

Commercial voice assistant devices that can wake and capture high quality audio under real world conditions have a tremendous amount of engineering for this specific challenge. Getting quality audio for accurate wake word detection and speech to text transcripts for commands from ~5m away is not nearly as simple as slapping a microphone on something. The entire device needs to be specifically designed and built for far-field audio. If you'd like to learn more about the complexities involved there are [references](https://www.merlynmind.ai/blog/cutting-through-the-noise-how-we-built-a-high-performance-microphone-for-the-classroom) available that go into more detail.

The ESP-BOX series has been designed and built specifically for far-field voice assistant applications. There is nothing else on the market at a remotely competitive price point that has the functionality necessary to provide anything approaching Echo, Google Home, etc quality.

If the audio coming in at the very start is low quality (with noise, echo, etc) the wake word detection and speech recognition quality is going to be fundamentally worse. If you can't get relatively clean audio in the first place you don't stand a chance to compete with devices that do.

### Why GPU?

For general purpose speech recognition the model needs to understand the full complexities of speech, grammar, and language - which comes in nearly infinite variety. This is a massively parallel compute task. GPUs have thousands of cores and at least hundreds of GB/s of memory bandwidth between them to compute speech. For comparison, the latest DDR5 memory standard for CPUs is roughly 50 GB/s. The seven year old $100 GTX 1070 is 250 GB/s and has 1,920 cores. As you can see from our [benchmarks](components/willow-inference-server.md#benchmarks) any supported GPU beats the pants off an AMD ThreadRipper at a fraction of the cost (and power).

### Does Willow support the Coral TPU?

Willow via the Willow Inference Server (WIS) does not support Coral TPU devices. While they work very well for tasks like object detection that use small models they do not have nearly enough memory to load general purpose speech recognition models required for most voice assistant tasks. Telling the difference between a person and a cat is a completely different task from understanding the full complexities of grammar and speech.

### What about non-CUDA GPUs?

The Willow Inference Server is highly optimized for Nvidia CUDA GPUs. Support for other GPUs like those from AMD and Intel is theoretically possible but these devices are very early in terms of their support for "GPGPU" (General Purpose GPU) as is used in ML/AI applications like speech recognition and synthesis. We continue to watch their progress very closely and may potentially support them in the future once the overall software ecosystems (drivers, frameworks, acceleration, etc) mature. Nvidia and the entire ML ecosystem have been working on and using CUDA for 15 years. It will take some time for other GPU hardware and their supporting software to catch up.

The Willow Inference Server supports CPU-only but the fundamental performance and quality advantages provided by GPUs with speech recognition and synthesis make the difference between a voice assistant that's usable and one that isn't. Cloud-powered commercial solutions don't use CPU either because they are fundamentally the wrong tool for the job. If you want a commercial-competitive completely locally hosted voice assistant GPU is currently (and for the forseeable future) the only viable approach.

### What about integrated GPUs?

People buy discrete GPUs for gaming because they want higher frames per second and higher resolutions. It's well understood by nearly everyone that if you want high frame rates and high resolutions with modern games you need a discrete GPU. The speech tasks performed by the Willow Inference Server are computationally similar to those used by games, and this is why discrete GPUs have become so popular in the machine learning and artificial intelligence space.

For a dramatic comparison, look at some [desktop video card benchmarks](https://www.videocardbenchmark.net/compare/4652vs2531vs3521/Radeon-Ryzen-9-7950X-16-Core-vs-GeForce-GTX-770-vs-GeForce-GTX-1070). In this example, the best integrated GPU as of 2023 (on a CPU that retails for over $500) is bested by a middle-range Nvidia GPU from 10 years ago. Also included in the comparison is one of the GPUs we recommend for Willow users - the GTX 1070. This benchmark shows this $100 used card is more than 2x the performance of the latest and greatest in terms of integrated GPUs.

To make matters worse for integrated GPUs, the current status of software support for AMD and Intel GPUs (especially integrated) with machine learning/AI tasks is significantly behind discrete GPUs, especially those from Nvidia. The vast majority of software development for integrated GPUs is work with drivers and games, not things like the speech tasks performed by the Willow Inference Server.

### GPUs are ridiculous, I'm just going to use my CPU.

That's fine, the Willow Inference Server is as optimized as possible for CPU too! When it comes down to it your options are:

1) Very slow and still inaccurate transcription on CPU. You will be waiting many seconds for WIS (or anything else) to do high quality speech recognition - even with models we don't consider to be accurate enough for voice assistant tasks. These models will have frequent transcription errors and you will often get caught in a cycle of "issue command, wait many seconds, get the wrong transcription, repeat yourself, wait many seconds again, and maybe eventually it will get it right". After you have to repeat yourself even once it's faster, easier, and far less frustrating to take your phone out of your pocket and do what you need to do there.

2) Use a GPU and get cloud-level accuracy and even faster performance because it's hosted locally.

3) Use a cloud, which is likely running on a GPU your cloud provider hosts.

The bottom line is if you want an experience similar to the voice assistants from big tech you need to use a GPU somewhere - just like they do.

### What about the NPU on my ARM board?

Some ARM boards (like the Rockchip RK3588) include a NPU (Neural Processing Unit). However, much like the AMD and Intel GPU ecosystems fundamental software support for these devices is significantly lacking, and like the Coral memory and model size is often a limiting factor. A lot of work needs to be done in the underlying software (outside of WIS) to potentially support these NPUs and in the end if the memory isn't available they are a non-starter.

### Does Willow have a software client for my Raspberry Pi, etc?

No. The use of a Raspberry Pi with a microphone is a seemingly attractive and obvious approach. However, it comes with a lot of fundamental issues that dramatically limit the usability of this approach when compared to the hardware devices Willow supports. If you'd like to learn more about some of these issues and our stance we elaborate on them [here](https://github.com/toverainc/willow/issues/317#issuecomment-1774172563).

### Does Willow support the Wyoming protocol for use with Home Assistant and ESPHome?

No. Willow and the native Home Assistant Voice implementation have drastically different approaches to voice interfaces and assistant support. If you'd like to further understand the differences in our approach you can read the [detailed and very long explanation](https://github.com/toverainc/willow-inference-server/discussions/135) from Kristian Kielhofner (the creator of Willow).

Without substantial changes to the Wyoming protocol and implementations we feel it's not ready for a commercially competitive voice assistant user experience.