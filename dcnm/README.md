# configs

Installs the DCNM Ansible Collection and sets the requisite environment variables.

Installs the following:

1. uv
2. Python 3.11 (via uv)
3. $HOME/repos/ansible/collections/ansible_collections/ansible/netcommon
4. $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm
5. Adds the following to $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm

- pyproject.toml
- env/env
- pyrightconfig.json
- .venv

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
