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

#import "ViewController.h"
#import <AFSwipeToHide/AFSwipeToHide.h>

@interface ViewController ()<UITableViewDataSource, AFSwipeToHideDelegate>
{
    CGFloat _headerHeight;
}
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AFSwipeToHide *swipeToHide;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerHeight = self.titleHeight.constant;
    
    _swipeToHide = [[AFSwipeToHide alloc] init];
    _swipeToHide.scrollDistance = _headerHeight;
    _swipeToHide.delegate = self;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(_headerHeight + [self statusBarHeight], 0.0, 0.0, 0.0);
    
    self.tableView.backgroundColor = self.titleLabel.backgroundColor;
    
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    
    self.tableView.delegate = (id<UITableViewDelegate>)_swipeToHide;
    
    [self updateElements];
}

- (void)updateElements {
    AFSwipeToHide *swipeToHide = _swipeToHide;
    CGFloat percentHidden = swipeToHide.percentHidden;
    
    self.toolbarBottomSpace.constant = -percentHidden * 44.0;
    self.titleHeight.constant = (1.0 - percentHidden) * _headerHeight + [self statusBarHeight];
    self.titleLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:(1.0 - percentHidden)];
}

#pragma mark - Sizing utils

- (CGFloat)statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark - AFUSwipeToHide delegate

- (void)swipeToHide:(AFSwipeToHide *)swipeToHide didUpdatePercentHiddenInteractively:(BOOL)interactive {
    [self updateElements];
    
    if (!interactive) {
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.45 initialSpringVelocity:0.0 options:0 animations:^{
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

#pragma mark - Just a simple table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Item %i", ((int)indexPath.row + 1)];
    
    return cell;
}

@end
