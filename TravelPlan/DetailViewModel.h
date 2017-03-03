//
//  DetailViewModel.h
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "JTHTTPManager.h"
#import <AFNetworking/AFNetworking.h>

@interface DetailViewModel : NSObject
@property(nonatomic,strong)RACCommand *fetchModelCommand;
@end
