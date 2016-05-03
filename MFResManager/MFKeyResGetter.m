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
    NSDictionary*   tocDictionary;
}

#pragma mark - Init

+(instancetype)defaultMediaGetter
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithTocName:@"toc"];
    });
    return sharedInstance;
}


- (id)init {
    if (self = [super init]) {
        self.tocDictionaryName = @"toc";
        self.defaultLanguage = @"en";
    }
    return self;
}

-(id)initWithTocName:(NSString*)name
{
    if ( self = [super init]) {
        self.defaultLanguage = @"en";
        self.tocDictionaryName = name;
    }
    return self;
}

-(void)setTocDictionaryName:(NSString *)tocDictionaryName
{
    _tocDictionaryName = tocDictionaryName;
    tocDictionary = [NSDictionary dictionaryWithContentsOfFile:[self tocDictionaryPath]];
}

#pragma mark - Properties

-(NSString*)tocDictionaryPath
{
    NSString* path = [self pathForResource:self.tocDictionaryName ofType:@"plist"];
    if ( MFResLog && !path) {
        MFRFileLog(@"MFResGetter.log",@"ERROR - Resources TOC \"%@\" not present.",path);
        MFResBreaksNULL(path);
    }
    return path;
}

#pragma mark - Key Accessors

+(id)entryForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    return [[MFKeyResGetter defaultMediaGetter] entryForKey:key group:group language:language];
}

-(id)entryForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    if (!key) {
        if ( MFResLog ) {
            MFRFileLog(@"MFResGetter.log",@"ERROR - stringForKey - Key is NULL");
            MFResBreaksNULL(key);
        }
        return NULL;
    }
    
    NSDictionary* groupDictionary;
    
    if (group) {
        groupDictionary = (NSDictionary*)[tocDictionary objectForKey:group];
        if ( MFResLog && !groupDictionary) {
            MFRFileLog(@"ResGetter.log", @"ERROR - Group \"%@\" not in media dictionary.",group);
            MFResBreaksNULL(groupDictionary);
        }
    } else groupDictionary = tocDictionary;
    
    
    id entry = [groupDictionary objectForKey:key];
    if (!entry) {
        MFRFileLog(@"MFResGetter.log",@"ERROR - Entry with key \"%@\" in toc dictionary %@.",key,
                   group ? [NSString stringWithFormat:@"( Group \"%@\" )",group] : @"");
        if ( MFResBreaks ) {
            assert(groupDictionary);
        }
        return NULL;
    }
    
    // If entry is a dictionary, try to return the object in the given language
    if ([entry isKindOfClass:[NSDictionary class]]) {
        
        id localizedEntry;
        NSString* languageCode = language ? language : self.defaultLanguage;
        // Try to fetch localized version
        if ( languageCode && ![languageCode isEqualToString:self.defaultLanguage]) {
            localizedEntry = [entry objectForKey:language];
            if ( MFResLog && !localizedEntry ) {
                MFRFileLog(@"MFResGetter.log",@"WARNING - String for key \"%@\" is not available in language \"%@\" in group \"%@\"",key,languageCode,group);
            }
        }
        
        // Try to fetch english version
        if (!localizedEntry) {
            localizedEntry = [entry objectForKey:self.defaultLanguage];
            if ( MFResLog && !localizedEntry) {
                MFRFileLog(@"MFResGetter.log",@"ERROR - Entry for key \"%@\" in group \"%@\" is not available in default language (%@)",key,group,self.defaultLanguage);
                MFResBreaksNULL(localizedEntry);
            
            }
        }
        
        return localizedEntry;
    }
    
    return entry;
}

#pragma mark - Text Loading


+(NSString*)textForKey:(NSString*)key
{
    return [[MFKeyResGetter defaultMediaGetter] textForKey:key];
}

-(NSString*)textForKey:(NSString*)key
{
    return [self textForKey:key group:NULL language:NULL];
}

+(NSString*)textForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    return [[MFKeyResGetter defaultMediaGetter] textForKey:key group:group language:language];
}

-(NSString*)textForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    id object = [self entryForKey:key group:group language:language];
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString*)object;
    }
    if ( MFResLog ) {
        if (object) {
            MFRFileLog(@"Missing Keys.log", @"ERROR - Object for key \"%@\" in group \"%@\" [%@] is not a text", key, group, language );
        } else {
            MFRFileLog(@"Missing Keys.log", @"ERROR - Text for key \"%@\" in group \"%@\" [%@]", key, group, language );
        }
        MFResBreaksNULL(0);
    }
    return NULL;
}

#pragma mark - Image Loading


+(UIImage*)imageForKey:(NSString*)key
{
    return [[MFKeyResGetter defaultMediaGetter] imageForKey:key group:NULL language:NULL];
}

-(UIImage*)imageForKey:(NSString*)key
{
    return [self imageForKey:key group:NULL language:NULL];
}

+(UIImage*)imageForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    return [[MFKeyResGetter defaultMediaGetter] imageForKey:key group:group language:language];
}

-(UIImage*)imageForKey:(NSString*)key group:(NSString*)group language:(NSString*)language
{
    id object = [self entryForKey:key group:group language:language];
    if (!object || ![object isKindOfClass:[NSString class]]) {
        if ( MFResLog ) {
            if (object) {
            MFRFileLog(@"Missing Keys.log", @"ERROR - Image Name for key \"%@\" in group \"%@\" [%@] is not a string", key, group, language );
            } else {
                MFRFileLog(@"Missing Keys.log", @"ERROR - Missing Image Name for key \"%@\" in group \"%@\" [%@]", key, group, language );
            }
            MFResBreaksNULL(0);
        }
        if ( MFResUseDefault ) {
            return [self defaultImage];
        }
    }
    
    return [self imageNamed:(NSString*)object inDirectory:self.useGroupAsDirectory ? group : NULL];
}


@end
