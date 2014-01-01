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

#import <AppKit/AppKit.h>

@class WebView;
@class CodeMirrorView;

@protocol CodeMirrorViewDelegate <NSObject>
@optional
-(void)codeMirrorViewDidFinishLoading:(CodeMirrorView*)view;
-(void)codeMirrorViewDidChangeContent:(CodeMirrorView*)view;
@end

@interface CodeMirrorView : NSView {
@private
  WebView* _webView;
#if !__has_feature(objc_arc)
  id<CodeMirrorViewDelegate> _delegate;
#endif
  BOOL _disableChangeNotifications;
}
@property(nonatomic, assign) id<CodeMirrorViewDelegate> delegate;

@property(nonatomic, readonly) NSArray* supportedMimeTypes;
@property(nonatomic, readonly, getter=isEdited) BOOL edited;  // YES if content edited since last set or last undo history cleaning

@property(nonatomic, copy) NSString* mimeType;
@property(nonatomic, copy) NSString* content;  // Does not notify delegate when setting
@property(nonatomic) BOOL lineWrapping;
@property(nonatomic) NSUInteger tabSize;
@property(nonatomic) NSUInteger indentUnit;
@property(nonatomic) BOOL tabInsertsSpaces;
- (void)clearUndoHistory;
@end
