//
//  TableHeaderView.m
//  cell自动计算行高
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "TableHeaderView.h"
#import "UITableView+DPCalculateHeight.h"

@implementation TableHeaderView{
    UILabel *_label;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor redColor];
        
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    [self resetFrame];
    _label.text = text;
    [_label sizeToFit];
}

- (void)resetFrame{
    CGRect frame = _label.frame;
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.width = self.dp_contentViewWidth - 20;
    _label.frame = frame;
}

- (CGFloat)dp_getHeaderFooterViewHeight{
    return CGRectGetMaxY(_label.frame) + 10;
}

@end
