ANSIBLE_HOME=$HOME/repos/ansible
ANSIBLE_COLLECTIONS_PATH=$ANSIBLE_HOME/collections
mkdir -p $ANSIBLE_HOME
mkdir -p $ANSIBLE_COLLECTIONS_PATH
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/ansible
git clone https://github.com/ansible-collections/ansible.netcommon.git netcommon
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco
git clone https://github.com/CiscoDevNet/ansible-dcnm.git dcnm
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm
mkdir -p $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/env
cp $HOME/repos/configs/dcnm/requirements.txt $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/requirements.txt
cp $HOME/repos/configs/dcnm/constraints.txt $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/constraints.txt
cd $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm
/Library/Frameworks/Python.framework/Versions/3.11/bin/python3.11 -m venv .venv —prompt dcnm
cp $HOME/repos/configs/dcnm/env $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/env/env
source $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/.venv/bin/activate
source $ANSIBLE_COLLECTIONS_PATH/ansible_collections/cisco/dcnm/env/env

