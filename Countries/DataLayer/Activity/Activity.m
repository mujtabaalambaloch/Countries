//
//  Activity.m
//  Countries
//
//  Created by Mujtaba Alam on 9/15/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "Activity.h"
#import "MBProgressHUD.h"

@implementation Activity

#pragma mark - MBProgressHUD Show/Hide

+ (void)showLoadingIndicator {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = @"Loading...";
}

+ (void)hideLoadingIndicator {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
