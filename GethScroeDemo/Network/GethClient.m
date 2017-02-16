//
//  GethClient.m
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#define ServerAddress @"http://172.27.15.183:8080"

#import "GethClient.h"

@interface GethClient ()

@property (nonatomic, copy) NSString *userID;

@end

@implementation GethClient

+ (GethClient *)instance {
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
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 15.f;
    }
    return self;
}

- (nullable NSURLSessionDataTask *)requestWithURL:(nonnull NSString *)url
                                  method:(nonnull NSString *)method
                              parameters:(nullable NSDictionary *)param
                                 success:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject))success
                                    fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSURLSessionDataTask *task = nil;
    NSError *error = nil;
    NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[self.baseURL URLByAppendingPathComponent:url].absoluteString parameters:param error:&error];
    if (error) {
        NSLog(@"request error:%@", error);
        return nil;
    }
    task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (fail) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    fail(response, responseObject, error);
                });
            }
        } else {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(response, responseObject);
                });
            }
        }
    }];
    [task resume];
    return task;
}

- (nullable NSURLSessionDataTask *)requestRegisterWithUsername:(nonnull NSString *)username
                                                      password:(nonnull NSString *)password
                                                       success:(nonnull void (^)(NSURLResponse * _Nonnull response, NSString * _Nonnull userID))success
                                                          fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSDictionary *param = @{
                            @"username" : username,
                            @"password" : password,
                            };
    return [self requestWithURL:@"register" method:@"POST" parameters:param success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        NSString *userid = [responseObject objectForKey:@"userid"];
        BOOL bools = [[responseObject objectForKey:@"success"] boolValue];
        if (bools) {
            if (userid) {
                self.userID = userid;
                if (success) {
                    success(response, userid);
                }
            } else {
                if (fail) {
                    fail(response, responseObject, nil);
                }
            }
        } else {
            if (fail) {
                fail(response, responseObject, nil);
            }
        }
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (fail) {
            fail(response, responseObject, error);
        }
    }];
}


- (nullable NSURLSessionDataTask *)requestLoginWithUsername:(nonnull NSString *)username
                                          password:(nonnull NSString *)password
                                           success:(nonnull void (^)(NSURLResponse * _Nonnull response, NSString * _Nonnull userID))success
                                              fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSDictionary *param = @{
                            @"username" : username,
                            @"password" : password,
                            };
    return [self requestWithURL:@"login" method:@"POST" parameters:param success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        NSString *userid = [responseObject objectForKey:@"userid"];
        if (userid) {
            self.userID = userid;
            if (success) {
                success(response, userid);
            }
        } else {
            if (fail) {
                fail(response, responseObject, nil);
            }
        }
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (fail) {
            fail(response, responseObject, error);
        }
    }];
}

- (nullable NSURLSessionDataTask *)requestConsumeWithCost:(NSInteger)cost
                                                  success:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject))success
                                                     fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSDictionary *param = @{
                            @"userid" : self.userID,
                            @"cost"   : @(cost),
                            };
    return [self requestWithURL:@"consume" method:@"POST" parameters:param success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        BOOL bools = [[responseObject objectForKey:@"success"] boolValue];
        NSString *userid = [responseObject objectForKey:@"userid"];
        if (bools && [userid isEqualToString:self.userID]) {
            if (success) {
                success(response, responseObject);
            }
        } else {
            if (fail) {
                fail(response, responseObject, nil);
            }
        }
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (fail) {
            fail(response, responseObject, error);
        }
    }];
}

- (nullable NSURLSessionDataTask *)requestGetScoreSuccess:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSInteger score))success
                                                     fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSDictionary *param = @{
                            @"userid" : self.userID,
                            };
    return [self requestWithURL:@"getScore" method:@"GET" parameters:param success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        NSString *userid = [responseObject objectForKey:@"userid"];
        NSInteger score = [[responseObject objectForKey:@"score"] integerValue];
        if ([userid isEqualToString:self.userID]) {
            if (success) {
                success(response, responseObject, score);
            }
        } else {
            if (fail) {
                fail(response, responseObject, nil);
            }
        }
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (fail) {
            fail(response, responseObject, error);
        }
    }];
}

- (nullable NSURLSessionDataTask *)requestUseScoreWithCost:(NSInteger)cost
                                                   success:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject))success
                                                      fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail {
    NSDictionary *param = @{
                            @"userid" : self.userID,
                            @"cost"   : @(cost),
                            };
    return [self requestWithURL:@"useScore" method:@"POST" parameters:param success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        BOOL bools = [[responseObject objectForKey:@"success"] boolValue];
        NSString *userid = [responseObject objectForKey:@"userid"];
        if (bools && [userid isEqualToString:self.userID]) {
            if (success) {
                success(response, responseObject);
            }
        } else {
            if (fail) {
                fail(response, responseObject, nil);
            }
        }
    } fail:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (fail) {
            fail(response, responseObject, error);
        }
    }];
}

@end
