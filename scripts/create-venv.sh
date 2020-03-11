#!/usr/bin/env bash
set -e

if [[ -z "${PIP_INSTALL}" ]]; then
    PIP_INSTALL='install'
fi

# Directory of *this* script
this_dir="$( cd "$( dirname "$0" )" && pwd )"
src_dir="$(realpath "${this_dir}/..")"

# -----------------------------------------------------------------------------

venv="${src_dir}/.venv"
download="${src_dir}/download"

# -----------------------------------------------------------------------------

# Create virtual environment
if [[ ! -d "${venv}" ]]; then
    echo "Creating virtual environment at ${venv}"
    python3 -m venv "${venv}"
fi

source "${venv}/bin/activate"

# Install Python dependencies
echo "Installing Python dependencies"
pip3 ${PIP_INSTALL} --upgrade pip
pip3 ${PIP_INSTALL} --upgrade wheel setuptools

if [[ -s "${download}/snowboy-1.3.0.tar.gz" ]]; then
    pip3 ${PIP_INSTALL} --upgrade "${download}/snowboy-1.3.0.tar.gz"
fi

if [[ -s "${download}/pocketsphinx-python.tar.gz" ]]; then
    pip3 ${PIP_INSTALL} --upgrade "${download}/pocketsphinx-python.tar.gz"
fi

pip3 ${PIP_INSTALL} --upgrade -r requirements.txt

# -----------------------------------------------------------------------------

echo "OK"
