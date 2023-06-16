# Wi-Fi

Wi-Fi is (essentially) magic to me. I don't pretend to know everything about it but here's the overview as I understand it:

- The ESP 32 S3 only supports 2.4 GHz. In many environments the 2.4 GHz Wi-Fi spectrum can be nearly useless as there are plenty of other things sharing this spectrum (from Bluetooth to baby monitors). Additionally, because it has higher penetration through solid objects than 5/6 (Wi-Fi 6E) GHz there's a tendency for higher interference from neighboring Wi-Fi networks, etc.
- Many people have ridiculous Wi-Fi settings on their routers. If you do a Wi-Fi scan you will probably see neighbors with their devices set to do things like use 40 MHz channel bandwidth, etc.
- In the United States at least, there are only three non-overlapping 2.4 GHz Wi-Fi channels (1,6,11). This limits the ability for multiple devices and networks to transmit simultaneously.

Because of all of this, getting "air time" to transmit on the 2.4 GHz spectrum for higher bandwidth applications like Willow can be challenging. We do our best to support things like frame aggregation, etc but the positive impact of these hacks is hit-or-miss.

All of this said, it actually (somehow - magic!) works fairly well. However, in cases where the default setting of streaming raw PCM frames to the inference server has issues due to Wi-Fi bandwidth we (optionally) support audio compression using a codec called AMR-WB.

## What's the deal with AMR-WB?

AMR-WB (aka G.722.2) is an old codec that I know from my many (painful) years spent in VoIP. If you've ever used a mobile device AMR-WB is the standard codec cell phone networks use for "wideband" audio support so you most likely use it almost everyday without knowing. Wideband audio is generally classified as any audio that has a sampling rate greater than 8 kHz. There's also AMR-WB+ that many cell and cell network devices support but it's not supported by ADF and irrelevant here.

Because of the [Nyquist-Shannon sampling theorem](https://en.wikipedia.org/wiki/Nyquist%E2%80%93Shannon_sampling_theorem) this is somewhat misleading - long story short the effective audio bandwidth is half of the sample rate, so 8 kHz results in more-or-less 4 kHz audio frequency response. This is not enough to accurately reproduce the full range of human speech and isn't acceptable for our use. Unfortunately, AMR-WB is the only wideband audio codec the ESP ADF framework supports encoding with. In a perfect world we could use something more modern like OPUS that would offer many advantages, including support for even higher sample rates. My hunch is the ESP32 S3 probably has the CPU cycles to use OPUS and we think this would offer many advantages.

However, there "is no free lunch" as they say. We use the highest bitrate supported by AMR-WB that is allegedly fairly robust in terms of background noise and accurate representation of human speech at 16 kHz. However, users may notice that the speech recognition results from the inference server are not as accurate as they are when using PCM. A codec supporting higher bitrates and more encoding options like OPUS, in additional to some additional processing on the device, could alleviate some of these issues.

## Compatibility

There are practically millions of variables with Wi-Fi. ESP devices are Wi-Fi devices at their core and have been used on many Wi-Fi networks successfully. We feel confident that due to this Willow provides wide compatibility with various Wi-Fi network configurations but there's no way to tell if it's going to work for you.

If you have Wi-Fi problems let us know and we'll do our best within the limits of hardware support, software support, and physics to support Willow in your environment.

## My Wi-Fi Sucks

In the event you have an especially challenging Wi-Fi environment you can try using AMR-WB. It can be enabled during configuration in the Willow Configuration section by selecting "AMR-WB" under the "Audio codec to use" section. Try it out and let us know if it works for you!

For Wi-Fi experts (PLEASE HELP) you can also look at the various Wi-Fi options available under the Component config section of the configuration menu. However, as noted in the README and elsewhere you're kind of on your own with such changes and we can't claim support for every Wi-Fi network in the world and any changes you may make in this section.