//
//  ViewController.h
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)showProgressHUDWithTitle:(NSString *)title detail:(NSString *)detail hideAfterDelay:(NSTimeInterval)delay;
- (void)showProgressHUDWithTitle:(NSString *)title detail:(NSString *)detail;
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay;
- (void)hideProgressHUD;

@end
