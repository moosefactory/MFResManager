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
 @discussion MFResGetter implements an access to ressources in a safer and more versatile way than system equivalent methods.
 
 ## Version information
 
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
 It avoid the NULL url exception, but logs any error to the console, or in a log file.
 This static method is called on the shared instance.
 If URL can't 
 @param path The path to the resource to load.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */

+(NSURL*)fileURLWithPath:(NSString*)path;


/** System equivalent of fileURLWithPath:
 It avoid the NULL url exception, but logs any error to the console, or in a log file.
 This method is not static to allow logging to custom file.
 @param path The path to the resource to load.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */

-(NSURL*)fileURLWithPath:(NSString*)path;

/** System equivalent of pathForResource:ofType:
 It avoid the NULL url exception, but logs any error to the console, or in a log file.
 @param name The name to the resource to load.
 @param type The type to the resource to load.
 @return The file URL constructed with given file path, or NULL if path does not exist
 */

+(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type;

#pragma mark Image Loading

+(UIImage*)imageNamed:(NSString*)name;

+(UIImage*)imageWithPath:(NSString*)path;

#pragma mark - Methods

-(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type;

-(UIImage*)imageNamed:(NSString*)name;

-(UIImage*)imageWithPath:(NSString*)path;

-(UIImage*)imageWithPath:(NSString*)path log:(BOOL)log;

-(NSURL*)fileURLWithPath:(NSString*)path log:(BOOL)log;

+(void)clearCache;

#pragma mark - Properties

@property(nonatomic,weak)   NSBundle*               bundle;

@property(nonatomic,assign) MFResGetterDebugMode    debugMode;
@property(nonatomic,assign) MFResGetterBehavior     behavior;

@property(nonatomic,strong) NSString*               directoryPath;
@property(nonatomic,strong) NSString*               defaultImageName;
@property(nonatomic,strong) UIImage*                defaultImage;


@end
