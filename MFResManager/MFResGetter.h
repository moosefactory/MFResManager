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


/**
 @discussion MFResGetter implements an access to ressources in a bit safer and more versatile way than system equivalent methods.
 
 ## Version information
 */

/**
 __Version__: 1.0.0
 
 __Last update__: 2016/04/29
 
 __Developer__:  Tristan Leblanc - MooseFactory Software.
 
 ## Methods
 
 */

#import <UIKit/UIKit.h>

#import "MFResFileLogger.h"

typedef NS_OPTIONS(NSUInteger, MFResGetterDebugMode) {
    MFResGetterLog      =   0x01,
    MFResGetterLogFile  =   0x02,
    MFResGetterBreaks   =   0x04
} ;

typedef NS_OPTIONS(NSUInteger, MFResGetterBehavior) {
    MFResGetterUseDefault = 0x01,
    MFResGetterSearchRoot = 0x02,
} ;

@interface MFResGetter : NSObject


/** Returns the default MFResGetter. Several MFResGetter with different behaviors and base directory can be used in one project, but one will often be enough.
 @return The default shared instance of MFResGetter 
 */

+(instancetype)defaultMediaGetter;

#pragma mark - Path and URL Methods

/** System equivalent of fileURLWithPath:
 This method provide strong checking and logging to the console or in a log file.
 This static method is called on the shared instance.
 @param path The path to the resource to load.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */

+(NSURL*)fileURLWithPath:(NSString*)path;


/** System equivalent of fileURLWithPath:
This method provide strong checking and logging to the console or in a log file.
 @param path The path to the resource to load.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */


-(NSURL*)fileURLWithPath:(NSString*)path;


/** System equivalent of pathForResource:ofType:
 Return the path to a resource with given name of given type
 This method is an equivalent to the original one, but provides strong checking and logging to the console or in a log file.
 It first searches relatively to the default getter directory ( baseDirectoryPath ), and then in the bundle root ( if MFResGetterSearchRoot is set ).
 
 This is the static version of the method, so it is called on the MFResGetter default shared instance.
 
 @param name The name to the resource to load.
 @param type The type of the resource to load.
 @return The file path, or NULL if the resource can't be found
 */

+(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type;

#pragma mark Image Loading

/** System equivalent of imageNamed:
 This method provide strong checking and logging to the console or in a log file.
 - ImageNamed: looks for files with the following extensions:
 png,PNG,jpg,JPG,jpeg,JPEG,tif,TIF,tiff,TIFF
 - It first searches in the default getter directory, and then in the bundle root ( if MFResGetterSearchRoot is set ).
 - If no image is found, it can return a default image if MFResGetterUseDefault is set
 
 This is the static version of the method, so it is called on the MFResGetter default shared instance.
 
 @param name The name to the resource to load ( without extension ).
 @return An UIImage.
 */


+(UIImage*)imageNamed:(NSString*)name;

/** System equivalent of imageWithPath:
 This method provide strong checking and logging to the console or in a log file.
 - It first searches relatively to the default getter directory ( baseDirectoryPath ), and then in the bundle root ( if MFResGetterSearchRoot is set ).
 - To force searching at root first, prefix the path with a /
 - If no image is found, it can return a default image if MFResGetterUseDefault is set

 This is the static version of the method, so it is called on the MFResGetter default shared instance.

 @param path The path of the resource to load.
 @return An UIImage.
 */

+(UIImage*)imageWithPath:(NSString*)path;

#pragma mark - Methods

/** System equivalent of pathForResource:ofType:
 Return the path to a resource with given name of given type
 This method is an equivalent to the original one, but provides strong checking and logging to the console or in a log file.
 It first searches relatively to the default getter directory ( baseDirectoryPath ), and then in the bundle root ( if MFResGetterSearchRoot is set ).
 
 @param name The name to the resource to load.
 @param type The type of the resource to load.
 @return The file path, or NULL if the resource can't be found
 */

-(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type;


/** System equivalent of imageNamed:
 This method provide strong checking and logging to the console or in a log file.
 - ImageNamed: looks for files with the following extensions:
 png,PNG,jpg,JPG,jpeg,JPEG,tif,TIF,tiff,TIFF
 - It first searches in the default getter directory, and then in the bundle root ( if MFResGetterSearchRoot is set ).
 - If no image is found, it can return a default image if MFResGetterUseDefault is set
 
 This is the static version of the method, so it is called on the MFResGetter default shared instance.
 
 @param name The name to the resource to load ( without extension ).
 @return An UIImage.
 */

-(UIImage*)imageNamed:(NSString*)name;

/** System equivalent of imageWithPath:
 This method provide strong checking and logging to the console or in a log file.
 It first searches relatively to the default getter directory ( baseDirectoryPath ), and then in the bundle root ( if MFResGetterSearchRoot is set ).
 To force searching at root first, prefix the path with a /
 If no image is found, it can return a default image if MFResGetterUseDefault is set
 
 @param path The path of the resource to load.
 @return An UIImage.
 */

-(UIImage*)imageWithPath:(NSString*)path;


/** This is equivalent of imageWithPath:, but provides a better control on log and default image return.
 
 It first searches relatively to the default getter directory ( baseDirectoryPath ), and then in the bundle root ( if MFResGetterSearchRoot is set ).
 To force searching at root first, prefix the path with a /
 If no image is found, it can return a default image if MFResGetterUseDefault is set
 
 This function is used internally by imageWithPath: to try getting images with different extensions without logging errors.
 
 @param path The path of the resource to load.
 @param log Pass false to bypass current logging settings and fully skip logging.
 @param returnsDefault Pass false to bypass MFResGetterUseDefault setting and return NULL if image not found
 @return An UIImage.
 */

-(UIImage*)imageWithPath:(NSString*)path log:(BOOL)log returnsDefault:(BOOL)returnsDefault;

/** Like fileURLWithPath:, but provides control on logging
 @param path The path to the resource to load.
 @param log Pass false to bypass current logging settings and fully skip logging.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */

-(NSURL*)fileURLWithPath:(NSString*)path log:(BOOL)log;

+(void)clearCache;

#pragma mark - Properties

/**The bundle this Getter should search in
 Set to mainBundle by default
 */

@property(nonatomic,weak)   NSBundle*               bundle;

/** Debug options
 Set MFResGetterLog bit to activate logging
 Set MFResGetterLogFile to activate logging to file ( MFResGetterLog bit must be set )
 Set MFResGetterBreaks to braks if a resource is missing ( MFResGetterLog bit must be set )
 */

@property(nonatomic,assign) MFResGetterDebugMode    debugMode;

/** Behavior Options
 Set MFResGetterUseDefault bit to return default image
 Set MFResGetterSearchRoot bit to search at root if resource not found in base directory
 */

@property(nonatomic,assign) MFResGetterBehavior     behavior;

/** the path of the base directory for this getter.
 If NULL, always search the root directory.
 baseDirectoryPath is NULL by default
*/

@property(nonatomic,strong) NSString*               baseDirectoryPath;

/** name of the default image. 
 @warning Default image must be a png located at bundle root
 */

@property(nonatomic,strong) NSString*               defaultImageName;

/** default image.
 May be NULL. Default image is initialized at first access.
 */

@property(nonatomic,strong) UIImage*                defaultImage;


@end
