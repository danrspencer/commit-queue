# Commit Queue

An example project based on the idea from the Chromium commit queue to prevent the trunk ever being red while still allowing everyone to work on the trunk branch.

### How it works

1. A simple `pre-push` hook prevents direct pushes into the trunk branch
2. The bash script, `push-to-queue`, handles creating and push new unique branch
3. Concourse picks up the new branch, validates the commits are good then merges into master and deletes the branch
  
### Setup

##### Scripts

Run `make` in the root of the project to setup  the `pre-push` hook and the `push-to-queue` script.
```
$ make
```

##### Concourse
 
To start Concourse run `make` inside the `ci` folder, this will spin up the Vagrant box and setup the pipeline.

```
$ cd ci
$ make
```
