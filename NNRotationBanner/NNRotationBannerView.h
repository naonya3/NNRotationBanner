//
//  NNRotationBanner.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NNRotationBannerDelegate.h"
#import "NNRotationBannerViewCell.h"

typedef enum {
    NNRotationBannerCellIndexNotFound = -1
}NNRotationBannerCellIndex;

@class NNRotationBannerViewCell, uitable;

@interface NNRotationBannerView : UIScrollView

@property (nonatomic) int currentIndex;
@property (nonatomic, weak) id<NNRotationBannerViewDelegate>delegate;

- (NNRotationBannerViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

// If target cell not show at screen, Return NNRotationBannerCellIndexNotFound.
- (int)indexForCell:(NNRotationBannerViewCell *)cell;
- (void)reloadData;

@end
