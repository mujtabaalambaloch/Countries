//
//  CountryDetailTableViewController.m
//  Countries
//
//  Created by Mujtaba Alam on 9/15/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "CountryDetailTableViewController.h"
#import "CountryDetailViewModel.h"
#import "Activity.h"
#import "FlagTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CountryDetailTableViewController () {
    CountryDetailViewModel *viewModel;
}

@end

@implementation CountryDetailTableViewController

static NSString *const FlagCell = @"FlagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = @"Country Details";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FlagTableViewCell" bundle:nil] forCellReuseIdentifier:FlagCell];
    
    viewModel = [[CountryDetailViewModel alloc] init];
    [Activity showLoadingIndicator];
    [viewModel apiRequestCountryDetailCode:_countryCode complete:^(BOOL success) {
        [Activity hideLoadingIndicator];
        if (success) {
            [self.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
       FlagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FlagCell forIndexPath:indexPath];
        
        cell.countryNameLabel.text = [viewModel countryName];
        
        [cell.flagImageView sd_setImageWithURL:[viewModel countryImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (error) {
                cell.flagImageView.image = [UIImage imageNamed:@"NoImage"];
            }
        }];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        cell.textLabel.text = [viewModel labelAtIndex:indexPath];
        cell.detailTextLabel.text = [viewModel valuesAtIndex:indexPath];
        
        return cell;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
