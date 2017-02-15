//
//  ViewController.m
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "ViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@property (nonatomic, strong) MBProgressHUD *baseHud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showProgressHUDWithTitle:(NSString *)title detail:(NSString *)detail hideAfterDelay:(NSTimeInterval)delay {
    if (title || detail) {
        self.baseHud.mode = MBProgressHUDModeText;
    } else {
        self.baseHud.mode = MBProgressHUDModeIndeterminate;
    }
    
    self.baseHud.label.text = title;
    self.baseHud.detailsLabel.text = detail;
    [self.baseHud showAnimated:YES];
    if (delay > 0.f) {
        [self.baseHud hideAnimated:YES afterDelay:delay];
    }
}

- (void)showProgressHUDWithTitle:(NSString *)title detail:(NSString *)detail {
    [self showProgressHUDWithTitle:title detail:detail hideAfterDelay:0.f];
}

- (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay {
    if (delay > 0.f) {
        [self.baseHud hideAnimated:YES afterDelay:delay];
    } else {
        [self.baseHud hideAnimated:YES];
    }
}

- (void)hideProgressHUD {
    [self hideProgressHUDAfterDelay:0.f];
}

#pragma mark - Property

- (MBProgressHUD *)baseHud {
    if (!_baseHud) {
        _baseHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_baseHud];
    }
    return _baseHud;
}

@end
