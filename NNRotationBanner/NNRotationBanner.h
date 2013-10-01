//
//  NNRotationBanner.h
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NNRotationBannerDelegate.h"

typedef enum {
    NNRotationBannerCellIndexNotFound = -1
}NNRotationBannerCellIndex;

@class NNRotationBannerCell;

@interface NNRotationBanner : UIScrollView

@property (nonatomic) int currentIndex;
@property (nonatomic, weak) id<NNRotationBannerDelegate>delegate;

- (NNRotationBannerCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

// If target cell not show at screen, Return NNRotationBannerCellIndexNotFound.
- (int)indexForCell:(NNRotationBannerCell *)cell;
- (void)reloadData;

@end


