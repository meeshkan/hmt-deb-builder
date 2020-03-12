# meeshkan-deb-builder
Docker image to build a meeshkan deb file.

# How to install the debian package
Run the following commands:

```sh
apt install ca-certificates
echo "deb [trusted=yes] https://dl.bintray.com/meeshkan/apt all main" | sudo tee -a /etc/apt/sources.list
apt update
apt install meeshkan
```

# How to build the debian package
Run

```sh
docker run -v $PWD:/out fredrikfornwall/meeshkan-deb-builder
```

to create a deb file (such as `meeshkan-0.2.16.deb`) in the current directory.

It will use the [latest meeshkan release on PyPi](https://pypi.org/project/meeshkan/).
