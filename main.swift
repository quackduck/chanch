#!/usr/bin/swift

import CoreWLAN
//import Foundation

// get CWWiFiClient from CoreWLAN
let client = CWWiFiClient.shared()
let iface = client.interface() // get default interface
// print default interface name
print(iface?.interfaceName ?? "No interface")

let currChannel = iface?.wlanChannel() // get current channel
print(currChannel ?? "No channel")

// set channel to 36 with 80MHz channel width and 5 ghz
// let channel = CWChannel(channelWidth: CWChannelWidth.width80MHz, channelNumber: 36, channelBand: CWChannelBand.band5GHz)

// list of allowed channels
let channels = iface?.supportedWLANChannels()

//print(channels)

// filter for the channel we want
let channel = channels?.filter({ $0.channelNumber == 36 && $0.channelWidth == CWChannelWidth.width80MHz }).first

print(channel ?? "Channel not available")

// if not available, exit
if channel == nil {
    exit(1)
}

print("YOOO")
    // set channel
try iface?.setWLANChannel(channel!)

// iface.setWLANChannel() // set channel

print("Current channel:", iface?.wlanChannel() ?? "No channel")
