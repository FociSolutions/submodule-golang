#! /bin/bash 
# USAGE: configure-cert.sh 

mkdir t
cd t
git init
 
# git config --global user.signingkey $(gpgsm --list-secret-keys | awk 'match($0,/0x/) {id =  substr($0, RSTART, 10)}END{print id}')
# git config --global gpg.program $(which gpgsm)
# git config --global gpg.format x509

git config --global user.signingkey $(gpg --list-secret-keys --keyid-format 0xlong | awk 'match($0,/0x/) {id =  substr($0, RSTART+2, 16)}END{print id}')
git config --global gpg.program $(which gpg)

git config --global commit.gpgSign true
git config --global tag.gpgSign true

# go by default uses 'https'
git config --global url."git@github.com:".insteadOf "https://github.com/"

cd ..
rm -rf t

# gah - silly terminal
export GPG_TTY=$(tty)
gpgconf --kill gpg-agent