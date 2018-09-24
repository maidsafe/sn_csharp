#!/bin/sh
set -e

export VSINSTALLDIR="C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise"
export VisualStudioVersion="15.0"

docfx ./docs/docfx.json

SOURCE_DIR=$PWD
TEMP_REPO_DIR=$PWD/../my-project-gh-pages

echo "Removing temporary doc directory $TEMP_REPO_DIR"
rm -rf $TEMP_REPO_DIR
mkdir $TEMP_REPO_DIR

echo "Cloning the repo with the gh-pages branch"
git clone https://github.com/ravinderjangra/safe_app_csharp.git --branch gh-pages $TEMP_REPO_DIR

echo "Clear repo directory"
cd $TEMP_REPO_DIR
git rm -r *

echo "Copy documentation into the repo"
cp -r $SOURCE_DIR/docs/_site/* .

echo "Push the new docs to the remote branch"
git add . -A
git diff --quiet && git diff --staged --quiet || git commit -am "Update generated documentation"
git push origin gh-pages