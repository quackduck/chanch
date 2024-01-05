# Chanch - Full control of channel and channel width on macOS

Install with `brew install quackduck/tap/chanch` or build from source with `swift build` in the root directory.

```
Chanch is a WiFi channel changer for macOS allowing complete control over channel
number and channel width

USAGE: chanch --status
       chanch <channel-num> [--80 | --40 | --20]

ARGUMENTS:
  <channel-num>           The WiFi channel number to change to

OPTIONS:
  --80/--40/--20          Channel width in MHz.
                          (Usually 80 for the 5GHz band and 20 for the 2GHz band)
  --status                Just print the current channel, don't change it.
  -h, --help              Show help information.
```

Chanch is useful when packet sniffing (for example, with [wif](https://github.com/quackduck/wif)). To discover channels to listen on, you can use the airport utility to run a network scan: `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s`

Why not just use `airport`, you ask? Essentially, it's because `airport` doesn't allow changing the channel width, so when you switch from a 2.4 GHz band channel to a 5 GHz band channel, you may still have the narrower 20 MHz width instead of the expected 80 MHz width. Here's a demo of this:
<!-- ![](https://github.com/quackduck/chanch/assets/38882631/3ff827d7-41bd-4eb8-a6cc-cc6bdc43acf5) -->

<img width="848" alt="image" src="https://github.com/quackduck/chanch/assets/38882631/3ff827d7-41bd-4eb8-a6cc-cc6bdc43acf5">


