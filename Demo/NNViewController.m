//
//  NNViewController.m
//  NNRotationBannerView
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "NNViewController.h"

#import "NNRotationBannerView.h"
#import "NNRotationBannerViewCell.h"

#define NUMBER_OF_BANNER 10


@interface NNViewController ()<NNRotationBannerViewDelegate>
{
    NNRotationBannerView *_rotationBannerView;
    NSArray *_datas;
}

@end

@implementation NNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rotationBannerView = [[NNRotationBannerView alloc] initWithFrame:(CGRect){
                                                                            0.f,
                                                                            0.f,
                                                                            self.view.frame.size
                                                                        }];
    _rotationBannerView.delegate = self;
    [self.view addSubview:_rotationBannerView];
    
    NSMutableArray *tmpArr = @[].mutableCopy;
    for (int i = 0; i < NUMBER_OF_BANNER; i++) {
        [tmpArr addObject:[self _randomColor]];
    }
    _datas = tmpArr.copy;
    [_rotationBannerView reloadData];
}

- (UIColor *)_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - NNRotationBannerViewDelegate
- (void)rotationBanner:(NNRotationBannerView *)rotationBanner didSelectItemAtIndex:(int)selectedIndex
{
    NSLog(@"selected : %d", selectedIndex);
}

- (int)numberOfBannersInRotationBanner:(NNRotationBannerView *)rotationBanner
{
    return NUMBER_OF_BANNER;
}

- (NNRotationBannerViewCell *)rotationBanner:(NNRotationBannerView *)rotationBanner cellForIndex:(int)index
{
    static NSString *identifier = @"cell";
    NNRotationBannerViewCell *cell = [rotationBanner dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NNRotationBannerViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = _datas[index];
    cell.textLabel.text = [@(index) stringValue];
    return cell;
}



@end
