//
//  Network.h
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject

typedef void (^CompletionHandler)(BOOL success, NSDictionary *response, NSError *error);

#pragma mark - Get Request

- (void)getRequestURL:(NSString *)url params:(NSDictionary *)params completion:(CompletionHandler)completion;

@end
