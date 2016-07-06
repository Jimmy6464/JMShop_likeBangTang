//
//  JMFavoriteCell.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMFavoriteCell.h"

@interface JMFavoriteCell ()
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (nonatomic, copy) NSString *title;
@end
static NSIndexPath *_currentIndexPath;
@implementation JMFavoriteCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMFavoriteCell" owner:nil options:nil] lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    self.createLabel.font = [UIFont systemFontOfSize:13];
    self.createLabel.textColor = JMSubTitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView title:(NSString *)title atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resueIdentifier = @"JMFavoriteCell";
    JMFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:resueIdentifier];
    if (!cell) {
        cell = [[JMFavoriteCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:resueIdentifier];
    }
    
    _currentIndexPath = indexPath;
    cell.title = title;
    return cell;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.listImageView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"0%ld",_currentIndexPath.row+1]];
    self.listTitleLabel.text = _title;
}
@end
