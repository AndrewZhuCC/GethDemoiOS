//
//  GethClient.h
//  GethScroeDemo
//
//  Created by 朱安智 on 2017/2/15.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface GethClient : AFHTTPSessionManager

@property (nonatomic, copy, readonly) NSString * _Nullable userID;

+ (nonnull GethClient *)instance;

- (nullable NSURLSessionDataTask *)requestLoginWithUsername:(nonnull NSString *)username
                                                   password:(nonnull NSString *)password
                                                    success:(nonnull void (^)(NSURLResponse * _Nonnull response, NSString * _Nonnull userID))success
                                                       fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail;

- (nullable NSURLSessionDataTask *)requestConsumeWithCost:(NSInteger)cost
                                                  success:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject))success
                                                     fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail;

- (nullable NSURLSessionDataTask *)requestGetScoreSuccess:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSInteger score))success
                                                     fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail;

- (nullable NSURLSessionDataTask *)requestUseScoreWithCost:(NSInteger)cost
                                                   success:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject))success
                                                      fail:(nonnull void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))fail;

@end

#define GethClientInstance [GethClient instance]
