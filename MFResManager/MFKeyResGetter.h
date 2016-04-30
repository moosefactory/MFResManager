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

/*!
 @header
 @abstract
 Provides access to (localized) resources through a table of content.
 @discussion MFKeyResGetter implements an access to localized ressources through a TOC mechanism.
 
 ## Version information
 */

/**
 __Version__: 1.0.0
 
 __Last update__: 2016/04/29
 
 __Developer__:  Tristan Leblanc - MooseFactory Software.
 
 ## Methods
 */

#import <UIKit/UIKit.h>
#import "MFResGetter.h"


/*!
 @abstract   Provides access to (localized) resources through a table of content.
 @discussion    MFKeyResGetter if a MFResGetter subclass and so provides all of its features.
 It adds resource loading via a table of content stored as a PLIST in the baseDirectory or root.
 It also adds support for localized resources
 */

@interface MFKeyResGetter : MFResGetter

+(instancetype)defaultMediaGetter;

/**
 @method entryForKey:group:language:
 @abstract return the entry with given key, group and language stored in the toc dictionary
 This method provide strong checking and logging to the console or in a log file.
 
 This static method is called on the shared instance.
 
 @param key The key of the resource to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 
 @return The object in the toc dictionary
 */

+(id)entryForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

/**
 @method entryForKey:group:language:
 @abstract return the entry with given key, group and language stored in the toc dictionary
 This method provide strong checking and logging to the console or in a log file.
  
 @param key The key of the resource to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 
 @return The object in the toc dictionary
 */

-(id)entryForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

#pragma mark - Text Loading

/**
 @method textForKey:
 @abstract return the text stored in the dictionary, at root level
 This method provide strong checking and logging to the console or in a log file.
 This static method is called on the shared instance.
 @param key The key of the text to load in the TOC dictionary
 @return The text for given key, as a NSString*
 */

+(NSString*)textForKey:(NSString*)key;

/**
 @method textForKey:
 @abstract return the text stored in the dictionary, at root level
 This method provide strong checking and logging to the console or in a log file.
 @param key The key of the text to load in the TOC dictionary
 @return The text for given key, as a NSString*
 */

-(NSString*)textForKey:(NSString*)key;


/**
 @method textForKey:group:language:
 @abstract return the text stored in the dictionary in the given group
 This method provide strong checking and logging to the console or in a log file.
 This static method is called on the shared instance.
 @param key The key of the text to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 @return The text for given key, as a NSString*
 */

+(NSString*)textForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

/**
 @method textForKey:group:language:
 @abstract return the text stored in the dictionary in the given group
 This method provide strong checking and logging to the console or in a log file.
 @param key The key of the text to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 @return The text for given key, as a NSString*
 */

-(NSString*)textForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

#pragma mark - Image Loading

/**
 @method imageForKey:
 @abstract return the image with name stored in the dictionary, at root level
 This method provide strong checking and logging to the console or in a log file.
 This static method is called on the shared instance.
 @param key The key of the image to load in the TOC dictionary
 @return The image for given key, as a UIImage*
 */

+(UIImage*)imageForKey:(NSString*)key;

/**
 @method imageForKey:
 @abstract return the image with name stored in the dictionary, at root level
 This method provide strong checking and logging to the console or in a log file.
 @param key The key of the image to load in the TOC dictionary
 @return The image for given key, as an UIImage*
 */

-(UIImage*)imageForKey:(NSString*)key;

/**
 @method imageForKey:
 @abstract return the image with name stored in the dictionary in the given group
 This method provide strong checking and logging to the console or in a log file.
 This static method is called on the shared instance.
 @param key The key of the image to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 @return The image for given key, as an UIImage*
 */

+(UIImage*)imageForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

/**
 @method imageForKey:
 @abstract return the image with name stored in the dictionary in the given group
 This method provide strong checking and logging to the console or in a log file.
 @param key The key of the image to load in the TOC dictionary
 @param group The group in the TOC dictionary - Pass NULL to search in the TOC root
 @param language The language of the resource - Pass NULL to search for default language
 @return The image for given key, as an UIImage*
 */

-(UIImage*)imageForKey:(NSString*)key group:(NSString*)group language:(NSString*)language;

/**
 @property tocDictionaryName
 @abstract Name of the toc dictionary, located in ResGetter base directory, or bundle root
 */

@property(nonatomic,strong) NSString* tocDictionaryName;

/**
 @property defaultLanguage
 @abstract Default language used for texts. If a TOC entry value does not exists for a requested language, the value for default language is returned
 @warning For localized entry, value must be defined at least for default language
 */

@property(nonatomic,strong) NSString* defaultLanguage;

@end
