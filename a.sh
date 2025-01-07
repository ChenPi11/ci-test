#!/bin/sh
# Setup our macOS.
# Install Tor and webssh.
brew install tor
pip install webssh
# Copy torrc
cp torrc /usr/local/etc/tor/torrc
# Start Tor and webssh.
brew services start tor
webssh -p 8022
