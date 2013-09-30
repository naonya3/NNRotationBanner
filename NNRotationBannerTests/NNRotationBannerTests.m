//
//  NNRotationBannerTests.m
//  NNRotationBannerTests
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NNRotationBanner.h"

#define NUM_OF_CELL 5

@interface NNRotationBannerTests : XCTestCase<NNRotationBannerDelegate>
{
    NNRotationBanner *_rotationBanner;
}

@end

@implementation NNRotationBannerTests

- (void)setUp
{
    [super setUp];
    _rotationBanner = [[NNRotationBanner alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (int)numberOfBannersInRotationBanner:(NNRotationBanner *)rotationBanner
{
    return NUM_OF_CELL;
}

@end
