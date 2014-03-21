//
//  Log.h
//  I-Hate_NSLog
//
//  Created by Robert Yi Jiang on 19/03/2014.
//  Copyright (c) 2014 Robert Yi Jiang All rights reserved.
//

@interface Log : NSObject
void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...);
@end

