SHELL := bash
PIP_INSTALL ?= install
DOWNLOAD_DIR = download
REQUIREMENTS = $(shell find . -mindepth 2 -maxdepth 2 -type f -name requirements.txt)

.PHONY: venv clean update-bin downloads

all: venv

clean:
	rm -rf .venv/

venv: requirements.txt update-bin downloads
	scripts/create-venv.sh

# Gather non-Rhasspy requirements from all submodules.
# Rhasspy libraries will be used from the submodule source code.
requirements.txt: $(REQUIREMENTS)
	cat $^ | grep -v '^rhasspy' | sort | uniq > $@

# Copy submodule scripts to shared bin directory.
update-bin:
	$(shell find . -mindepth 3 -maxdepth 3 -type f -name 'rhasspy-*' -path './rhasspy*/bin/*' -exec cp '{}' bin/ \;)
	chmod +x bin/*

# -----------------------------------------------------------------------------
# Downloads
# -----------------------------------------------------------------------------

downloads: $(DOWNLOAD_DIR)/snowboy-1.3.0.tar.gz $(DOWNLOAD_DIR)/pocketsphinx-python.tar.gz

# Download snowboy.
$(DOWNLOAD_DIR)/snowboy-1.3.0.tar.gz:
	mkdir -p "$(DOWNLOAD_DIR)"
	curl -sSfL -o $@ 'https://github.com/Kitt-AI/snowboy/archive/v1.3.0.tar.gz'

# Download Python Pocketsphinx library with no dependency on PulseAudio.
$(DOWNLOAD_DIR)/pocketsphinx-python.tar.gz:
	mkdir -p "$(DOWNLOAD_DIR)"
	curl -sSfL -o $@ 'https://github.com/synesthesiam/pocketsphinx-python/releases/download/v1.0/pocketsphinx-python.tar.gz'
