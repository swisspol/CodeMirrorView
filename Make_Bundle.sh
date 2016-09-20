#!/bin/sh -e

# Copyright (c) 2013-2016, Pierre-Olivier Latour
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# * The name of Pierre-Olivier Latour may not be used to endorse
# or promote products derived from this software without specific
# prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL PIERRE-OLIVIER LATOUR BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

if [ $# != 1 ]; then
  echo "Usage: $0 'version'"
  exit 1
fi
VERSION="$1"

ARCHIVE="CoreMirror.tar.gz"

BUNDLE_PATH="Distribution/CodeMirrorView.bundle"
CONTENTS_PATH="$BUNDLE_PATH/Contents"
RESOURCES_PATH="$CONTENTS_PATH/Resources"

rm -f "$ARCHIVE"
curl -L -o "$ARCHIVE" "https://github.com/marijnh/CodeMirror/archive/$VERSION.tar.gz"
tar -xf "$ARCHIVE"
rm -f "$ARCHIVE"
mv -f "CodeMirror-$VERSION" "CodeMirror"

rm -rf "$BUNDLE_PATH"
mkdir -p "$RESOURCES_PATH"

cp "Bundle-Info.plist" "$CONTENTS_PATH/Info.plist"
perl -p -i -e "s|__VERSION__|$VERSION|g" "$CONTENTS_PATH/Info.plist"
plutil -convert "binary1" "$CONTENTS_PATH/Info.plist"

cp "CodeMirror/LICENSE" "$RESOURCES_PATH"

MODES=""
cp "CodeMirror/lib/codemirror.css" "$RESOURCES_PATH"
cp "CodeMirror/lib/codemirror.js" "$RESOURCES_PATH"
mkdir -p "$RESOURCES_PATH/modes"
for DIRECTORY in "CodeMirror/mode/"*; do
  if [ -d "$DIRECTORY" ]; then
    MODE=`basename "$DIRECTORY"`
    if [ -f "$DIRECTORY/$MODE.js" ]; then
      cp "$DIRECTORY/$MODE.js" "$RESOURCES_PATH/modes/$MODE.js"
      chmod a-x "$RESOURCES_PATH/modes/$MODE.js"
      MODES="$MODES<script src=\"modes/$MODE.js\"></script>"
    else
      echo "[WARNING] Failed copying mode '$MODE'"
    fi
  fi
done

mkdir -p "$RESOURCES_PATH/addons"
cp -r "CodeMirror/addon/dialog" "$RESOURCES_PATH/addons"
cp -r "CodeMirror/addon/search" "$RESOURCES_PATH/addons"
cp -r "CodeMirror/addon/comment" "$RESOURCES_PATH/addons"

cp "Bundle-Index.html" "$RESOURCES_PATH/index.html"
perl -p -i -e "s|<!--MODES-->|$MODES|g" "$RESOURCES_PATH/index.html"

rm -rf "CodeMirror"
echo "Success!"
