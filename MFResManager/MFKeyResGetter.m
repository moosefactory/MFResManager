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


#import "MFKeyResGetter.h"


@implementation MFKeyResGetter
{
    NSDictionary*   mediasDictionary;
}

#pragma mark - Init

+(instancetype)defaultKeyMediaGetter
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init {
    if (self = [super init]) {
        mediasDictionary = [NSDictionary dictionaryWithContentsOfFile:[self mediasDictionaryPath]];
    }
    return self;
}

#pragma mark - Properties

-(NSString*)mediasDictionaryPath
{
    NSString* path = [self.bundle pathForResource:@"medias" ofType:@"plist"];
#if DEBUG_MEDIAGETTER
    if (!path) NSLog(@"ERROR - Media Dictionary not present");
#if DEBUG_MEDIAGETTER_BREAKS
    assert(path);
#endif
#endif
    return path;
}


#pragma mark - Key Accessors


-(NSString*)stringForKey:(NSString*)key group:(NSString*)group
{
#if DEBUG_MEDIAGETTER
    if (!key) NSLog(@"ERROR - pathForKey - Key is NULL");
    if (!group) NSLog(@"ERROR - pathForKey - Group is NULL");
#if DEBUG_MEDIAGETTER_BREAKS
    assert(key);
    assert(group);
#endif
#endif
    if (group) {
        NSDictionary* groupDictinary = [mediasDictionary objectForKey:group];
#if DEBUG_MEDIAGETTER
        if (!groupDictinary) NSLog(@"ERROR - Group \"%@\" not in media dictionary.",group);
#if DEBUG_MEDIAGETTER_BREAKS
        assert(groupDictinary);
#endif
#endif
        if (groupDictinary && key) {
            NSString* string = [groupDictinary objectForKey:key];
#if DEBUG_MEDIAGETTER
            if (!string) NSLog(@"ERROR - Key \"%@\" not in media dictionary ( group \"%@\"",key,group);
#if DEBUG_MEDIAGETTER_BREAKS
            assert(string);
#endif
#endif
            return string;
        }
    }
    return NULL;
}

-(NSString*)entryWithKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    id entry = [self stringForKey:key group:group];
    if (!entry) return NULL;
    
    NSString* string = NULL;
    
    // If entry is a text, just return it
    if ([entry isKindOfClass:[NSString class]]) {
        string = (NSString*)entry;
    }
    
    // If entry is a dictionary, try to return the object in the given language
    else if ([entry isKindOfClass:[NSDictionary class]]) {
        
        // Try to fetch localized version
        if ( language && ![language isEqualToString:@"en"]) {
            string = [entry objectForKey:language];
#if DEBUG_MEDIAGETTER
            if (!string) NSLog(@"WARNING - String for key \"%@\" is not available in language \"%@\" in group \"%@\"",key,language,group);
#endif
        }
        
        // Try to fetch english version
        if (!string) {
            string = [entry objectForKey:@"en"];
#if DEBUG_MEDIAGETTER
            if (!string) NSLog(@"ERROR - String for key \"%@\" in group \"%@\" is not available in English",key,group);
#if DEBUG_MEDIAGETTER_BREAKS
            assert(string);
#endif
#endif
        }
        
        // Entry object class is not string or dict - error
        else {
#if DEBUG_MEDIAGETTER
            NSLog( @"ERROR - Wrong Dictionary Entry class (%@) for key \"%@\" in group \"%@\"", NSStringFromClass([text class]), key, group );
#if DEBUG_MEDIAGETTER_BREAKS
            assert(0);
#endif
#endif
        }
    }
    return string;
}

    
-(NSString*)textWithKey:(NSString*)key language:(NSString*)language
{
    NSString* text = [self entryWithKey:key group:@"texts" language:language];
    return text;
}


-(UIImage*)imageWithKey:(NSString*)key language:(NSString*)language
{
    NSString *imageName = [self entryWithKey:key group:@"images" language:language];
    imageName = [imageName stringByDeletingPathExtension];

    return [self imageNamed:imageName];
}


-(NSURL*)videoWithKey:(NSString*)key language:(NSString*)language
{
    NSString *videoName = [self entryWithKey:key group:@"videos" language:language];
    NSString* videoType = [videoName pathExtension];
    videoName = [videoName stringByDeletingPathExtension];
    
    NSString* moviePath = [self pathForResource:videoName ofType:videoType];
    
    return [MFResGetter fileURLWithPath:moviePath];
}


@end
