#!/usr/bin/env bash
# Define variables
PYTHON_VERSION=3.11
REPOS_HOME=$HOME/repos
ANSIBLE_HOME=$REPOS_HOME/ansible
ANSIBLE_COLLECTIONS_PATH=$ANSIBLE_HOME/collections
REPO_DCNM=$ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm
REPO_CONFIGS=$REPOS_HOME/configs/dcnm
# Create directory structure
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
# Clone necessary repositories
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
git clone https://github.com/ansible-collections/ansible.netcommon.git netcommon
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
git clone https://github.com/CiscoDevNet/ansible-dcnm.git dcnm
# Set up Python virtual environment and install dependencies in the dcnm repo
cd $REPO_DCNM
mkdir -p $REPO_DCNM/env
# cp $REPO_CONFIGS/requirements.txt $REPO_DCNM/requirements.txt
# cp $REPO_CONFIGS/constraints.txt $REPO_DCNM/constraints.txt
# cp $REPO_CONFIGS/uv.lock $REPO_DCNM/uv.lock
cp $REPO_CONFIGS/pyproject.toml $REPO_DCNM/pyproject.toml
cp $REPO_CONFIGS/pyrightconfig.json $REPO_DCNM/pyrightconfig.json
cp $REPO_CONFIGS/env $REPO_DCNM/env/env
cd $REPO_DCNM
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv python install 3.11
uv venv .venv --python 3.11 --prompt dcnm
uv sync
