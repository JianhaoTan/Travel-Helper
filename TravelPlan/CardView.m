//
//  CardView.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/11.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "CardView.h"
#import "UIImageView+WebCache.h"

@interface CardView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
@implementation CardView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.alpha = 0.5;
    self.layer.cornerRadius = rect.size.height/2;
    self.backgroundColor = [UIColor blueColor];
    
    
}*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.layer setCornerRadius:20.0f];
    
    // border
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    
    // drop shadow
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:3.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    self.clipsToBounds=YES;
}
-(void)setModel:(DetailModel *)model
{
    _model=model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://104.236.117.77/TravelImage/%@",_model.imgsrc]] placeholderImage:[UIImage imageNamed:@"sanbackground"]];
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
            self.moneyLabel.text=@"$";
            break;
        case 2:
            self.moneyLabel.text=@"$$";
            break;
        case 3:
            self.moneyLabel.text=@"$$$";
            break;
        default:
            self.moneyLabel.text=@"Free";
            NSLog(@"12312312313");
    }
    
    
}
+(instancetype)theCardView
{
    return [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil][0];
}

@end
