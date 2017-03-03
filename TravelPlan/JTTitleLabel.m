//
//  JTTitleLabel.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "JTTitleLabel.h"

@implementation JTTitleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment=NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale=0.0;
    }
    return self;
}
-(void)setScale:(CGFloat)scale
{
    _scale=scale;
    
    self.textColor=[UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}
@end
