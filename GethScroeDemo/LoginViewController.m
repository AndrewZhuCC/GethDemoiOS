//
//  LoginViewController.m
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "LoginViewController.h"

#import "GethClient.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfUsername;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender {
    if (self.tfUsername.text.length == 0) {
        [self showProgressHUDWithTitle:@"Username" detail:@"Empty Username" hideAfterDelay:3.f];
        return;
    }
    if (self.tfPassword.text.length == 0) {
        [self showProgressHUDWithTitle:@"Password" detail:@"Empty Password" hideAfterDelay:3.f];
        return;
    }
    [self showProgressHUDWithTitle:nil detail:nil];
    
    [GethClientInstance requestLoginWithUsername:self.tfUsername.text password:self.tfPassword.text success:^(NSURLResponse * _Nonnull response, NSString * _Nonnull userID) {
        [self hideProgressHUD];
        [self performSegueWithIdentifier:@"showFunction" sender:self];
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self showProgressHUDWithTitle:@"Error" detail:[NSString stringWithFormat:@"obj:%@ error:%@", responseObject, error.localizedDescription] hideAfterDelay:10.f];
    }];
}

@end
