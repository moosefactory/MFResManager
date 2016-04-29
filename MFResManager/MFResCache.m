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


#import "MFResCache.h"

// Cache Dictionary

/* Format :
{
    "path" : { "object" : <object>; "hits" : <hits> },
    ...
}
*/

static NSMutableDictionary* sCacheDictionary;

@implementation MFResCache

+(void)clearCache
{
    sCacheDictionary = NULL;
}


+(instancetype)cachedResourceWithPath:(NSString*)path
{
    if (!path) return NULL;
    NSMutableDictionary* entry = [[MFResCache cacheDictionary] objectForKey:path];
    if (entry) {
        NSUInteger count = [[entry objectForKey:@"hits"] integerValue];
        count++;
        [entry setObject:[NSNumber numberWithInteger:count] forKey:@"hits"];
        //NSLog(@"%@",[entry description]);
        return [entry objectForKey:@"object"];
    }
    return NULL;
}

+(void)cacheResource:(id)object withPath:(NSString*)path
{
    if (!path || !object) return;
    NSMutableDictionary* entry = [NSMutableDictionary dictionaryWithObjectsAndKeys:object,@"object",[NSNumber numberWithInt:0],@"hits", nil];
    if (entry) {
        [[MFResCache cacheDictionary] setObject:entry forKey:path];
    }
}

+(NSMutableDictionary*)cacheDictionary
{
    if (!sCacheDictionary) {
        sCacheDictionary = [NSMutableDictionary dictionary];
    }
    return sCacheDictionary;
}

@end
