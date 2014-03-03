//
//  NNRotationBannerCell.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNRotationBannerViewCell : UIView

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic) BOOL highlighted;

// TEST
@property (nonatomic, strong) UILabel *textLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)prepareForReuse;

@end
