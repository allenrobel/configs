#!/usr/bin/env bash
# Define script variables

if [ -n "$VIRTUAL_ENV" ]; then
    echo "Please deactivate the current virtual environment before running this script."
    exit 1
fi
echo "Setting environment variables..."
PYTHON_VERSION=3.11
REPOS_HOME=$HOME/repos
ANSIBLE_HOME=$REPOS_HOME/ansible
ANSIBLE_COLLECTIONS_PATH=$ANSIBLE_HOME/collections
REPO_DCNM=$ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm
REPO_SETUP=$REPOS_HOME/ansible-dcnm-setup

# Create directory structure
echo "Creating directory structure..."
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible

# Clone repositories
echo "Cloning ansible.netcommon into $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible/netcommon..."
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
git clone https://github.com/ansible-collections/ansible.netcommon.git netcommon
echo "Cloning ansible-dcnm into $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm..."
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
git clone https://github.com/CiscoDevNet/ansible-dcnm.git dcnm

# Copy useful files into the dcnm repository
mkdir -p $REPO_DCNM/env
echo "Copying $REPO_SETUP/dcnm/pyproject.toml to $REPO_DCNM/pyproject.toml..."
cp $REPO_SETUP/dcnm/pyproject.toml $REPO_DCNM/pyproject.toml
echo "Copying $REPO_SETUP/dcnm/env to $REPO_DCNM/env/env..."
cp $REPO_SETUP/dcnm/env $REPO_DCNM/env/env
cd $REPO_DCNM

# Install uv and use to create virtual environment and install
# dependencies required by the dcnm repository, including
# Python 3.11, requests, ansible, pydantic, etc.
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
echo "Installing Python 3.11 via uv..."
uv python install 3.11
echo "Creating virtual environment..."
uv venv .venv --python 3.11 --prompt dcnm
echo "Installing base dependencies via uv..."
uv sync --no-group dev --no-group test
echo "Setup complete. To start using the DCNM Ansible Collection, run:"
echo "  cd $REPO_DCNM"
echo "  source .venv/bin/activate"
echo "  source env/env"
echo "Happy automating!"