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
             @"population": @"population"
             };
}

@end
