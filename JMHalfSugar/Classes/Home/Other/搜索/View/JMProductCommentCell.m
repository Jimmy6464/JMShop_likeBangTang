//
//  JMProductCommentCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/20.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductCommentCell.h"
#import "JMCommentModel.h"
#import "JMAuthor.h"
@interface JMProductCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end
@implementation JMProductCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMProductCommentCell" owner:nil options:nil] lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    self.commentAuthorLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0];
    self.commentAuthorLabel.textColor = [UIColor colorWithHexString:@"6AA4C1"];
    
    self.commentTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0];
    self.commentTimeLabel.textColor = [UIColor colorWithHexString:@"DDDDDD"];
    
    self.likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    [self.likeButton setImage:[UIImage imageNamed:@"iconfont-icondianzan"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"iconfont-icondianzanhou"] forState:UIControlStateSelected];
    [self.likeButton setTitle:@"0" forState:UIControlStateNormal];
    [self.likeButton setTitleColor:JMSubTitleColor forState:UIControlStateNormal];
    
}
- (IBAction)likesOrDislikeAction:(UIButton *)sender {
    NSInteger newPraiseCount = sender.currentTitle.integerValue;
    if (sender.selected == YES) {
        newPraiseCount --;
    }else {
        newPraiseCount ++;
    }
    _model.praiseCount = [NSString stringWithFormat:@"%ld",newPraiseCount];
    [sender setTitle:_model.praiseCount forState:UIControlStateNormal];
    sender.selected = !sender.selected;
    _model.is_praise = !_model.is_praise;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JMCommentModel *)model
{
    _model = model;
    if (!model) {
        return;
    }
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.headerImageURL] placeholderImage:[UIImage imageNamed:@"HeaderPlaceHolder"]];
    _commentAuthorLabel.text = _model.nickname;
    [_commentAuthorLabel sizeToFit];
    _commentTimeLabel.text = _model.createTime;
    
    //is commented or @ sb.
    [self buildContentLabel];
    
    if (model.is_praise == YES) {
        _likeButton.selected = YES;
    }
    [_likeButton setTitle:_model.praiseCount forState:UIControlStateNormal];
    
    model.cellHeight = CGRectGetMaxY(_contentLabel.frame)+25;
    
}
- (void)buildContentLabel
{
    NSString *contentStr = @"哈哈侃侃";
    if (_model.isReplyed == YES) {
        contentStr = [NSString stringWithFormat:@"回复@%@:%@",_model.at_User.nickname,_model.content];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:contentStr];
        //fill color to content
        [content addAttribute:NSForegroundColorAttributeName value:JMSubTitleColor range:NSMakeRange(0, contentStr.length)];
        NSString *str = [NSString stringWithFormat:@"@%@",_model.at_User.nickname];
        [content addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"6AA4C1"] range:NSMakeRange(3, str.length)];
        //adjusted font
        [content addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:15.0] range:NSMakeRange(0, contentStr.length)];
        //add  margin
        NSMutableParagraphStyle *style1 = [NSMutableParagraphStyle new];
        style1.lineBreakMode = NSLineBreakByWordWrapping;
        style1.lineSpacing = 11.0;
        [content addAttribute:NSParagraphStyleAttributeName value:style1 range:NSMakeRange(0, contentStr.length)];
        _contentLabel.attributedText = content;
        
    }else {
        contentStr = _model.content == nil ? @"kffd":_model.content;
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:contentStr];
        //fill color to content
        [content addAttribute:NSForegroundColorAttributeName value:JMSubTitleColor range:NSMakeRange(0, contentStr.length)];

        //adjusted font
        [content addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:15.0] range:NSMakeRange(0, contentStr.length)];
        //add  margin
        NSMutableParagraphStyle *style1 = [NSMutableParagraphStyle new];
        style1.lineBreakMode = NSLineBreakByWordWrapping;
        style1.lineSpacing = 2.5;
        [content addAttribute:NSParagraphStyleAttributeName value:style1 range:NSMakeRange(0, contentStr.length)];
        _contentLabel.attributedText = content;
        
    }
    _contentLabel.numberOfLines = 0;
    [_contentLabel sizeToFit];
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"JMProductCommentCell";
    JMProductCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMProductCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
@end
