//
//  FunctionViewController.m
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/16.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "FunctionViewController.h"
#import "GethClient.h"

@interface FunctionViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfConsume;
@property (nonatomic, weak) IBOutlet UITextField *tfConsumeScore;
@property (nonatomic, weak) IBOutlet UITextField *tfTransAccount;
@property (nonatomic, weak) IBOutlet UITextField *tfTransScore;
@property (nonatomic, weak) IBOutlet UITextField *tfScore;

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.viewControllers = @[self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)consumeButtonTapped:(id)sender {
    NSInteger cost = [self.tfConsume.text integerValue];
    if (cost <= 0) {
        [self showProgressHUDWithTitle:@"金额有误" detail:nil hideAfterDelay:5.f];
        return;
    }
    
    [self showProgressHUDWithTitle:nil detail:nil];
    [GethClientInstance requestConsumeWithCost:cost success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        [self showProgressHUDWithTitle:@"消费成功" detail:[NSString stringWithFormat:@"消费 %@ 元", @(cost)] hideAfterDelay:3.f];
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self showProgressHUDWithTitle:@"消费失败" detail:[NSString stringWithFormat:@"obj:%@ error:%@", responseObject, error.localizedDescription] hideAfterDelay:5.f];
    }];
}

- (IBAction)consumeScoreButtonTapped:(id)sender {
    NSInteger cost = [self.tfConsumeScore.text integerValue];
    if (cost <= 0) {
        [self showProgressHUDWithTitle:@"输入积分数量有误" detail:nil hideAfterDelay:5.f];
        return;
    }
    
    [self showProgressHUDWithTitle:nil detail:nil];
    [GethClientInstance requestUseScoreWithCost:cost success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        [self showProgressHUDWithTitle:@"消费积分成功" detail:[NSString stringWithFormat:@"消费积分 %@", @(cost)] hideAfterDelay:3.f];
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self showProgressHUDWithTitle:@"消费积分失败" detail:[NSString stringWithFormat:@"obj:%@ error:%@", responseObject, error] hideAfterDelay:5.f];
    }];
}

- (IBAction)transferButtonTapped:(id)sender {
    
}

- (IBAction)getScoreButtonTapped:(id)sender {
    [self showProgressHUDWithTitle:nil detail:nil];
    [GethClientInstance requestGetScoreSuccess:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSInteger score) {
        self.tfScore.text = [@(score) stringValue];
        [self hideProgressHUD];
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self showProgressHUDWithTitle:@"查询积分失败" detail:[NSString stringWithFormat:@"obj:%@ error%@", responseObject, error] hideAfterDelay:5.f];
    }];
}

@end
