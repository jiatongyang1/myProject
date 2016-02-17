//
//  BabyViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "BabyViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "AddBabyViewController.h"
@interface BabyViewController ()

@end

@implementation BabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
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

- (IBAction)homeBtn:(id)sender {
}

- (IBAction)settingBtn:(id)sender {
}

- (IBAction)startBtn:(id)sender {
    
    AddBabyViewController *babyController = [[AddBabyViewController alloc] init];
    babyController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:babyController animated:nil];
    
}

- (IBAction)inviteBtn:(id)sender {
}
@end
