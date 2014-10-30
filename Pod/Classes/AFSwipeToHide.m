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

#import "AFSwipeToHide.h"

@interface AFSwipeToHide()
{
    CGFloat _dragStartPosition;
    BOOL _isDragging;
}
@end

@implementation AFSwipeToHide

- (instancetype)init {
    self = [super init];
    if (self) {
        _scrollDistance = 50.0;
    }
    return self;
}

- (void)beginDragAtPosition:(CGFloat)position {
    _dragStartPosition = MAX(position, 0.0);
    _isDragging = YES;
}

- (void)scrollToPosition:(CGFloat)position {
    if (position <= 0.0) {
        [self _setPercentHidden:0.0 interactive:NO];
    }
    else if (_isDragging)
    {
        if (position < _scrollDistance)
        {
            CGFloat newPercentHidden = position/_scrollDistance;
            if (newPercentHidden < _percentHidden) {
                [self _setPercentHidden:newPercentHidden interactive:YES];
                return;
            }
        }
        
        if (_percentHidden < 1.0)
        {
            CGFloat diff = position - _dragStartPosition;
            
            [self _setPercentHidden:(diff / _scrollDistance) interactive:YES];
            
            if (diff < 0.0) {
                _dragStartPosition = position;
            }
        }
    }
}

- (void)endDragAtTargetPosition:(CGFloat)position velocity:(CGFloat)velocity {
    _isDragging = NO;
    
    BOOL shouldHide = YES;
    
    if (velocity < 0.0 ||
        (velocity == 0.0 && _percentHidden == 0.0) ||
        (position < _scrollDistance))
    {
        shouldHide = NO;
    }
    
    [self _setPercentHidden:shouldHide ? 1.0 : 0.0 interactive:NO];
}

- (void)_setPercentHidden:(CGFloat)percent interactive:(BOOL)interactive {
    if (percent < 0.0) percent = 0.0;
    if (percent > 1.0) percent = 1.0;
    
    if (percent == _percentHidden) return;
    
    _percentHidden = percent;
    
    [self.delegate swipeToHide:self didUpdatePercentHiddenInteractively:interactive];
}

@end

@implementation AFSwipeToHide(Delegate)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self beginDragAtPosition:scrollView.contentOffset.y + scrollView.contentInset.top];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self endDragAtTargetPosition:targetContentOffset->y + scrollView.contentInset.top velocity:velocity.y];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self scrollToPosition:scrollView.contentOffset.y + scrollView.contentInset.top];
}

@end