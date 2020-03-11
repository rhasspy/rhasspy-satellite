# Rhasspy Satellite

## Installation

Install dependencies:

```bash
sudo apt-get install \
     python3 python3-dev python3-pip python3-venv \
     build-essential curl swig portaudio19-dev ca-certificates \
     mosquitto supervisor alsa-utils sox espeak flite
```

Clone/install `rhasspy-satellite`:

```bash
git clone --recursive https://github.com/rhasspy/rhasspy-satellite.git
cd rhasspy-satellite
make
```

### PicoTTS

If you want to use [picoTTS](https://en.wikipedia.org/wiki/SVOX) for text to speech, you must install it first. For the **Raspberry Pi Zero**, this has to be done manually:

```bash
curl -sSfL -o 'libttspico-utils_1.0+git20130326-3+rpi1_armhf.deb' \
     'http://archive.raspberrypi.org/debian/pool/main/s/svox/libttspico-utils_1.0+git20130326-3+rpi1_armhf.deb'
     
curl -sSfL -o 'libttspico0_1.0+git20130326-3+rpi1_armhf.deb' \
     'http://archive.raspberrypi.org/debian/pool/main/s/svox/libttspico0_1.0+git20130326-3+rpi1_armhf.deb'
     
sudo apt-get install \
     ./libttspico0_1.0+git20130326-3+rpi1_armhf.deb 
     ./libttspico-utils_1.0+git20130326-3+rpi1_armhf.deb
```

For everything *except* the Pi Zero, just do:

```bash
sudo apt-get install libttspico-utils
```

## Running

Once installation is finished, run `bin/rhasspy-satellite` with a profile language, for example:

```bash
bin/rhasspy-satellite --profile en
```

Wait for a log message like this:

```
DEBUG:__main__:Starting web server at http://0.0.0.0:12101
```

and then access the web interface at http://your-satellite-ip:12101

