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
    //_scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, self.frame.size.width);
    //_scrollView.delegate = self;
    //[self addSubview:_scrollView];
    
    _supplementaryViewReuseQueues = @{}.mutableCopy;
    _visibleCells = [[NSMutableSet alloc] init];
}

- (void)layoutSubviews
{
    NSArray *indexs = [self indexsForItemInRect:(CGRect){
        .origin = self.contentOffset,
        .size = self.frame.size
    }];
    
    NSMutableSet *visibleCells = [NSMutableSet set];
    for (NSNumber *i in indexs) {
        int index = [i intValue];
        NNRotationBannerCell *cell = [self _cellForIndex:index];
        cell.frame = [self rectForItemAtIndex:index];
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
    // ここで消さないほうがいいかも
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
//    [self layoutSubviews];
}

- (CGSize)_contentSize
{
    return (CGSize) {
        (float)[self _numOfBanners] * CGRectGetWidth(self.frame),
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
        return [self.delegate rotationBanner:self cellForIndex:index];
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

- (CGRect)rectForItemAtIndex:(int)index
{
    // とりあえずはマイナスのことは考えない
    return (CGRect){
        index * CGRectGetWidth(self.frame),
        0,
        .size = self.frame.size
    };
}

- (NSArray *)indexsForItemInRect:(CGRect)rect
{
    //内部的には最小Xをindex:0として扱い、外に見えるときは変換する
    NSMutableArray *indexs = @[].mutableCopy;
    
    // とりあえずはマイナスのこと考えないで実装する
    int startIndex = rect.origin.x / self.frame.size.width;
    for (int i = startIndex; i < startIndex + 2; i++) {
        [indexs addObject:@(i)];
    }

    return indexs;
}

@end
