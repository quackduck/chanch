# Chanch - Full control of channel and channel width on macOS

Build with `swift build` in the root directory. Run `./chanch --help` for more info.

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

Why not just use `airport`, you ask? This is why (also a demo of chanch at the same time):
<!-- ![](https://github.com/quackduck/chanch/assets/38882631/3ff827d7-41bd-4eb8-a6cc-cc6bdc43acf5) -->

<img width="848" alt="image" src="https://github.com/quackduck/chanch/assets/38882631/3ff827d7-41bd-4eb8-a6cc-cc6bdc43acf5">


