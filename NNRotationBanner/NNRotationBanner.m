//
//  NNRotationBanner.m
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "NNRotationBanner.h"

#import "NNRotationBannerCell.h"

@interface NNRotationBanner ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    int _numOfContent;
    CGSize _contentSize;
    float _startOffsetX;
    
    NSMutableSet *_visibleCells;
    NSMutableDictionary *_supplementaryViewReuseQueues;
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

- (void)_initialize
{
    _supplementaryViewReuseQueues = @{}.mutableCopy;
    _visibleCells = [[NSMutableSet alloc] init];
}

- (void)layoutSubviews
{
    float offsetX = self.contentOffset.x;
    float maxX = self.bounds.size.width * (_numOfContent * 3);
    float minX = self.bounds.size.width * _numOfContent;
    
    if (offsetX > maxX) {
        self.contentOffset = (CGPoint){self.bounds.size.width * (_numOfContent * 2) + abs(offsetX - maxX),0};
    }
    
    if (offsetX < minX) {
        self.contentOffset = (CGPoint){self.bounds.size.width * (_numOfContent * 2) + abs(offsetX - minX),0};
    }
    
    NSArray *indexs = [self _indexsForItemInRect:(CGRect){
        .origin = self.contentOffset,
        .size = self.frame.size
    }];
    
    NSMutableSet *visibleCells = [NSMutableSet set];
    for (NSNumber *i in indexs) {
        int index = [i intValue];
        NNRotationBannerCell *cell = [self _cellForIndex:index];
        cell.frame = [self _rectForItemAtIndex:index];
        [visibleCells addObject:cell];
        [self addSubview:cell];
        if ([_visibleCells containsObject:cell]) {
            [_visibleCells removeObject:cell];
        }
    }
    for (NNRotationBannerCell *reusableCell in _visibleCells) {
        [self queueReusableCell:reusableCell];
    }
    _visibleCells = visibleCells;
}

- (void)queueReusableCell:(NNRotationBannerCell *)cell
{
    [cell removeFromSuperview];
    [cell prepareForReuse];
    NSMutableSet *reusableCells = _supplementaryViewReuseQueues[cell.reuseIdentifier];
    if (!reusableCells) {
        reusableCells = [NSMutableSet set];
        _supplementaryViewReuseQueues[cell.reuseIdentifier] = reusableCells;
    }
    [reusableCells addObject:cell];
}

- (NNRotationBannerCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    NSMutableSet *reusableCells = _supplementaryViewReuseQueues[reuseIdentifier];
    NNRotationBannerCell *cell = [reusableCells anyObject];
    if (cell) {
        [reusableCells removeObject:cell];
    }
    return cell;
}

- (void)reloadData
{
    _contentSize = [self _contentSize];
    _numOfContent = [self _numOfBanners];
    
//    //float startX = (CGRectGetWidth(self.frame) * (_numOfContent / 2));
    self.contentSize = _contentSize;
    self.contentOffset = (CGPoint) {
        .x = 0,
        .y = 0
    };
}

- (CGSize)_contentSize
{
    return (CGSize) {
        (float)[self _numOfBanners] * CGRectGetWidth(self.frame) * 4,
        CGRectGetHeight(self.frame)
    };
}

- (int)_numOfBanners
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfBannersInRotationBanner:)]) {
        return [self.delegate numberOfBannersInRotationBanner:self];
    }
    return 0;
}

- (NNRotationBannerCell *)_cellForIndex:(int)index
{
    for (NNRotationBannerCell *cell in _visibleCells) {
        int i = [self indexForCell:cell];
        if (index == i) {
            return cell;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rotationBanner:cellForIndex:)]) {
        return [self.delegate rotationBanner:self cellForIndex:[self _convertIndexFromInternalIndex:index]];
    }
    
    return nil;
}

- (int)indexForCell:(NNRotationBannerCell *)cell
{
    if ([_visibleCells containsObject:cell]) {
        return cell.frame.origin.x / self.frame.size.width;
    }
    return -1;
}

- (CGRect)_rectForItemAtIndex:(int)index
{
    return (CGRect){
        index * CGRectGetWidth(self.frame),
        0,
        .size = self.frame.size
    };
}

- (NSArray *)_indexsForItemInRect:(CGRect)rect
{
    NSMutableArray *indexs = @[].mutableCopy;
    
    int startIndex = rect.origin.x / self.frame.size.width;
    for (int i = startIndex; i < startIndex+2; i++) {
        [indexs addObject:@(i)];
    }

    return indexs;
}

- (int)_convertIndexFromInternalIndex:(int)internalIndex
{
    int maxNum = _numOfContent;
    return (internalIndex<maxNum)?internalIndex:internalIndex%maxNum;
}

@end
