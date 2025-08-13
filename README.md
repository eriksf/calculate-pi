# Calculate PI

A python uv project demo for calculating PI.

## Prerequisites

- Git
- Docker
- Python >= 3.12 (prefer using [asdf](https://asdf-vm.com/), [pyenv](https://github.com/pyenv/pyenv) or or [uv managed versions](https://docs.astral.sh/uv/concepts/python-versions/) to system python)
- [uv](https://docs.astral.sh/uv/)
  
  ```console
  > curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

- [bump-my-version](https://callowayproject.github.io/bump-my-version/) tool
  
  ```console
  > uv tool install bump-my-version
  ```

## Installation

```console
> git clone git@github.com:eriksf/calculate-pi.git
> cd calculate-pi
> uv venv --seed --python 3.12
> uv sync
```

## Usage

```console
> calculate-pi --help
Usage: calculate-pi [OPTIONS] NUMBER

  Calculate pi using a Monte Carlo estimation.

  NUMBER is the number of random points.

Options:
  --version                       Show the version and exit.
  --log-level [NOTSET|DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set the log level  [default: 20]
  --log-file PATH                 Set the log file
  --help                          Show this message and exit.
```

## Development

To update the version, use the `bump-my-version` tool. Use the `show-bump` subcommand to show version bumps based on the current version:

```console
> uvx bump-my-version show-bump
0.5.0 ── bump ─┬─ major ─ 1.0.0
               ├─ minor ─ 0.6.0
               ╰─ patch ─ 0.5.1
```

To test the version bump before updating anything and show what files will be changed, use the `--dry-run` option to the `bump <version>` subcommand:

```console
> uvx bump-my-version bump patch --dry-run -v
Starting BumpVersion 1.2.1
Reading configuration
  Reading config file: /Users/eriksf/Devel/git/calculate-pi/pyproject.toml
  Parsing current version '0.5.0'
  No setup hooks defined
  Attempting to increment part 'patch'
    Values are now: major=0, minor=5, patch=1
  New version will be '0.5.1'
Dry run active, won't touch any files.

File calculate_pi/version.py: replace `{current_version}` with `{new_version}`
  Found '0\.5\.0' at line 1: 0.5.0
  Would change file calculate_pi/version.py:
    *** before calculate_pi/version.py
    --- after calculate_pi/version.py
    ***************
    *** 1 ****
    ! __version__ = '0.5.0'
    --- 1 ----
    ! __version__ = '0.5.1'

Processing config file: /Users/eriksf/Devel/git/calculate-pi/pyproject.toml
  Found '0\.5\.0' at line 1: 0.5.0
  Would change file /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:tool.bumpversion.current_version:
    *** before /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:tool.bumpversion.current_version
    --- after /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:tool.bumpversion.current_version
    ***************
    *** 1 ****
    ! 0.5.0
    --- 1 ----
    ! 0.5.1
  Found '0\.5\.0' at line 1: 0.5.0
  Would change file /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:project.version:
    *** before /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:project.version
    --- after /Users/eriksf/Devel/git/calculate-pi/pyproject.toml:project.version
    ***************
    *** 1 ****
    ! 0.5.0
    --- 1 ----
    ! 0.5.1
No pre-commit hooks defined
  Would not commit
  Would not tag
No post-commit hooks defined
Done.
```

To do the actual update, use the `uvx bump-my-version bump <version>` subcommand to update the version in both the `pyproject.toml` and the `calculate_pi/version.py` files:

```console
> uvx bump-my-version bump patch
```

After updating the version and committing the changes back to the repo, you should `tag` the repo to match this version:

```console
> git tag -a 0.5.1 -m "Version 0.5.1"
> git push origin 0.5.1
```
