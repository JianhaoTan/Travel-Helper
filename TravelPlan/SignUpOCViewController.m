//
//  SignUpOCViewController.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/12.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "SignUpOCViewController.h"
#import "JTHTTPManager.h"
#import "SuccessViewController.h"
@interface SignUpOCViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *signup_uname;
@property (weak, nonatomic) IBOutlet UITextField *signup_pwd;
@property (weak, nonatomic) IBOutlet UITextField *signup_cfm_pwd;

@end

@implementation SignUpOCViewController
- (IBAction)submit_btn:(id)sender {
    
    if(self.signup_pwd.text==self.signup_cfm_pwd.text)
    {
        NSMutableDictionary *param=[NSMutableDictionary dictionary];
        param[@"uname"] = self.signup_uname.text;
        param[@"pwd"] = self.signup_pwd.text;
        
        JTHTTPManager *manager=[JTHTTPManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:@"http://45.78.32.225/signup.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([string isEqualToString:@"success"]) {
                UIViewController *vc=[[UIStoryboard storyboardWithName:@"Main"bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"vc"];
                if ([vc isKindOfClass:[SuccessViewController class]]) {
                    SuccessViewController *svc=(SuccessViewController *)vc;
                    float w=[[UIScreen mainScreen] bounds].size.width;
                    float h=[[UIScreen mainScreen] bounds].size.height;
                    UILabel *dLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
                    dLabel.text=[NSString stringWithFormat:@"Success"];
                    [svc.view addSubview:dLabel];
                    [self.navigationController pushViewController:svc animated:YES];
                }
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
    if ([self.signup_uname.text isEqual:@""]||[self.signup_pwd.text isEqualToString:@""]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"No empty username/password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *callAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:callAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.signup_uname.delegate=self;
    self.signup_pwd.delegate=self;
    self.signup_cfm_pwd.delegate=self;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return false;
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
