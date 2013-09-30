//
//  NNRotationBanner.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNRotationBannerCell;

@protocol NNRotationBannerDelegate;

@interface NNRotationBanner : UIScrollView

@property (nonatomic) int currentIndex;
@property (nonatomic, weak) id<NNRotationBannerDelegate> delegate;

- (NNRotationBannerCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;
- (void)reloadData;

@end

@protocol NNRotationBannerDelegate <NSObject>

@required
- (int)numberOfBannersInRotationBanner:(NNRotationBanner *)rotationBanner;
- (NNRotationBannerCell *)rotationBanner:(NNRotationBanner *)rotationBanner cellForIndex:(int)index;

@optional
- (void)rotationBanner:(NNRotationBanner *)rotationBanner didSelectedIndex:(int)selectedIndex;

@end
