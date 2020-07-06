#!/bin/bash

# This script sets up pulseaudio virtual devices
# The following variables must be set to the names of your own microphone and speakers devices
# You can find their names with the following commands :
# pacmd list-sources
# pacmd list-source-outputs
# Use pavucontrol to make tests for your setup and to make the runtime configuration
# Route your audio source to virtualspeaker
# Record your sound (videoconference) from virtualmic.monitor


# Create the null sinks
# virtualspeaker gets your audio sources (mplayer ...) that you want to hear and share
# virtualmic gets all the audio you want to share (virtualspeaker + micro)
pactl load-module module-null-sink sink_name=virtualspeaker sink_properties=device.description="virtualspeaker"
pactl load-module module-null-sink sink_name=virtualmic sink_properties=device.description="virtualmic"

# Now create the loopback devices, all arguments are optional and can be configured with pavucontrol
# Here sink 0 is source speaker sink (confirm using pacmd list-sinks)
pactl load-module module-loopback source=virtualspeaker.monitor sink=0 latency_msec=1
# Here sink 2 is virtualmic (confirm using pacmd list-sinks)
pactl load-module module-loopback source=virtualspeaker.monitor sink=2 latency_msec=1
# Here source 1 is source mic (confirm using pacmd list-sources)
pactl load-module module-loopback source=1 sink=2 latency_msec=1
