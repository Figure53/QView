//
//  AppDelegate.m
//  QView
//
//  Created by Chris Ashworth on 4/6/15.
//  Copyright (c) 2015 Figure 53 LLC, http://figure53.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "AppDelegate.h"
#import <Quartz/Quartz.h>


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet PDFView *pdfView;
@property (strong) F53OSCServer *oscServer;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.oscServer = [F53OSCServer new];
    [self initializeOSC];
    
    [self.pdfView registerForDraggedTypes:@[ NSFilenamesPboardType ]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

- (void) initializeOSC
{
    self.oscServer.delegate = self;
    self.oscServer.port = 60000;
    
    NSString *errorString = nil;
    
    if ( ![self.oscServer startListening] )
    {
        NSLog( @"Error: unable to start listening for OSC on port %u.", self.oscServer.port );
        errorString = [NSString stringWithFormat:@"Unable to start listening for OSC messages on port %u.", self.oscServer.port ];
    }
    
    if ( errorString )
    {
        NSAlert *alert = [NSAlert new];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert setMessageText:@"Unable to initialize OSC"];
        [alert setInformativeText:errorString];
        [alert addButtonWithTitle:@"OK"];
        [alert runModal];
    }
}

- (void) takeMessage:(F53OSCMessage *)message
{
    // F53OSC reserves the right to send messages off the main thread; kick it to the main thread.
    [self performSelectorOnMainThread:@selector( processOscMessage: ) withObject:message waitUntilDone:NO];
}

- (void) processOscMessage:(F53OSCMessage *)message
{
    //NSLog( @"%@ sent OSC message: %@", message.replySocket, message );
    
    NSArray *addressParts = [message addressParts];
    if ( addressParts.count == 0 )
    {
        return;
    }
    
    if ( [[[addressParts firstObject] lowercaseString] isEqualToString:@"goto"] )
    {
        if ( addressParts.count < 2 )
            return;
        
        if ( [[[addressParts objectAtIndex:1] lowercaseString] isEqualToString:@"next"] )
        {
            [self.pdfView goToNextPage:self];
        }
        
        if ( [[[addressParts objectAtIndex:1] lowercaseString] isEqualToString:@"prev"] )
        {
            [self.pdfView goToPreviousPage:self];

        }
        
        if ( [[[addressParts objectAtIndex:1] lowercaseString] isEqualToString:@"page"] )
        {
            NSString *pageString = [addressParts objectAtIndex:2];
            NSInteger pageNumber = [pageString integerValue];
            
            [self.pdfView goToPage:[self.pdfView.document pageAtIndex:pageNumber - 1]];
        }
    }
}

@end
