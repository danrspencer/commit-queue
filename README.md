# Commit Queue

An example project based on the idea from the Chromium commit queue to prevent the trunk ever being red while still allowing everyone to work on the trunk branch.

### How it works

1. A simple `pre-push` hook prevents direct pushes into the trunk branch
2. The bash script, `push-to-queue`, handles creating and push new unique branch
3. Concourse picks up the new branch, validates the commits are good then merges into master and deletes the branch
  
### Setup

To setup the `pre-push` hook and the `push-to-queue` script simple run `make` from the root of the project.
 
To start Concourse run `make` inside the `ci` folder.