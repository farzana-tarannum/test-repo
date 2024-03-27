#!/bin/bash
#
#
# create a new repository in github
gh repo create 
# add a new file to the repository
# add remote repository as farzana-tarannum/test-repo
# https://github
git remote add origin git://github.com/farzana-tarannum/test-repo.git 

# Generate a new public and private key pair
# -t rsa specifies the type of key to create
# -b 4096 specifies the number of bits in the key
# -C "hello world" specifies a comment
ssh-keygen -t rsa -b 4096 -C "hello world"
# Generate a new public and private key pair
# -t rsa specifies the type of key to create
# -b 4096 specifies the number of bits in the key
# -C "hello world" specifies a comment
# -f specifies the file name use ~/id/rsa
# -N specifies the passphrase -N "" specifies no passphrase
# -q specifies quiet mode -q suppresses the success message
ssh-keygen -t rsa -b 4096 -C "hello world" -f ~/id/rsa -N "" -q
# The key fingerprint is a unique identifier for the key
# The key's randomart image is a visual representation of the key
# key fingerprint is in SHA256 which is a cryptographic hash 
# functon that produces a 256-bit (32-byte) hash value
# in knowhost file the key is stored in base64 format
# generate SHA256 fingerprint
# -E specifies the hash algorithm -E sha256
# save the fingerprint in the known_host file using the -H option
# -H specifies to hash the hostname and the key when adding them to the known_hosts file
ssh-keygen -t rsa -b 4096 -C "hello world" -f ~/id/rsa -N "" -E sha256 -H 
# to save the fingerprint on a specific file use the -o option
ssh-keygen -t rsa -b 4096 -C "hello world" -f ~/id/rsa -N "" -E sha256

# using gh command add the public key to the github account
gh ssh-key add ~/.ssh/id_rsa.pub

gh auth refresh -h github.com -s admin:public_key

git push -u origin master 

git remote add origin htts://github.com/farzana-tarannum/test-repo.git
git remote --verbose
git push -u origin master
# * [new branch]     master -> master
# Branch 'master' set up to track remote branch 'master' from 'origin'.
# message: Branch 'master' set up to track remote branch 'master' from 'origin'. 
# means the local branch master is tracking the remote branch master
# from the remote repository origin
# meaning of origin is the remote repository where the local repository is pushed
# meaning of master is the branch of the local repository and the remote repository 
# is pushed to the master branch of the remote repository
#
# to see namer of brunches 
# git branch --list
# pull master branch from the remote repository
# git pull origin master
git config --global user.name "farzana-tarannum"
git config --global user.email "	"
git config --global editor "nvim"
git config --global core.editor "nvim"
# git config --global --list
git pull origin 
git pull origin master
git pull origin main
git pull origin master:main
git branch --set-upstream-to=origin/master abc
git branch --set-upstreamt-to=origin/master abc
git pull origin master:abc
git remote add origin git://github.com/farzana-tarannum/test-repo.git
git reset --hard origin/master
# reset the last 3 commits
git reset --hard HEAD~3 



