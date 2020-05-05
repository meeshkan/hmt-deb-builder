# hmt-deb-builder
Docker image to package hmt into a deb package.

# How to install the debian package
Run the following commands:

```sh
echo "deb [trusted=yes] https://dl.bintray.com/hmt/apt all main" | sudo tee -a /etc/apt/sources.list
apt update && apt install hmt
```

Depending on the environment `ca-certificates` may need to be installed, and `sudo` not necessary. See [https://gitlab.com/fornwall/ci-test](https://gitlab.com/fornwall/ci-test) for how to install the package in the GitLab CI environment.

# How to build the debian package
Run the following command to create a deb file (such as `hmt-0.2.16.deb`) in the current directory:

```sh
docker run -v $PWD:/out fredrikfornwall/hmt-deb-builder
```

It will use the [latest hmt release on PyPi](https://pypi.org/project/hmt/).
