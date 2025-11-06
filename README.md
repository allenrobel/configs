# Install the DCNM Ansible Collection using uv

This repository exists because I prefer uv over pip for dependency management,
and the DCNM Ansible Collection is setup with pip in mind.

This repository contains a script which installs the DCNM Ansible Collection and uses uv to install
the DCNM Ansible Collection's dependencies.  The script also copies files (described below) into the
DCNM Ansible Collection repository that are useful for uv and for VS Code.

Hence, this repository is really only useful if you tend to do this a lot, or you've never done it
and want to understand how to do it.

## What gets installed

1. uv
2. Python 3.11 (via uv) the DCNM Collection's currently-recommended Python version
3. $HOME/repos/ansible/collections/ansible_collections/ansible/netcommon
4. $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm
5. uv installs files in $HOME/.local/bin/* (see bottom of this README for specifics)
6. The setup_repo.bash script sources $HOME/.local/bin/env immediately after uv is installed
7. The following files are added to the DCNM Ansible Collection in $HOME/repos/ansible/collections/ansible/collections/cisco/dcnm

- pyproject.toml
  - Used by uv to install dependencies needed for the DCNM Ansible Collection (ansible, requests, pydantic, among others)
  - Used by VS Code when editing files in the DCNM Ansible Collection
  - Used by the various linters for the DCNM Ansible Collection
- .venv
  - source this (per below) to enable the virtual environment
- env/env
  - source this to add environment vars pointing to all the right places

## Installation and Usage

```bash
mkdir -p $HOME/repos
cd $HOME/repos
git clone https://github.com/allenrobel/ansible-dcnm-setup.git
cd $HOME/ansible-dcnm-setup
./setup_repo.bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
source env/env
```

By default, setup_repo.bash uses `uv sync` to install runtime dependencies only.
There are two other sets of dependencies, described below, that are not installed
by default.

### Dependencies for testing

If you want to run `pytest` and/or `pytest --cov`, install the test group, per below.

```bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
uv sync --group test
```

### Dependencies use for development

If you want to run the various linters used by the DCNM Ansible Collection e.g.
`mypy`, `black`, `isort`, `pylint`, etc, install the dev group, per below.

```bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
uv sync --group dev
```

### Installing everything

If you want to install everything at once, you can do so with either of the following:

```bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
uv sync --all-groups

# OR

uv sync --group dev --group test
```

At this point, the DCNM Ansible Collection repository is ready to use.
For example, to run unit tests related to the dcnm_fabric module (assuming
you've added the testing dependencies as described above):

```bash
cd $HOME/repos/ansible/collections/ansible_collections/cisco/dcnm
source .venv/bin/activate
source env/env
cd tests/unit/modules/dcnm
pytest -k dcnm_fabric
```

## Files installed by uv

### On MacOS

```bash
arobel@Allen-M4 ~ % ls -l $HOME/.local/bin
total 82384
-rw-r--r--@ 1 arobel  staff       328 Nov  5 16:17 env
-rw-r--r--@ 1 arobel  staff       165 Nov  5 16:17 env.fish
lrwxr-xr-x@ 1 arobel  staff        86 Nov  5 16:27 python3.11 -> /Users/arobel/.local/share/uv/python/cpython-3.11.13-macos-aarch64-none/bin/python3.11
-rwxr-xr-x@ 1 arobel  staff  41831152 Oct 30 12:13 uv
-rwxr-xr-x@ 1 arobel  staff    336528 Oct 30 12:13 uvx
arobel@Allen-M4 ~ %
```

### On Ubuntu

```bash
(dcnm) arobel@glide:~$ ls -l $HOME/.local/bin
total 52332
-rw-rw-r-- 1 arobel arobel      328 Aug 17 23:49 env
-rw-rw-r-- 1 arobel arobel      165 Aug 17 23:49 env.fish
lrwxrwxrwx 1 arobel arobel       83 Nov  6 01:42 python3.11 -> /home/arobel/.local/share/uv/python/cpython-3.11.14-linux-x86_64-gnu/bin/python3.11
-rwxr-xr-x 1 arobel arobel 53208480 Oct 30 21:58 uv
-rwxr-xr-x 1 arobel arobel   362448 Oct 30 21:58 uvx
(dcnm) arobel@glide:~$
```
