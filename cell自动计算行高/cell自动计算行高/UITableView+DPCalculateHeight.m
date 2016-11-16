//
//  UITableView+DPCalculateHeight.m
//  cell自动计算行高
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "UITableView+DPCalculateHeight.h"
#import <objc/runtime.h>

@implementation UITableView (DPCalculateHeight)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self.class, @selector(dequeueReusableCellWithIdentifier:));
        Method swizzledMethod = class_getInstanceMethod(self.class, @selector(dp_dequeueReusableCellWithIdentifier:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        originalMethod = class_getInstanceMethod(self.class, @selector(dequeueReusableHeaderFooterViewWithIdentifier:));
        swizzledMethod = class_getInstanceMethod(self.class, @selector(dp_dequeueReusableHeaderFooterViewWithIdentifier:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma mark - ---------------------- Cell
- (CGFloat)dp_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id))configuration{
    if (!identifier) {
        return 0;
    }
    UITableViewCell *cell = [self dp_cellForReuseIdentifier:identifier];
    !configuration ?: configuration(cell);
    return [cell dp_getCellHeight];
}

- (UITableViewCell *)dp_cellForReuseIdentifier:(NSString *)identifier{
    NSMutableDictionary *cellList = objc_getAssociatedObject(self, _cmd);
    if (!cellList) {
        cellList = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, cellList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewCell *cell = cellList[identifier];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(cell != nil, @"必须先注册cell(调用[tableView registerClass forCellReuseIdentifier:])");
        cellList[identifier] = cell;
    }
    return cell;
}

- (nullable __kindof UITableViewCell *)dp_dequeueReusableCellWithIdentifier:(NSString *)identifier{
    UITableViewCell *cell = [self dp_dequeueReusableCellWithIdentifier:identifier];
    cell.dp_contentViewWidth = CGRectGetWidth(self.frame);
    return cell;
}

- (nullable __kindof UITableViewHeaderFooterView *)dp_dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier{
    UITableViewHeaderFooterView *headerFooterView = [self dp_dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    headerFooterView.dp_contentViewWidth = CGRectGetWidth(self.frame);
    return headerFooterView;
}

#pragma mark - ---------------------- HeaderView/FooterView
- (CGFloat)dp_heightForHeaderFooterViewReuseIdentifier:(NSString *)identifier configuration:(void (^)(id))configuration{
    if (!identifier) {
        return 0;
    }
    UITableViewHeaderFooterView *headerFooterView = [self dp_headerFooterViewForReuseIdentifier:identifier];
    !configuration ?: configuration(headerFooterView);
    return [headerFooterView dp_getHeaderFooterViewHeight];
}

- (UITableViewHeaderFooterView *)dp_headerFooterViewForReuseIdentifier:(NSString *)identifier{
    NSMutableDictionary *headerFooterViewList = objc_getAssociatedObject(self, _cmd);
    if (!headerFooterViewList) {
        headerFooterViewList = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, headerFooterViewList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewHeaderFooterView *headerFooterView = headerFooterViewList[identifier];
    if (!headerFooterView) {
        headerFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        NSAssert(headerFooterView != nil, @"必须先注册UITableViewHeaderFooterView");
        headerFooterViewList[identifier] = headerFooterView;
    }
    return headerFooterView;
}

@end

#pragma mark - cell category
@implementation UITableViewCell (DPLayoutCell)

- (void)setDp_contentViewWidth:(CGFloat)dp_contentViewWidth{
    objc_setAssociatedObject(self, @selector(dp_contentViewWidth), @(dp_contentViewWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dp_contentViewWidth{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (CGFloat)dp_getCellHeight{
    return 45;
}

@end

#pragma mark - header/footer category
@implementation UITableViewHeaderFooterView (DPLayoutHeaderFooterView)

- (void)setDp_contentViewWidth:(CGFloat)dp_contentViewWidth{
    objc_setAssociatedObject(self, @selector(dp_contentViewWidth), @(dp_contentViewWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dp_contentViewWidth{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (CGFloat)dp_getHeaderFooterViewHeight{
    return 20;
}

@end
