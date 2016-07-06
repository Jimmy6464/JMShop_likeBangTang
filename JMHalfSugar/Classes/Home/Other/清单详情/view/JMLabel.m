//
//  JMLabel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/22.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMLabel.h"

@interface JMLabel ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;
@property (nonatomic, assign) CGFloat textSpacing;
@end
@implementation JMLabel
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)lineSpacing andTextEdgeInsets:(UIEdgeInsets)edgeInsets
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = font;
        self.textColor = color;
        self.textSpacing = lineSpacing;
        self.textEdgeInsets = edgeInsets;
        self.title = title;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    if (_title == nil) {
        return;
    }
    [_titleLabel removeFromSuperview];
    [self setUpSubviews];
}
- (void)setUpSubviews
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textEdgeInsets.left, _textEdgeInsets.top, self.width-_textEdgeInsets.left, _titleLabel.height)];
    _titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attributesString =[[NSMutableAttributedString alloc]initWithString:_title];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.lineSpacing = _textSpacing;
    //set up the margin of row
    [attributesString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _title.length)];
    //set up the color of word
    [attributesString addAttribute:NSForegroundColorAttributeName value:_textColor range:NSMakeRange(0, _title.length)];
    //set up the font
    [attributesString addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, _title.length)];
    
    _titleLabel.attributedText = attributesString;
    [_titleLabel sizeToFit];
    
    _titleLabel.frame = CGRectMake(_textEdgeInsets.left, _textEdgeInsets.top, self.width-_textEdgeInsets.left, _titleLabel.height);
    self.frame = CGRectMake(self.x, self.y+_textEdgeInsets.top, self.width, _titleLabel.height+_textEdgeInsets.top);
    [self addSubview:_titleLabel];
    
}
@end
