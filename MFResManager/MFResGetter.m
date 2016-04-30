/*--------------------------------------------------------------------------*/
/*   /\/\/\__/\/\/\        MooseFactory Foundation - v1.0.0                    */
/*   \/\/\/..\/\/\/                                                         */
/*        |  |             (c)2007-2016 Tristan Leblanc                     */
/*        (oo)             tristan@moosefactory.eu                          */
/* MooseFactory Software                                                    */
/*--------------------------------------------------------------------------*/

/*
 Copyright (c) 2016 Tristan Leblanc - MooseFactory Software <tristan@moosefactory.eu>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */



#import "MFResGetter.h"

#import "MFResCache.h"

static NSArray* imageTypes;
static NSArray* videoTypes;
static NSArray* audioTypes;

@implementation MFResGetter

#pragma mark - Init

+(instancetype)defaultMediaGetter
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        imageTypes = [NSArray arrayWithObjects:@"png",@"PNG",@"jpg",@"JPG",@"jpeg",@"JPEG",@"tif",@"TIF",@"tiff",@"TIFF",NULL];
        videoTypes = [NSArray arrayWithObjects:@"mp4",@"MP4",@"m4v",@"M4V",@"avi",@"AVI",@"mpeg4",@"MPEG4",NULL];
        audioTypes = [NSArray arrayWithObjects:@"mp3",@"MP3",@"aif",@"AIF",@"aiff",@"AIFF",NULL];
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.bundle = [NSBundle mainBundle];
        self.defaultImageName = @"missing_image";
        self.behavior = MFResGetterSearchRoot;
    }
    return self;
}

#pragma mark - Path and URL Methods

+(NSURL*)fileURLWithPath:(NSString*)path
{
    return [[MFResGetter defaultMediaGetter] fileURLWithPath:path];
}

-(NSURL*)fileURLWithPath:(NSString*)path
{
    return [self fileURLWithPath:path log:YES];
}


+(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type
{
    return [[MFResGetter defaultMediaGetter] pathForResource:name ofType:type];
}

-(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type
{
    NSString* path = [self.bundle pathForResource:name ofType:type inDirectory:self.baseDirectoryPath];
    if (!path && MFResSearchRoot) {
        path = [self.bundle pathForResource:name ofType:type];
    }
    if (!path && MFResLog ) {
        MFRLog(@"Missing Ressource In Bundle '%@' - File : %@",self.bundle.bundleIdentifier,
               [NSString stringWithFormat:@"%@/%@.%@",self.baseDirectoryPath ? self.baseDirectoryPath : @"", name, type]);
        if ( MFResBreaks ) {
            assert(path);
        }
    }
    return path;
}


#pragma mark - Image Loading

+(UIImage*)imageNamed:(NSString*)name
{
    return [[MFResGetter defaultMediaGetter] imageNamed:name];
}

+(UIImage*)imageWithPath:(NSString*)path
{
    return [[MFResGetter defaultMediaGetter] imageWithPath:path];
}


-(UIImage*)imageNamed:(NSString*)name
{
    UIImage *image=NULL;
    for (NSString* fileType in imageTypes) {
        image = [self imageWithPath:[NSString stringWithFormat:@"%@.%@",name,fileType] log:NO returnsDefault:NO];
        if (image) break;
    }
    if ( !image && MFResSearchRoot ) {
        for (NSString* fileType in imageTypes) {
            image = [self imageWithPath:[NSString stringWithFormat:@"/%@.%@",name,fileType] log:NO returnsDefault:NO];
            if (image) break;
        }
    }
    if ( !image && MFResLog ) {
        MFRFileLog( MFResFileLog ? @"MissingImages.log" : NULL, @"Missing Image In Bundle '%@' - File : %@",self.bundle.bundleIdentifier, [NSString stringWithFormat:@"%@",name]);
        if ( MFResBreaks ) {
            assert(image);
        }
    }

    if ( !image && MFResUseDefault ) {
        image = [self defaultImage];
    }
    return image;
}

-(UIImage*)imageWithPath:(NSString*)path
{
    return [self imageWithPath:path log:YES  returnsDefault:NO];
}

#pragma mark Private Methods

// No Log Methods

-(UIImage*)imageWithPath:(NSString*)path log:(BOOL)log returnsDefault:(BOOL)returnsDefault
{
    UIImage* image = (UIImage*)[MFResCache cachedResourceWithPath:path];
    if (!image) {
        NSURL* imageURL = [self fileURLWithPath:path log:log];
        if (imageURL) {
            NSData* imageData = [NSData dataWithContentsOfFile:imageURL.path];
            if (imageData) {
                image = [UIImage imageWithData:imageData];
            }
            if ( image ) {
                if (image != [self defaultImage]) {
                    [MFResCache cacheResource:image withPath:path];
                }
            } else if ( MFResUseDefault && returnsDefault) {
                image = [self defaultImage];
            }
        }
    }
    return image;
}

-(NSURL*)fileURLWithPath:(NSString*)path log:(BOOL)log
{
    if (log && !path && MFResLog ) {
        MFRLog(@"ERROR - fileURLWithPath - Path is NULL");
        if ( MFResBreaks ) {
            assert(path);
        }
        return NULL;
    }
    
    NSString* firstChar = [path substringToIndex:1];
    NSString* finalPath = NULL;
    if ([firstChar isEqualToString:@"/"]) {
        path = finalPath = [path substringFromIndex:1];
    } else {
        finalPath = self.baseDirectoryPath ? [self.baseDirectoryPath stringByAppendingPathComponent:path] : path;
    }
    
    NSString* bundlePath = [self.bundle.bundlePath stringByAppendingPathComponent:finalPath];
    NSURL* url = [NSURL fileURLWithPath:bundlePath];
    
    if (!url && MFResSearchRoot && ![path isEqualToString:finalPath]) {
        bundlePath = [self.bundle.bundlePath stringByAppendingPathComponent:path];
        url = [NSURL fileURLWithPath:bundlePath];
    }
    
    if ( log && MFResLog && !url) {
        MFRFileLog(@"ResGetter.log",@"ERROR - fileURLWithPath - URL is NULL for Path \"%@\"",path);
        if ( MFResBreaks ) {
            assert(url);
        }
    }
    
    return url;
}

// Default Image

-(UIImage*)defaultImage
{
    if (!_defaultImage) {
        UIImage* image = [UIImage imageNamed:self.defaultImageName];
        if ( !image && MFResLog ) {
            MFRFileLog( MFResFileLog ? @"MissingImages.log" : NULL, @"Missing Default \"%@\" In Bundle '%@'",self.defaultImageName,self.bundle.bundleIdentifier);
            if ( MFResBreaks ) {
                assert(image);
            }
        }
        self.defaultImage = image;
    }
    return _defaultImage;
}

+(void)clearCache
{
    [MFResCache clearCache];
}

@end
