# Willow Inference Server

For many months Tovera has been working on an speech and language inference server. At a high level it supports things like:

- Really, really fast Whisper via [CTranslate2](https://opennmt.net/CTranslate2/) (like faster-whisper) and CUDA with a few of our own tweaks to make it even faster while still maintaining the accuracy Whisper is famous for
- Streaming from Willow (needs to do weird things like support AMR-WB)
- Support for LLMs like LLaMA/Vicuna/etc. (with 4 bit quantization, etc)
- Text to speech
- WebRTC support
- Much more!

As of this writing (May 15, 2023) a Tovera hosted Willow Inference Server is provided for use on a best-effort basis for Willow users. However, what's the difference between sending your audio to us vs Amazon? That's not cool.

Well, we make our hosted Willow Inference Server available for a few reasons:

- The inference server basically needs CUDA. It's really intended for hardcore users and commercial applications. It's kind of a beast.
- We make it available so Willow users can do something out of the box without dealing with it.
- It's pretty fast (but not our fastest) so we can have "faster than Alexa" performance for you today.

## Our Promise to You

We do not log sessions. We do not save audio. I guess you'll just have to trust us for now but we have open sourced and released [Willow Inference Server](https://github.com/toverainc/willow-inference-server) so you can host it yourself. 

## What’s Cool Is Hosting It Yourself or Using Something Else!

We also welcome the use of any other speech to text and text to speech implementations such as those already provided/exposed by Home Assistant. More on that soon!