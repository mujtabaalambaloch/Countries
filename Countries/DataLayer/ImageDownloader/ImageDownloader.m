//
//  ImageDownloader.m
//  Countries
//
//  Created by Mujtaba Alam on 9/14/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

#import "ImageDownloader.h"
#import "UIImageView+WebCache.h"

@implementation ImageDownloader

- (void)imageURL:(NSURL *)url completed:(ImageCompleted)completion {
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:url
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
                                   completion(image);
                               } else {
                                   completion([UIImage imageNamed:@"NoImage"]);
                               }
                           }];
}

@end
