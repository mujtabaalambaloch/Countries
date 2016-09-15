//
//  CountryListViewModel.m
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "CountryListViewModel.h"
#import "Network.h"
#import "APIConstants.h"
#import "Country.h"
#import "ImageConstants.h"

@interface CountryListViewModel () {
    NSMutableDictionary *countries;
    NSArray *countrySectionTitles;
}

@end

@implementation CountryListViewModel



#pragma mark - API Methods

- (void)apiRequestAllCountries:(Completion)completion {
    
    NSString *request = [NSString stringWithFormat:@"%@%@",BaseURL,AllCountries];
    
    Network *network = [[Network alloc] init];
    [network getRequestURL:request params:nil completion:^(BOOL success, NSDictionary *response, NSError *error) {
        
        if (success) {
            if (response.count > 0) {
                [self sectionsIndexing:response];
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

- (void)sectionsIndexing:(NSDictionary *)response {
    
    NSMutableArray *tempModelArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempLetterArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in response) {
        NSError *error = nil;
        Country *countryModel = [MTLJSONAdapter modelOfClass:Country.class fromJSONDictionary:dict error:&error];
        
        if (countryModel.callingCodes.count > 0) {
            
            if (![countryModel.callingCodes[0] isEqualToString:@""] && countryModel.population > 0) {
                [tempModelArray addObject:countryModel];
                
                NSString *firstLetter = [[countryModel.name substringToIndex:1] uppercaseString];
                
                if (![tempLetterArray containsObject:firstLetter]) {
                    [tempLetterArray addObject:firstLetter];
                }
            }
        }
    }
    
    NSArray *sortedLetters = [tempLetterArray sortedArrayUsingSelector:@selector(compare:)];
    
    countries = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < tempLetterArray.count; i++) {
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        for (NSInteger j = 0; j < tempModelArray.count; j++) {
            Country *model = (Country *)tempModelArray[j];
            
            NSString *letter = [[model.name substringToIndex:1] uppercaseString];
            if ([sortedLetters[i] isEqualToString:letter]) {
                [tempArray addObject:model];
                [countries setObject:tempArray forKey:letter];
            }
        }
    }
    
    countrySectionTitles = [[countries allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Country Model - Method

- (Country *)countryModelAtIndex:(NSIndexPath *)indexPath {
    NSArray *sectionCountries = [countries objectForKey:countrySectionTitles[indexPath.section]];
    return (Country *)sectionCountries[indexPath.row];
}

#pragma mark - Table Data Methods

- (NSInteger)numberOfSections {
    return countries.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionCountries = [countries objectForKey:countrySectionTitles[section]];
    return sectionCountries.count;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return countrySectionTitles[section];
}

- (NSArray *)sectionIndexTitles {
    return countrySectionTitles;
}

- (NSString *)countryNameAtIndex:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%@ (+%@)", [self countryModelAtIndex:indexPath].name, [self countryModelAtIndex:indexPath].callingCodes[0]];
}

- (NSURL *)countryImageURLAtIndex:(NSIndexPath *)indexPath {
    NSString *imageURL = [NSString stringWithFormat:ImageBaseURL,[self countryModelAtIndex:indexPath].alpha2Code];
    return [NSURL URLWithString:imageURL];
}

- (NSString *)countryCodeAtIndex:(NSIndexPath *)indexPath {
    return [self countryModelAtIndex:indexPath].alpha2Code;
}

@end
