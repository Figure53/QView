#!/bin/bash

# Based on http://furbo.org/2013/10/17/code-signing-and-mavericks/

codesign --verify --verbose=4 ~/Desktop/QView.app/
spctl --verbose=4 --assess --type execute ~/Desktop/QView.app/
