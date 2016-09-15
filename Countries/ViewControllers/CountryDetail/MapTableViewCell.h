//
//  MapTableViewCell.h
//  Countries
//
//  Created by Mujtaba Alam on 9/15/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
