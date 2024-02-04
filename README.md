# Development images based on Fedora

Based on https://github.com/coder/code-server, all relevant trademarks and rights are of their respective owners.

## Building

```bash
podman build -f Dockerfile.base -t fedora-development-base
podman build -f Dockerfile.code-server -t fedora-code-server
podman build -f Dockerfile.helix -t fedora-helix
podman build -f Dockerfile.nvim -t fedora-nvim
```

## code-server

Usage [as documented in the original](https://coder.com/docs/code-server/latest/install#docker)

## helix, nvim

Run with `-it` flags. Zsh is the default session, could be overriden in the run command.
