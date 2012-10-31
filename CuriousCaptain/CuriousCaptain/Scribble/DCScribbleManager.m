//
//  DCScribbleManager.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCScribbleManager.h"
#import "DCOpenScribbleCommand.h"

#define kScribbleDataPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"]
#define kScribbleThumbnailPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thumbnails"]

@interface DCScribbleManager ()

- (NSString *)scribbleDataPath;
- (NSString *)scribbleThumbnailPath;
- (NSArray *)scribbleDataPaths;
- (NSArray *)scribbleThumbnailPaths;

@end

@implementation DCScribbleManager

- (void)saveScribble:(DCScribble *)scribble thumbnail:(UIImage *)image {
    // get a new index for the new scribble data and its thumbnail
    NSInteger newIndex = [self numberOfScribbles] + 1;
    
    // use the index as part of the name for each of them
    NSString *scribbleDataName = [NSString stringWithFormat:@"data_%d", newIndex];
    NSString *scribbleThumbnailName = [NSString stringWithFormat:@"thumbnail_%d.png", newIndex];
    
    // get a memento from the scribble
    // then save the memento in the file system
    DCScribbleMemento *scribbleMemento = [scribble scribbleMemento];
    NSData *mementoData = [scribbleMemento data];
    NSString *mementoPath = [[self scribbleDataPath] stringByAppendingPathComponent:scribbleDataName];
    [mementoData writeToFile:mementoPath atomically:YES];
    
    // save the thumbnail directly in
    // the file system
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    NSString *imagePath = [[self scribbleThumbnailPath] stringByAppendingPathComponent:scribbleThumbnailName];
    [imageData writeToFile:imagePath atomically:YES];
}

- (NSInteger)numberOfScribbles {
    NSArray *scribbleDataPathsArray = [self scribbleDataPaths];
    return [scribbleDataPathsArray count];
}

- (DCScribble *)scribbleAtIndex:(NSInteger)index {
    DCScribble *loadedScribble = nil;
    NSArray *scribbleDataPathsArray = [self scribbleDataPaths];
    
    // load scribble data from the path indicated
    // by the index
    NSString *scribblePath = [scribbleDataPathsArray objectAtIndex:index];
    if (scribblePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *scribbleData = [fileManager contentsAtPath:[kScribbleDataPath stringByAppendingPathComponent:scribblePath]];
        DCScribbleMemento *scribbleMemento = [DCScribbleMemento mementoWithData:scribbleData];
        loadedScribble = [DCScribble scribbleWithMemento:scribbleMemento];
    }
    
    return loadedScribble;
}

- (UIView *)scribbleThumbnailViewAtIndex:(NSInteger)index {
    DCScribbleThumbnailViewImageProxy *loadedScribbleThumbnail = nil;
    NSArray *scribbleThumbnailPathsArray = [self scribbleThumbnailPaths];
    NSArray *scribblePathsArray = [self scribbleDataPaths];
    
    // load scribble thumbnail from the path indicated
    // by the index
    NSString *scribbleThumbnailPath = [scribbleThumbnailPathsArray objectAtIndex:index];
    NSString *scribblePath = [scribblePathsArray objectAtIndex:index];
    
    if (scribbleThumbnailPath) {
        // initialize an instance of ScribbleThumbnailProxy
        // with the exact location of the thumbnail in the file system
        loadedScribbleThumbnail = [[[DCScribbleThumbnailViewImageProxy alloc] init] autorelease];
        
        [loadedScribbleThumbnail setImagePath:[kScribbleThumbnailPath stringByAppendingPathComponent:scribbleThumbnailPath]];
        [loadedScribbleThumbnail setScribblePath:[kScribbleDataPath stringByAppendingPathComponent:scribblePath]];
        
        // assign a touch command to the scribble thumbnail
        // so it can be used to open a scribble by touch
        DCOpenScribbleCommand *touchCommand = [[[DCOpenScribbleCommand alloc] initWithScribbleSource:loadedScribbleThumbnail] autorelease];
        [loadedScribbleThumbnail setTouchCommand:touchCommand];
    }
    
    return loadedScribbleThumbnail;
}

#pragma mark Private Methods

- (NSString *)scribbleDataPath {
    // lazy create the scribble data directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kScribbleDataPath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:kScribbleDataPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    return kScribbleDataPath;
}


- (NSString *)scribbleThumbnailPath {
    // lazy create the scribble thumbnail directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kScribbleThumbnailPath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:kScribbleThumbnailPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    return kScribbleThumbnailPath;
}


- (NSArray *)scribbleDataPaths {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *scribbleDataPathsArray = [fileManager contentsOfDirectoryAtPath:[self scribbleDataPath] error:&error];
    
    return scribbleDataPathsArray;
}


- (NSArray*)scribbleThumbnailPaths {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *scribbleThumbnailPathsArray = [fileManager contentsOfDirectoryAtPath:[self scribbleThumbnailPath] error:&error];
    return scribbleThumbnailPathsArray;
}
@end
