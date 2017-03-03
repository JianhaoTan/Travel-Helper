//
//  DetailCell.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *aView;

@end

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(DetailModel *)model
{
    _model=model;
    //[self.backgroundImageView addSubview:self.aView];
    self.titleLabel.text=_model.title;
    self.detailLabel.text=_model.detail;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://104.236.117.77/TravelImage/%@",_model.imgsrc]] placeholderImage:[UIImage imageNamed:@"obama"]];
    self.locationLabel.text=_model.location;
    switch ([_model.star integerValue]) {
        case 1:
            self.starLabel.text=@"★";
            break;
        case 2:
            self.starLabel.text=@"★★";
            break;
        case 3:
            self.starLabel.text=@"★★★";
            break;
        case 4:
            self.starLabel.text=@"★★★★";
            break;
        case 5:
            self.starLabel.text=@"★★★★★";
            break;
            
        default:
            self.starLabel.text=@"";
    }
    switch ([_model.price integerValue])
    {
        case 1:
            self.priceLabel.text=@"$";
            break;
        case 2:
            self.priceLabel.text=@"$$";
            break;
        case 3:
            self.priceLabel.text=@"$$$";
            break;
        default:
            self.priceLabel.text=@"Free";
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
