# Scala environment

## JDK

```sh
sudo apt install openjdk-21-jdk-headless
```

## Coursier

```sh
curl -fL "https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz" | gzip -d > ~/.local/bin/cs && \
  chmod +x ~/.local/bin/cs
```

Add `~/.local/share/coursier/bin` to my path.

Then run `cs setup`

## scalafmt (probably not needed if you run `cs setup`)

```sh
cs install scalafmt
```
