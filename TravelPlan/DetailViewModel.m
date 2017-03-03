//
//  DetailViewModel.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel
-(instancetype)init
{
    if(self=[super init])
    {
        [self setupRACCommand];
    }
    return self;
}
- (void)setupRACCommand
{
    @weakify(self);
    _fetchModelCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForModelWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM=array;
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}
- (void)requestForModelWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(NSURLSessionTask *task, NSError *error))failure{
    NSString *fullUrl = [@"http://104.236.117.77/GetStuff.php" stringByAppendingString:url];
   [[JTHTTPManager manager] GET:fullUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       success(responseObject);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failure(task,error);
   }];
}

@end
