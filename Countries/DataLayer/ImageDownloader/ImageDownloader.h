//
//  ImageDownloader.h
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownloader : NSObject

typedef void(^ImageCompleted)(UIImage *image);

- (void)imageURL:(NSURL *)url completed:(ImageCompleted)completion;

@end
