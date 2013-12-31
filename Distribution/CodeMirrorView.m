/*
 Copyright (c) 2013, Pierre-Olivier Latour
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * The name of Pierre-Olivier Latour may not be used to endorse
 or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PIERRE-OLIVIER LATOUR BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <WebKit/WebKit.h>

#import "CodeMirrorView.h"

@implementation CodeMirrorView

@synthesize delegate=_delegate;

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
  if (selector == @selector(change)) {
    return NO;
  }
  return YES;
}

- (void)change {
  if ([_delegate respondsToSelector:@selector(codeMirrorViewDidEditContent:)]) {
    [_delegate codeMirrorViewDidEditContent:self];
  }
}

- (void)webView:(WebView*)sender didFinishLoadForFrame:(WebFrame*)frame {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetDelegate" withArguments:@[self]];
  
  if ([_delegate respondsToSelector:@selector(codeMirrorViewDidFinishLoading:)]) {
    [_delegate codeMirrorViewDidFinishLoading:self];
  }
}

- (id)initWithFrame:(NSRect)frameRect {
  if ((self = [super initWithFrame:frameRect])) {
    _webView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height)];
    [_webView setFrameLoadDelegate:self];
    [self addSubview:_webView];
    [self setAutoresizesSubviews:YES];
    [_webView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
    
    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CodeMirrorView" ofType:@"bundle"]];
    NSData* data = [NSData dataWithContentsOfFile:[bundle pathForResource:@"index" ofType:@"html"]];
    if (data == nil) {
      [self release];
      return nil;
    }
    [[_webView mainFrame] loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[bundle resourceURL]];
  }
  return self;
}

- (void)dealloc {
  [_webView release];
  
  [super dealloc];
}

- (NSArray*)supportedMimeTypes {
  return [[[[[_webView mainFrame] windowObject] callWebScriptMethod:@"SupportedMimeTypes" withArguments:@[]] componentsSeparatedByString:@","] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)setMimeType:(NSString*)type {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetMimeType" withArguments:@[type]];
}

- (NSString*)mimeType {
  return [[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetMimeType" withArguments:@[]];
}

- (void)setContent:(NSString*)content {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetContent" withArguments:@[content]];
}

- (NSString*)content {
  return [[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetContent" withArguments:@[]];
}

- (void)setLineWrapping:(BOOL)wrapping {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetLineWrapping" withArguments:@[[NSNumber numberWithBool:wrapping]]];
}

- (BOOL)lineWrapping {
  return [[[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetLineWrapping" withArguments:@[]] boolValue];
}

- (void)setTabSize:(NSUInteger)size {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetTabSize" withArguments:@[[NSNumber numberWithUnsignedInteger:size]]];
}

- (NSUInteger)tabSize {
  return [[[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetTabSize" withArguments:@[]] unsignedIntegerValue];
}

- (void)setIndentUnit:(NSUInteger)unit {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetIndentUnit" withArguments:@[[NSNumber numberWithUnsignedInteger:unit]]];
}

- (NSUInteger)indentUnit {
  return [[[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetIndentUnit" withArguments:@[]] unsignedIntegerValue];
}

- (void)setTabInsertsSpaces:(BOOL)flag {
  [[[_webView mainFrame] windowObject] callWebScriptMethod:@"SetTabInsertSpaces" withArguments:@[[NSNumber numberWithBool:flag]]];
}

- (BOOL)tabInsertsSpaces {
  return [[[[_webView mainFrame] windowObject] callWebScriptMethod:@"GetTabInsertSpaces" withArguments:@[]] boolValue];
}

@end
