//
//  DiskCache.h
//  ETAsyncableImageView
//
//  Created by sah-fueled on 04/06/13.
//  Copyright (c) 2013 fueled.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoryCache.h"

typedef enum {
  FileDeletionTypeNone = 0,
  FileDeletionTypeSize,
  FileDeletionTypeTime
} FileDeletionType;

@interface DiskCache : NSObject

-(void)setCache:(NSData *)data forKey:(NSString *)key;

-(NSData *)getCacheForKey:(NSString *)key;

- (void)getImageForKey:(NSString *)key forView:(UIImageView *)imageView;

- (void)setFileDeletionType:(FileDeletionType) deletionType;

- (unsigned long long int) diskCacheFolderSize;

@property (nonatomic, weak)MemoryCache *memoryCache;

@end
