#!/bin/bash

if [[ -z "$@" ]]; then
    echo >&2 "You must supply a project name!"
    exit 1
fi

echo $1

PNAME=$1
DIR=$(pwd)

sed -i "s/uno11/$PNAME/" sample-mux.yml

sed -i "s|dos22|$DIR|" sample-mux.yml

mv sample-mux.yml .proj-tmuxinator.yml

ln -s $DIR/.proj-tmuxinator.yml $HOME/.tmuxinator/$PNAME.yml



sed -i "s/CHANGEME/$PNAME/" a-build.sh

sed -i "s/CHANGEME/$PNAME/" b-launch.sh

/bin/bash $DIR/a-build.sh

mv a-build.sh .build-tool.sh

mv b-launch.sh 1-launch.sh

REALDIR=$(pwd)/htdocs

/bin/rm -rf $REALDIR

git clone --quiet --depth 1 https://github.com/hspin/tpl_webdev.git $REALDIR

cd $REALDIR && rm -rf .git

ln -s /install/node_modules node_modules

