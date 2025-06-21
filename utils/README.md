# Platform.utils collection

## Roles

### Python Setup

Sets up Python 3 on the target host. This uses raw tasks and does itself not
rely on Python.

### Docker Setup

Sets up Docker and Docker Compose on the target host.

### k0s Setup

Sets up a single node k0s controller on the target host. The resulting kube
config will be copied to "[inventory directory]/artifacts/k0s-kubeconfig.yml".

### k0s Remove

Removes a k0s setup from the target host.

### k0s Config Edit

Edits the existing k0s config by merging the existing config with the desired
changes.

### Python venv

A convenience role for setting up a python virtual environment. It installs all
the necessary dependencies, allows for additional Pip packages to be installed,
and updates the Python interpreter used by Ansible.

## Tests

Note that the tests use Docker-in-Docker. Each test creates a Docker container
with the necessary environment for that test. The first run can take a while
because of image downloads and container setup.

### Sanity

```sh
ansible-test sanity --docker
```
