# Commit Queue

Based on the idea from the Chromium commit queue to prevent the trunk ever being red while still allowing everyone to work on the trunk branch.

![alt terminal](https://raw.githubusercontent.com/danrspencer/commit-queue/master/docs/terminal.png)

![alt concourse](https://raw.githubusercontent.com/danrspencer/commit-queue/master/docs/concourse.png)

![alt slack](https://raw.githubusercontent.com/danrspencer/commit-queue/master/docs/slack.png)

## Quick Start

Quickly bootstrap your project with Concourse and the Commit Queue pipeline by running the `bootstrap.sh` in your project root.

```
curl -s https://raw.githubusercontent.com/danrspencer/commit-queue/master/bootstrap.sh | bash /dev/stdin
```

The bootstrap script assumes you already have Vagrant installed. If you don't use the following commands to install it:

```
brew cask install virtualbox
brew cask install vagrant
```

To push using the queue run `push-to-queue`. Optionally you can pass command arguments to the script which are forwarded to `git commit`, e.g.

```
push-to-queue -am "adding all the files, setting commit msg and pushing!"
```

## Manual Setup

##### Scripts

Copy the `ci`, `scripts` and `Makefile` into your project, then run `make` in the root of the project to setup the `pre-push` hook and the `push-to-queue` script.
```
$ make
```

Optionally run `make setup-quick-push-script` to setup a shortcut to the push script as `p2q`. 

##### Concourse
 
To start Concourse run `make` inside the `ci` folder, this will spin up the Vagrant box and setup the pipeline.

```
$ cd ci
$ make
```


## How it works

1. A simple `pre-push` hook prevents direct pushes into the trunk branch
1. The bash script, `push-to-queue`, handles creating and pushes new unique branch
1. Concourse picks up the new branch validates it by running tests, linting, etc..
    1. If it passes then merges the commits into master and deletes the branch
    1. If it fails it leaves branch in place so it can be more easily diagnosed and alerts the team via Slack
