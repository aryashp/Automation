#!/bin/sh
set -e

export VSINSTALLDIR="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community"
export VisualStudioVersion="16.5.4"

docfx docfx_project/docfx.json

SOURCE_DIR=$PWD
TEMP_REPO_DIR=$PWD/../Automation-gh-pages

echo "Removing temporary doc directory $TEMP_REPO_DIR"
rm -rf $TEMP_REPO_DIR
mkdir $TEMP_REPO_DIR

echo "Cloning the repo with the gh-pages branch"
git clone https://github.com/aryashp/Automation.git --branch gh-pages $TEMP_REPO_DIR

echo "Clear repo directory"
cd $TEMP_REPO_DIR
git rm -r *

echo "Copy documentation into the repo"
cp -r $SOURCE_DIR/docfx_project/_site/* .

echo "Push the new docs to the remote branch"
git add . -A
git commit -m "Update generated documentation"
git push origin gh-pages --force
