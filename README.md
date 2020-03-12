# meeshkan-deb-builder
Docker image to build a meeshkan deb file.

# How to use
Run

```sh
docker run -v $PWD:/out fredrikfornwall/meeshkan-deb-builder
```

to create a deb file (such as `meeshkan-0.2.16.deb`) in the current directory.

It will use the [latest meeshkan release on PyPi](https://pypi.org/project/meeshkan/).


