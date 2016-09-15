//
//  Country.m
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "Country.h"

@implementation Country

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"alpha2Code": @"alpha2Code",
             @"alpha3Code": @"alpha3Code",
             @"callingCodes":@"callingCodes",
             @"capital": @"capital",
             @"demonym": @"demonym",
             @"latlng":@"latlng",
             @"population": @"population",
             @"area":@"area",
             @"currencies":@"currencies"
             };
}

+ (NSValueTransformer *)areaJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
       
        if (value == nil) {
            return [NSNumber numberWithInteger:10000];
        } else {
            return value;
        }
    }];
}

@end
