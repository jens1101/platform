# Platform.utils collection

## Tests

Note that the tests use Docker-in-Docker. Each test creates a Docker container
with the necessary environment for that test. The first run can take a while
because of image downloads and container setup.

### Sanity

```sh
ansible-test sanity --docker
```
