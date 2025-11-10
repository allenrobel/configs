#!/usr/bin/env bash
# Define script variables
PYTHON_VERSION=3.11
REPOS_HOME=$HOME/repos
ANSIBLE_HOME=$REPOS_HOME/ansible
ANSIBLE_COLLECTIONS_PATH=$ANSIBLE_HOME/collections
REPO_DCNM=$ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm
REPO_SETUP=$REPOS_HOME/ansible-dcnm-setup

# Create directory structure
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible

# Clone necessary repositories
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
git clone https://github.com/ansible-collections/ansible.netcommon.git netcommon
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
git clone https://github.com/CiscoDevNet/ansible-dcnm.git dcnm

# Copy useful files into the dcnm repository
mkdir -p $REPO_DCNM/env
cp $REPO_SETUP/dcnm/pyproject.toml $REPO_DCNM/pyproject.toml
cp $REPO_SETUP/dcnm/env $REPO_DCNM/env/env
cd $REPO_DCNM

# Install uv and use to create virtual environment and install
# dependencies required by the dcnm repository, including
# Python 3.11, requests, ansible, pydantic, etc.
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv python install 3.11
uv venv .venv --python 3.11 --prompt dcnm
uv sync --no-group dev --no-group test
