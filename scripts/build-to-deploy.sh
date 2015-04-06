#!/bin/bash

xcodebuild -target QView -scheme QView -archivePath ~/Desktop/QView.xcarchive archive 
xcodebuild -target QView -exportArchive -exportFormat APP -archivePath ~/Desktop/QView.xcarchive -exportPath ~/Desktop/QView.app
rm -rf ~/Desktop/QView.xcarchive
#./scripts/check-code-signature.sh
