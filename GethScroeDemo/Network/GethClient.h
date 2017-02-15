//
//  GethClient.h
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface GethClient : AFHTTPSessionManager

- (GethClient *)instance;

@end
