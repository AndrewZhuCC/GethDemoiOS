//
//  GethClient.m
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#define ServerAddress @"http://"

#import "GethClient.h"

@implementation GethClient

- (GethClient *)instance {
    static GethClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[GethClient alloc] initWithBaseURL:[NSURL URLWithString:ServerAddress]];
    });
    return client;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.timeoutInterval = 15.f;
    }
    return self;
}

- (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  method:(NSString *)method
                              parameters:(NSDictionary *)param {
    NSURLSessionDataTask *task = nil;
    NSError *error = nil;
    NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[self.baseURL URLByAppendingPathComponent:url].absoluteString parameters:param error:&error];
    if (error) {
        NSLog(@"request error:%@", error);
        return nil;
    }
    task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)requestLoginWithUsername:(NSString *)username
                                          password:(NSString *)password {
    return [self requestWithURL:@"/login" method:@"POST" parameters:@{@"username":username, @"password":password}];
}

@end
