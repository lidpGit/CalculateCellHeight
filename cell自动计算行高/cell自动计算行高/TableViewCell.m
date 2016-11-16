//
//  TableViewCell.m
//  cell自动计算行高
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TableViewCell{
    UILabel     *_textLabel;
    UIImageView *_imageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    _textLabel.text = dict[@"text"];
    
    NSString *imageURL = _dict[@"image"];
    _imageView.image = nil;
    if (imageURL.length <= 0) {
        _imageView.hidden = YES;
    }else{
        _imageView.hidden = NO;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                _imageView.image = image;
            }
        }];
    }
    [self resetFrame];
}

- (void)resetFrame{
    CGRect frame = _imageView.frame;
    frame.origin.x = 15;
    frame.origin.y = 15;
    frame.size.width = self.dp_contentViewWidth - 30;
    frame.size.height = 60;
    _imageView.frame = frame;
    
    frame = _textLabel.frame;
    frame.origin.x = 15;
    frame.origin.y = [_dict[@"image"] length] > 0 ? CGRectGetMaxY(_imageView.frame) + 14 : 14;
    frame.size.width = self.dp_contentViewWidth - 30;
    _textLabel.frame = frame;
    [_textLabel sizeToFit];
}

- (CGFloat)dp_getCellHeight{
    [self resetFrame];
    return CGRectGetMaxY(_textLabel.frame) + 15;
}

@end
