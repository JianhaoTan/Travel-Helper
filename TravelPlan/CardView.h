//
//  CardView.h
//  TravelPlan
//
//  Created by Jeremy on 2016/12/11.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"


@interface CardView : UIView

@property(nonatomic,strong)DetailModel *model;
+(instancetype)theCardView;


@end
