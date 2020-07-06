This repository contains notes and personal configuration to set up system audio sharing pulseaudio configuration

# Credits
[https://github.com/toadjaune](https://github.com/toadjaune)

# Compatibility

This was tested on Ubuntu 18.04.

# Installation

- Run the script : `./pulse_setup.sh`
- Configure manually your media source and videoconference input with `pavucontrol`

# Heads-up

Here are some good-to-know things, I wish I knew some before starting working on this project :
- NEVER use headphones when tinkering with sound. It can be really dangerous, in case of driver malfunctioning, or sudden high volume.
- None of this is reboot-proof. You will have to re-execute the script after every reboot.
- `pulseaudio -k` restarts your pulseaudio daemon, reloading its configuration. Be careful however, it seems that sometimes it is not enough and makes weird stuff; if you have any doubt, reboot. (Actually, `pulseaudio -k` kills your pulseaudio daemon, but your system should restart it automatically. If not, you can do it with `pulseaudio --start-server`)
- By default, pavucontrol may not display everything in its listings, pay attention to the filters at the bottom of the window.
- It's probably possible to make these modifications reboot-proof by specifying the configuration in pulseaudio configuration files.

# Kinds of PulseAudio devices
Now a few explanations about the different kinds of devices involved. This is only what I have understood experimenting so far, it has no pretention to be absolutely true and flawless.
The italicized words are vocabulary that I'm either not sure of, or made up for the sake of clarity.
- By "device", I mean either an application connected to pulseaudio API, a driver interfacing a hardware component with pulseaudio, or a virtual device created inside pulseaudio. Pretty much everything that you will see in pavucontrol listings.
- A sink is an audio output.
  - The sinks are listed in the `Output Devices` of pavucontrol.
  - A sink can receive any number of streams from various _players_. In this case, these inputs are superposed.
  - The classic example of sink is speakers, or headphones.
- A _player_ is obtained from a device executing some playback, that you would expect to be routed to your speakers by default.
  - _Players_ appear in the `Playback` tab of pavucontrol
  - The stream coming from a _player_ is directly routed to a sink.
  - You can select the target sink in the `Playback` tab of pavucontrol.
  - The stream from a _player_ can only be routed to a single sink.
  - A music player is a good example of such device.
- An _input_ is created by a device that is not likely to output to speakers, but more likely to be discarded or routed to another program.
  - _Inputs_ appear in the `Input Devices` tab of pavucontrol.
  - The stream from an _input_ in not routed anywhere by default. You have to capture it.
  - A microphone is a very good example of such device.
- A _recorder_ is a device that captures the stream of an _input_.
  - _Recorders_ are listed in the `Recording` tab of pavucontrol.
  - In this same tab, you can choose the input they're recording.
  - A given recorder can only record a single _input_, but multiple recorders can listen to the same _input_.
  - A good example of _recorder_ is a videoconference program, that will both contain a _player_ (for the playback), and a _recorder_ (for sending your own voice through a microphone).
- Every sink has an associated _monitor_.
  - A _monitor_ is an _input_, that mirrors the sink it is attached to.
  - A good example of use is recording you desktop to make a video tutorial. A desktop recording program will likely provide you a _recorder_, that you can either attach to you microphone (to get your voice), or to the _monitor_ of your speakers (to record the sound emitted by you desktop during the demo).
- A null sink is a virtual sink created with the `module-null-sink` of pulseaudio.
  - It behaves like a "real" sink, except that it discards the stream instead of outputing it to speakers (or whatever).
  - It has an attached _monitor_ as well.
- A _loopback device_ is a virtual device created with the `module-loopback` of pulseaudio.
  - It behaves like the combination of a _recorder_ and an _input_, relaying the stream from the former to the latter.
  - Combined with _monitors_ and null sinks, it should allow you to do basically anything you want.

# Schemas

## My setup from `pavucontrol`
### Player
Input:
Output:
#### Video Conferencing
Input:
Output:
#### System
Input:
Output:
