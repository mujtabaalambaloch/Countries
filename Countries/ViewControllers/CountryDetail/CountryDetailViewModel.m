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
        
        labelsArray = @[@"Capital", @"Population",@"Calling Code", @"Currencies", @"Top Domains", @"Alpha Codes", @"Languages", @"Numeric Code"];
        
        NSString *population = [NSNumberFormatter localizedStringFromNumber:@(countryModel.population) numberStyle:NSNumberFormatterDecimalStyle];
        
        NSString *callingCode = [NSString stringWithFormat:@"+%@",countryModel.callingCodes[0]];
        
        NSMutableString *currencies = [[NSMutableString alloc] init];
        
        for (NSInteger i = 0; i < countryModel.currencies.count; i++) {
            
            if (i == 0) {
                [currencies appendString:countryModel.currencies[i]];
            } else {
                [currencies appendString:@","];
                [currencies appendString:countryModel.currencies[i]];
            }
        }
        
        NSMutableString *domains = [[NSMutableString alloc] init];
        
        for (NSInteger i = 0; i < countryModel.topLevelDomain.count; i++) {
            
            if (i == 0) {
                [domains appendString:countryModel.topLevelDomain[i]];
            } else {
                [domains appendString:@","];
                [domains appendString:countryModel.topLevelDomain[i]];
            }
        }
        
        
        NSMutableString *lang = [[NSMutableString alloc] init];
        
        for (NSInteger i = 0; i < countryModel.languages.count; i++) {
            
            if (i == 0) {
                [lang appendString:countryModel.languages[i]];
            } else {
                [lang appendString:@","];
                [lang appendString:countryModel.languages[i]];
            }
        }
        
        NSString *alphaCodes = [NSString stringWithFormat:@"%@, %@", countryModel.alpha2Code, countryModel.alpha3Code];
        
        valuesArray = @[countryModel.capital,population,callingCode, currencies, domains, alphaCodes, lang, countryModel.numericCode];
    }
}

#pragma mark - Table Data Methods

- (NSInteger)numberOfSections {
    return 3;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return 1;
    }
    
    return valuesArray.count;
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

- (MKCoordinateRegion)mapRegion {
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [countryModel.latlng[0] floatValue];
    zoomLocation.longitude= [countryModel.latlng[1] floatValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, countryModel.area, countryModel.area);
    
    return viewRegion;
}

- (MKPointAnnotation *)mapAnnotation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([countryModel.latlng[0] floatValue], [countryModel.latlng[1] floatValue]);
    annotation.title = countryModel.name;
    return annotation;
}

//Section - 2

- (NSString *)labelAtIndex:(NSIndexPath *)indexPath {
    return labelsArray[indexPath.row];
}

- (NSString *)valuesAtIndex:(NSIndexPath *)indexPath {
    return valuesArray[indexPath.row];
}

@end
