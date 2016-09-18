//
//  Country.h
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Country : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString * name;
@property (nonatomic, copy, readonly) NSString * alpha2Code;
@property (nonatomic, copy, readonly) NSString * alpha3Code;
@property (nonatomic, copy, readonly) NSArray * callingCodes;
@property (nonatomic, copy, readonly) NSArray * currencies;
@property (nonatomic, copy, readonly) NSString * capital;
@property (nonatomic, copy, readonly) NSString * demonym;
@property (nonatomic, copy, readonly) NSArray * latlng;
@property (nonatomic, assign, readonly) NSInteger population;
@property (nonatomic, assign, readonly) NSInteger area;

@property (nonatomic, copy, readonly) NSArray * topLevelDomain;
@property (nonatomic, copy, readonly) NSArray * languages;
@property (nonatomic, copy, readonly) NSString * numericCode;

@end
