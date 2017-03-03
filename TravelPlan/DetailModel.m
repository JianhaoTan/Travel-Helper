//
//  DetailModel.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
+(instancetype)detailWithDict:(NSDictionary *)dict
{
    DetailModel *model=[[self alloc] init];
    model.imgsrc=dict[@"Image"];
    model.price=dict[@"Price"];
    model.title=dict[@"Name"];
    model.star=dict[@"Star"];
    model.detail=dict[@"Description"];
    model.location=dict[@"Location"];
    return model;
}

@end
