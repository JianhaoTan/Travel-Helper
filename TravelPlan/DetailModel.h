//
//  DetailModel.h
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *star;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *imgsrc;

+(instancetype)detailWithDict:(NSDictionary *)dict;


@end
