# Development images based on Fedora

Fedora images with commmon remote development tools and various toolchains. Tested on x86_64 and aarch64 with podman, but should work with docker as well.

Based on https://github.com/coder/code-server, all relevant trademarks and rights are of their respective owners.

## Building

```bash
podman build -f Dockerfile.base -t fedora-development-base
podman build -f Dockerfile.code-server -t fedora-code-server
podman build -f Dockerfile.helix -t fedora-helix
podman build -f Dockerfile.nvim -t fedora-nvim
# Select the desired editors and toolchains
podman build -f Dockerfile.llvm --build-arg="CODE_EDITOR=helix" -t fedora-helix-llvm
podman build -f Dockerfile.rust --build-arg="CODE_EDITOR=nvim" -t fedora-nvim-rust
podman build -f Dockerfile.golang --build-arg="CODE_EDITOR=code-server" -t fedora-code-server-golang
```

## code-server

Usage [as documented in the original](https://coder.com/docs/code-server/latest/install#docker)

## helix, nvim

Run with `-it` flags. Zsh is the default session, could be overriden in the run command.
