//
//  Network.m
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "Network.h"
#import <AFNetworking/AFNetworking.h>

@implementation Network

#pragma mark - Get Request

- (void)getRequestURL:(NSString *)url params:(NSDictionary *)params completion:(CompletionHandler)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(FALSE, nil, error);
        } else {
            completion(TRUE, responseObject, nil);
        }
    }];
    [dataTask resume];
}

@end
