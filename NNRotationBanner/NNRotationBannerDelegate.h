//
//  NNRotationBannerDelegate.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/10/01.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NNRotationBannerViewCell, NNRotationBannerView;

@protocol NNRotationBannerViewDelegate <UIScrollViewDelegate>

@required
- (int)numberOfBannersInRotationBanner:(NNRotationBannerView *)rotationBanner;
- (NNRotationBannerViewCell *)rotationBanner:(NNRotationBannerView *)rotationBanner cellForIndex:(int)index;


@optional
- (void)rotationBanner:(NNRotationBannerView *)rotationBanner didSelectItemAtIndex:(int)selectedIndex;

@end
