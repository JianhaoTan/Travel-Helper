//
//  ShakeViewController.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeImageView.h"

@interface ShakeViewController ()
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet ShakeImageView *animationImageView;


@end

@implementation ShakeViewController
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray=[[NSMutableArray alloc] init];
        for(int i=0;i<73;i++)
        {
            [_imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"frame_%d_delay-0.03s%@", i, @".gif"]]];
        }
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.animationImageView.animationImages=self.imageArray;
    //[self.animationImageView startAnimating];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.animationImageView becomeFirstResponder];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.animationImageView resignFirstResponder];
    [super viewWillDisappear:animated];
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
