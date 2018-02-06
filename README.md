# majournal

Journal while programming.

## Why Fork

This was forked because while [the original](https://github.com/groktools/journal) worked, it wasn't as simple as I'd like it to be. This has one command and works with multiple project roots open in a single window.

## Installation

You can install directly from Atom's package manager, using the command line, or directly from GitHub. CLI examples are below:

```sh
# From Atom.io directory
apm install majournal
# From GitHub
apm install malonehedges/majournal
```

## Usage

Use the key command or activate it from the Command Palette.

## Development

```sh
# Uninstall the official version if you have it installed and link the local version
apm uninstall majournal
apm link

# Publish a new version to Atom.io (major.minor.patch)
apm publish patch

# Getting the official version back
apm unlink
apm install majournal
```
