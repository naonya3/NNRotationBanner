//
//  NNRotationBannerCell.m
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "NNRotationBannerCell.h"

@implementation NNRotationBannerCell
{
    UIScrollView *_scrollView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_contentView];
        
        // TEST
        _textLabel = [[UILabel alloc] initWithFrame:self.frame];
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textLabel.font = [UIFont systemFontOfSize:50];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _textLabel.shadowOffset = CGSizeMake(0, 1);
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    
    return self;
}

- (void)prepareForReuse
{
    NSLog(@"prepare");
}

@end
