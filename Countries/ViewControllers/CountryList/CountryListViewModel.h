//
//  CountryListViewModel.h
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryListViewModel : NSObject

typedef void (^Completion)(BOOL success);
typedef void(^Completed)(UIImage *image);

#pragma mark - API Methods
- (void)apiRequestAllCountries:(Completion)completion;

#pragma mark - Table Data Methods
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSArray *)sectionIndexTitles;
- (NSString *)countryNameAtIndex:(NSIndexPath *)indexPath;
- (NSURL *)countryImageURLAtIndex:(NSIndexPath *)indexPath;
- (NSString *)countryCodeAtIndex:(NSIndexPath *)indexPath;

@end
