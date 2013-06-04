//
//  ImageDownloader.h
//  ETAsyncableImageView
//
//  Created by plb-fueled on 6/4/13.
//  Copyright (c) 2013 fueled.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSOperation

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;
- (id)initWithURL:(NSString *)url ImageView:(UIImageView *)imageView delegate:(id<ImageDownloaderDelegate>)delegate;

@end

@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;

@end
