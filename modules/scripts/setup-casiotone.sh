#!/usr/bin/env bash

# Set up JACK
jack_control start
jack_control ds alsa
jack_control dps device hw:LKS250
jack_control dps rate 44100
jack_control dps nperiods 2
jack_control dps period 256

# Start FluidSynth
fluidsynth -a jack -m alsa_seq -l -i /usr/share/soundfonts/default.sf2 &

# Connect MIDI ports
sleep 2
aconnect "LK-S250" "FLUID Synth"