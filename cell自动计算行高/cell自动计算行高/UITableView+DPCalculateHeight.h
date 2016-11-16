//
//  UITableView+DPCalculateHeight.h
//  cell自动计算行高
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - tableview category
@interface UITableView (DPCalculateHeight)

/**
 获取cell高度
 
 @param identifier    重用标识符
 @param configuration 配置cell，设置cell数据源
 
 @return 返回cell高度
 */
- (CGFloat)dp_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id tempCell))configuration;

/**
 获取Header/Footer高度
 
 @param identifier    重用标识符
 @param configuration 回调，用于设置数据源
 
 @return 高度
 */
- (CGFloat)dp_heightForHeaderFooterViewReuseIdentifier:(NSString *)identifier configuration:(void (^)(id tempHeaderFooterView))configuration;

@end

#pragma mark - cell category
@interface UITableViewCell (DPLayoutCell)

/**
 contentView宽度
 */
@property (assign, nonatomic) CGFloat dp_contentViewWidth;

/**
 获取cell高度，默认45
 
 @return 计算后的高度
 */
- (CGFloat)dp_getCellHeight;

@end

#pragma mark - header/footer category
@interface UITableViewHeaderFooterView (DPLayoutHeaderFooterView)

/**
 contentView宽度
 */
@property (assign, nonatomic) CGFloat dp_contentViewWidth;

/**
 获取高度，默认20
 
 @return 计算后的高度
 */
- (CGFloat)dp_getHeaderFooterViewHeight;

@end
