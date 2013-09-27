//
//  NNRotationBanner.m
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "NNRotationBanner.h"

@interface NNRotationBanner ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation NNRotationBanner

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (NNRotationBannerCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    return nil;
}

- (void)_initialize
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

#pragma mark - UIScrollViewDelegate


@end
