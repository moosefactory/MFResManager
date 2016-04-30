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
 @header
@abstract
 Logging to console and file.
@discussion
 MFResFileLogger is a simple logging class.
 It works like NSLog(). Call MFRlog(args) or MFRFileLog(file_name,args) to log to file 'file_name'
 
 Set the UIFileSharingEnabled options in your project info to access logs in iTunes, in the application documents section
@groupindex MFResManager
 
 ## Version information
*/

/**
__Version__: 1.0.0
__Last update__: 2016/04/29
__Developer__:  Tristan Leblanc , MooseFactory Software.
*/
/**
 ## Methods
*/

#import <Foundation/Foundation.h>

#define MFRLog(...) [MFResFileLogger log:__VA_ARGS__]
#define MFRFileLog(file,...) [MFResFileLogger logToFile:file format:__VA_ARGS__]

@interface MFResFileLogger : NSObject

// Logging

+(void)log:(NSString*)format, ...;
+(void)logToFile:(NSString*)fileName format:(NSString*)format, ...;

+(void)logString:(NSString*)string;
+(void)logString:(NSString*)string file:(NSString*)fileName;

// File Utils

+(void)logFile:(NSString*)fileName;
+(void)deleteFile:(NSString*)fileName;

@end
