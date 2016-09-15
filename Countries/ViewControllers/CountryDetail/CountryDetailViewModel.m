//
//  CountryDetailViewModel.m
//  Countries
//
//  Created by Mujtaba Alam on 9/15/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "CountryDetailViewModel.h"
#import "Network.h"
#import "APIConstants.h"
#import "Country.h"
#import "ImageConstants.h"

@interface CountryDetailViewModel () {
    Country *countryModel;
    NSArray *labelsArray;
    NSArray *valuesArray;
}

@end

@implementation CountryDetailViewModel

#pragma mark - API Methods
- (void)apiRequestCountryDetailCode:(NSString *)code complete:(Completion)completion {
    
    NSString *request = [NSString stringWithFormat:@"%@%@%@",BaseURL,CountryDetails, code];
    
    Network *network = [[Network alloc] init];
    [network getRequestURL:request params:nil completion:^(BOOL success, NSDictionary *response, NSError *error) {
        
        if (success) {
            if (response.count > 0) {
                [self countryDetails:response];
                completion(TRUE);
            } else {
                completion(FALSE);
            }
        } else {
            completion(FALSE);
        }
    }];
    
}

#pragma mark - Table Logic

- (void)countryDetails:(NSDictionary *)response {
    
    for (NSDictionary *dict in response) {
        NSError *error = nil;
        countryModel = [MTLJSONAdapter modelOfClass:Country.class fromJSONDictionary:dict error:&error];
        
        labelsArray = @[@"Capital", @"Population",@"Calling Code", @"Alpha Code"];
        
        NSString *population = [NSNumberFormatter localizedStringFromNumber:@(countryModel.population) numberStyle:NSNumberFormatterDecimalStyle];
        
        NSString *callingCode = [NSString stringWithFormat:@"+%@",countryModel.callingCodes[0]];
        
        valuesArray = @[countryModel.capital,population, callingCode, countryModel.alpha2Code];
    }
}

#pragma mark - Table Data Methods



- (NSInteger)numberOfSections {
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return labelsArray.count;
}

//Section - 0

- (NSString *)countryName {
    return countryModel.name;
}

- (NSURL *)countryImageURL {
    NSString *imageURL = [NSString stringWithFormat:ImageBaseURL,countryModel.alpha2Code];
    return [NSURL URLWithString:imageURL];
}

//Section - 1

- (NSString *)labelAtIndex:(NSIndexPath *)indexPath {
    return labelsArray[indexPath.row];
}

- (NSString *)valuesAtIndex:(NSIndexPath *)indexPath {
    return valuesArray[indexPath.row];
}




@end
