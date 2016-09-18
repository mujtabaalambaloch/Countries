//
//  CountryListTableViewController.m
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "CountryListTableViewController.h"
#import "CountryListViewModel.h"
#import "CountryListCell.h"
#import "UIImageView+WebCache.h"
#import "CountryDetailTableViewController.h"
#import "Activity.h"

@interface CountryListTableViewController () {
    CountryListViewModel *viewModel;
    BOOL isLoadingAPI;
}

@end

@implementation CountryListTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    viewModel = [[CountryListViewModel alloc] init];
    [self apiRequest];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(apiRequest)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([viewModel shouldReloadAPI] && !isLoadingAPI) {
        [self apiRequest];
    }
}

#pragma mark - API Request

- (void)apiRequest {
    
    isLoadingAPI = TRUE;
    
    if (!self.refreshControl) {
        [Activity showLoadingIndicator];
    } else {
        self.tableView.userInteractionEnabled = FALSE;
    }
    
    [viewModel apiRequestAllCountries:^(BOOL success) {
        [Activity hideLoadingIndicator];
        isLoadingAPI = FALSE;
        
        self.tableView.userInteractionEnabled = TRUE;
        if (self.refreshControl) {
            [self.refreshControl endRefreshing];
        }
        
        if (success) {
            [viewModel setRefreshAPI];
            [self.tableView reloadData];
        } else {
            [self alertControllerRetry];
        }
    }];
}

#pragma mark - Alert Controller 

- (void)alertControllerRetry {
    
    UIAlertController *alert = [UIAlertController
                                  alertControllerWithTitle:@"No Data"
                                  message:@"Unable to get data, please retry again"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Retry"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             [self apiRequest];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [viewModel numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [viewModel titleForHeaderInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [viewModel sectionIndexTitles];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor darkGrayColor];
    header.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    header.backgroundView.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.nameLabel.text = [viewModel countryNameAtIndex:indexPath];
    
    [cell.flagImageView sd_setImageWithURL:[viewModel countryImageURLAtIndex:indexPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error) {
            cell.flagImageView.image = [UIImage imageNamed:@"NoImage"];
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"CountryDetail" sender:indexPath];
}

 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     NSIndexPath *indexPath = (NSIndexPath *)sender;
     NSString *code = [viewModel countryCodeAtIndex:indexPath];
     
     if ([segue.identifier isEqualToString:@"CountryDetail"] && ![code isEqualToString:@""]) {
         CountryDetailTableViewController *details = (CountryDetailTableViewController *)segue.destinationViewController;
         details.countryCode = code;
     }
}

@end
