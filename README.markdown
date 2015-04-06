# QView

QView is an experimental little PDF Viewer that can be controlled via OSC, slung together in a few minutes as a proof of concept.

You can download a pre-built binary from here: [http://figure53.com/downloads/QView.zip](http://figure53.com/downloads/QView.zip)

## Usage

 1. Drag a PDF file onto the window to view it.
 2. Send OSC messages to control which page is displayed. Use this format:

 ```/goto/page/number```

## Why does this exist

You might want to use it with [QLab][http://figure53.com/qlab/], so that you can display a script as you run a show, and have QLab control which page of the script is visible.  Other ways exist to accomplish this, such as using AppleScript with other PDF Viewers, but it's fun to have a very simple way to send a very simple command to a machine that might be on a different machine across the network.