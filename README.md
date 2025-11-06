# configs

Just a script to install the DCNM Ansible Collection and set requisite environment variables if you tend to do this a lot.

Installs the following:

1. uv
2. Python 3.11 (via uv) the DCNM Collection's currently-recommended Python version
3. $HOME/repos/ansible/collections/ansible_collections/ansible/netcommon
4. $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm
5. Adds the following to $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm

- pyproject.toml
  - Used by uv to install dependencies needed for the DCNM Ansible Collection (ansible, requests, pydantic, among others)
- pyrightconfig.json
  - Used by VS Code when editing files in the DCNM Ansible Collection
- .venv
  - source this (per below) to enable the virtual environment
- env/env
  - source this to add environment vars pointing to all the right places

## Usage

```bash
cd $HOME
mkdir repos
cd $HOME/repos
git clone https://github.com/allenrobel/configs.git
cd $HOME/configs/dcnm
./setup_repo.bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
source env/env
```

At this point, the repo is ready to use.  For example, to run unit tests related to the dcnm_fabric module:

```bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
source env/env
cd tests/unit/modules/dcnm
pytest -k dcnm_fabric
```
