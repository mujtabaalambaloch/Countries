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

@interface CountryDetailTableViewController () {
    CountryDetailViewModel *viewModel;
}

@end

@implementation CountryDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = @"Country Details";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [viewModel labelAtIndex:indexPath];
    cell.detailTextLabel.text = [viewModel valuesAtIndex:indexPath];
    
    return cell;
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
