#!/usr/bin/env bash
set -e

# Directory of *this* script
this_dir="$( cd "$( dirname "$0" )" && pwd )"
src_dir="$(realpath "${this_dir}/..")"

# -----------------------------------------------------------------------------

repo_dir="${src_dir}/.rhasspy-voltron"
if [[ ! -d "${repo_dir}" ]]; then
    mkdir -p "${repo_dir}"
    cd "${repo_dir}"
    git init
    git remote add origin 'https://github.com/rhasspy/rhasspy-voltron.git'
    git config core.sparseCheckout true
    echo 'docs' > .git/info/sparse-checkout
fi

cd "${repo_dir}"
git pull origin master

docs_dir="${src_dir}/docs"
rm -rf "${docs_dir}"
cp -R "${repo_dir}/docs" "${docs_dir}"
