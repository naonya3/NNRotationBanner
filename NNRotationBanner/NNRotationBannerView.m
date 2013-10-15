//
//  NNRotationBanner.m
//  NNRotationBanner
//
//  Created by Naoto Horiguchi on 2013/09/27.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "NNRotationBannerView.h"

@interface NNRotationBannerView ()<UIScrollViewDelegate>
{
    int _numOfContent;
    
    NSMutableSet *_visibleCells;
    NSMutableDictionary *_supplementaryViewReuseQueues;
    
    int _touchedIndex;
}

@end

@implementation NNRotationBannerView

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
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    
    _numOfContent = 0;
    _supplementaryViewReuseQueues = @{}.mutableCopy;
    _visibleCells = [[NSMutableSet alloc] init];
}

- (void)layoutSubviews
{
    if (_numOfContent <= 0)
        return;
    
    float offsetX = self.contentOffset.x;
    float maxX = self.bounds.size.width * (_numOfContent * 3);
    float minX = self.bounds.size.width * _numOfContent;
    
    if (offsetX > maxX) {
        self.contentOffset = (CGPoint){self.bounds.size.width * (_numOfContent * 2) + abs(offsetX - maxX), 0};
    }else if (offsetX < minX) {
        self.contentOffset = (CGPoint){self.bounds.size.width * (_numOfContent * 2) + abs(offsetX - minX), 0};
    }
    
    NSArray *indexs = [self _indexsForItemInRect:(CGRect){
        .origin = self.contentOffset,
        .size = self.frame.size
    }];
    
    NSMutableSet *visibleCells = [NSMutableSet set];
    for (NSNumber *i in indexs) {
        int index = [i intValue];
        NNRotationBannerViewCell *cell = [self _cellForIndex:index];
        cell.frame = [self _rectForItemAtIndex:index];
        [visibleCells addObject:cell];
        [self addSubview:cell];
        if ([_visibleCells containsObject:cell]) {
            [_visibleCells removeObject:cell];
        }
    }
    for (NNRotationBannerViewCell *reusableCell in _visibleCells) {
        [self queueReusableCell:reusableCell];
    }
    _visibleCells = visibleCells;
}

- (void)queueReusableCell:(NNRotationBannerViewCell *)cell
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

- (NNRotationBannerViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    NSMutableSet *reusableCells = _supplementaryViewReuseQueues[reuseIdentifier];
    NNRotationBannerViewCell *cell = [reusableCells anyObject];
    if (cell) {
        [reusableCells removeObject:cell];
    }
    return cell;
}

- (void)reloadData
{
    _numOfContent = [self _numOfBanners];
    self.contentSize = [self _contentSize];
    self.contentOffset = CGPointZero;
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

- (NNRotationBannerViewCell *)_cellForIndex:(int)index
{
    for (NNRotationBannerViewCell *cell in _visibleCells) {
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

- (int)indexForCell:(NNRotationBannerViewCell *)cell
{
    if ([_visibleCells containsObject:cell]) {
        return cell.frame.origin.x / self.frame.size.width;
    }
    return NNRotationBannerCellIndexNotFound;
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
    return (internalIndex < _numOfContent)?internalIndex:internalIndex % _numOfContent;
}

- (int)_indexForItemAtPoint:(CGPoint)point
{
    for (NNRotationBannerViewCell *cell in _visibleCells) {
        if (CGRectContainsPoint(cell.frame, point)) {
            return [self indexForCell:cell];
        }
    }
    return NNRotationBannerCellIndexNotFound;
}

#pragma mark - Touch Handler
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    int index = [self _indexForItemAtPoint:point];
    if (index != NNRotationBannerCellIndexNotFound) {
        _touchedIndex = index;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    int index = [self _indexForItemAtPoint:point];
    if (_touchedIndex != NNRotationBannerCellIndexNotFound && _touchedIndex == index) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rotationBanner:didSelectItemAtIndex:)]) {
            [self.delegate rotationBanner:self didSelectItemAtIndex:[self _convertIndexFromInternalIndex:index]];
        }
    }
    _touchedIndex = NNRotationBannerCellIndexNotFound;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    _touchedIndex = NNRotationBannerCellIndexNotFound;
}


@end
