//
//  AsyncableImageView.m
//  ETAsyncableImageView
//
//  Created by plb-fueled on 6/4/13.
//  Copyright (c) 2013 fueled.co. All rights reserved.
//

#import "AsyncableImageView.h"
#import "ImageLoader.h"

@interface AsyncableImageView()

@property(nonatomic, strong) UIImage *maskImage;
@property(nonatomic, strong) ImageLoader *imageLoader;
-(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end

@implementation AsyncableImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect rect = activity.frame;
        rect.origin.x = (self.frame.size.width - rect.size.width)/2;
        rect.origin.y = (self.frame.size.height - rect.size.height)/2;
        activity.frame = rect;
        activity.hidden = YES;
        [self addSubview:activity];
        _imageLoader = [[ImageLoader alloc]init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect rect = activity.frame;
        rect.origin.x = (self.frame.size.width - rect.size.width)/2;
        rect.origin.y = (self.frame.size.height - rect.size.height)/2;
        activity.frame = rect;
        activity.hidden = YES;
        [self addSubview:activity];
        _imageLoader = [[ImageLoader alloc]init];
    }
    return self;
}

-(void)showImageFromURL:(NSString *)url{
    [self showImageFromURL:url withMaskImage:nil];
}

-(void)showImageFromURL:(NSString *)url withMaskImage:(UIImage *)maskImage{
    self.maskImage = maskImage;
    self.image = [UIImage imageWithContentsOfFile:url];
    
    if (self.image) {
        [self imageLoaded];
    }
    else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageLoaded) name:@"IMAGE_DOWNLOADED" object:self.imageLoader];
        [self.imageLoader loadImageWithURL:url ForImageView:self];
        if (!self.image) {
            activity.hidden = NO;
            [activity startAnimating];
        }
    }
}

-(void)imageLoaded{
    
    activity.hidden = YES;
    [activity stopAnimating];
    

    
    if ([delegate respondsToSelector:@selector(imageLoadingFinished)]) {
        [delegate imageLoadingFinished];
    }
    
}

-(void)imageLoadingFailed{
    
    activity.hidden = YES;
    [activity stopAnimating];
    
    //self.image = [UIImage imageNamed:@"broken-image.png"];
    
    if ([delegate respondsToSelector:@selector(imageLoadingFinished)]) {
        [delegate imageLoadingFinished];
    }
    
    
}

-(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
	CGImageRef maskRef = maskImage.CGImage;
	CGImageRef imageRef = image.CGImage;
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    
	CGImageRef masked = CGImageCreateWithMask(imageRef, mask);
    UIImage *img = [UIImage imageWithCGImage:masked];
    
    CFRelease(masked);
    CFRelease(mask);
    
	return img;
    
}

@end
