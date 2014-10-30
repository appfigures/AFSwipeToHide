// Copyright (c) 2014 appFigures Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

@protocol AFSwipeToHideDelegate;

@interface AFSwipeToHide : NSObject

@property (nonatomic, weak) id<AFSwipeToHideDelegate> delegate;

// A value between 0 - 1 representing how hidden
// the view in question should be. Use this value
// to update your toolbar, navigation bar, etc.
@property (nonatomic) float percentHidden;
// How much the user needs to scroll to completely
// hide the view.
@property (nonatomic) CGFloat scrollDistance;

// These are usually called from the UIScrollViewDelegate.
- (void)beginDragAtPosition:(CGFloat)position;
- (void)endDragAtTargetPosition:(CGFloat)position velocity:(CGFloat)velocity;
- (void)scrollToPosition:(CGFloat)position;

@end

@protocol AFSwipeToHideDelegate <NSObject>

// Triggered when one of the 3 update methods above
// is called and changes the percentHidden. When the change
// isn't interactive it should probably be animated.
- (void)swipeToHide:(AFSwipeToHide *)swipeToHide didUpdatePercentHiddenInteractively:(BOOL)interactive;

@end

// This class can also be used as a scrollView delegate directly.
@interface AFSwipeToHide(Delegate)<UIScrollViewDelegate>

@end