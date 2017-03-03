//
//  SuccessViewController.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/12.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "SuccessViewController.h"
#import "EntryViewController.h"
@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(gohome) userInfo:nil repeats:NO];
}


-(void)gohome
{
    [self.tabBarController setSelectedIndex:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
