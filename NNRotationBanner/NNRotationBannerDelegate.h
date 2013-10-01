//
//  NNRotationBannerDelegate.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/10/01.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NNRotationBannerCell, NNRotationBanner;

@protocol NNRotationBannerDelegate <UIScrollViewDelegate>

@required
- (int)numberOfBannersInRotationBanner:(NNRotationBanner *)rotationBanner;
- (NNRotationBannerCell *)rotationBanner:(NNRotationBanner *)rotationBanner cellForIndex:(int)index;


@optional
- (void)rotationBanner:(NNRotationBanner *)rotationBanner didSelectItemAtIndex:(int)selectedIndex;

@end
