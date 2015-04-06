//
//  QPDFView.m
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

#import "QPDFView.h"

@implementation QPDFView

#pragma mark - NSDraggingDestination

- (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [pboard availableTypeFromArray:@[ NSFilenamesPboardType ]] )
        return NSDragOperationGeneric;
    else
        return NSDragOperationNone;
}

- (NSDragOperation) draggingUpdated:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [pboard availableTypeFromArray:@[ NSFilenamesPboardType ]] )
        return NSDragOperationGeneric;
    else
        return NSDragOperationNone;
}

- (void) draggingExited:(id<NSDraggingInfo>)sender
{
}

- (void) draggingEnded:(id<NSDraggingInfo>)sender
{
}

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [pboard availableTypeFromArray:@[ NSFilenamesPboardType ]] )
    {
        NSArray *draggedItems = [pboard propertyListForType:NSFilenamesPboardType];
        NSURL *url = [NSURL fileURLWithPath:draggedItems.firstObject];
        self.document = [[PDFDocument alloc] initWithURL:url];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) concludeDragOperation:(id<NSDraggingInfo>)sender
{
    // Only called if drag is successful.
}

@end
