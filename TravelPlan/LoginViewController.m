//
//  LoginViewController.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/12.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "LoginViewController.h"
#import "SuccessViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *login_uname;
@property (weak, nonatomic) IBOutlet UITextField *login_pwd;

@end

@implementation LoginViewController
- (IBAction)login_btn:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"Login"])
    {
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    param[@"uname"] = self.login_uname.text;
    param[@"pwd"] = self.login_pwd.text;
    
    JTHTTPManager *manager=[JTHTTPManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://45.78.32.225/login.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([string integerValue]==1) {
            UIViewController *vc=[[UIStoryboard storyboardWithName:@"Main"bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"vc"];
                float w=[[UIScreen mainScreen] bounds].size.width;
                float h=[[UIScreen mainScreen] bounds].size.height;
                UILabel *dLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
                dLabel.text=[NSString stringWithFormat:@"Hello, %@",self.login_uname.text];
                [vc.view addSubview:dLabel];
                [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"Invalid username/password" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *callAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:callAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
    }];
    }
}

- (IBAction)signup_btn:(id)sender {
    UIViewController *vc=[[UIStoryboard storyboardWithName:@"Main"bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"signvc"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.login_uname.delegate=self;
    self.login_pwd.delegate=self;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed: @"bg3.png"]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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
