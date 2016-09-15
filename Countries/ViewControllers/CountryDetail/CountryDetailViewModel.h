//
//  CountryDetailViewModel.h
//  Countries
//
//  Created by Mujtaba Alam on 9/15/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryDetailViewModel : NSObject

typedef void (^Completion)(BOOL success);

#pragma mark - API Methods
- (void)apiRequestCountryDetailCode:(NSString *)code complete:(Completion)completion;

#pragma mark - Table Data Methods
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)labelAtIndex:(NSIndexPath *)indexPath;
- (NSString *)valuesAtIndex:(NSIndexPath *)indexPath;

@end
