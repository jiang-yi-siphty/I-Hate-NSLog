//
//  Log.h
//  Digiflex SMS Reports
//
//  Created by Robert Yi Jiang on 19/03/2014.
//  Copyright (c) 2014 MyAlarm Pty Ltd. All rights reserved.
//

#import "Log.h"
#define PADDING_TABS 10

@implementation Log
void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    msg = formatJsonData(msg);
    
    va_end (ap);
    fprintf(stderr,"\n%s[%30s:%4d] - %s",[prefix UTF8String], [[[NSString stringWithUTF8String:file] lastPathComponent]UTF8String] , lineNumber, [msg UTF8String]);
    append(msg);
}

void append(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"logfile.txt"];
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    // append
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}


NSString *formatJsonData(NSString *rawMessageString){

    int jsonCounterInt      = 0;
    int doubleQuotePairs    = 0;
    NSMutableString *cookedMessageMutableString =  [NSMutableString stringWithString:@""];
    NSString *suspectedJsonString = [NSString new];
//    BOOL hasJsonDataBool = NO;   //useless variable
  
    
    NSRange jsonStartRange = [rawMessageString rangeOfString:@"{"];
    NSRange jsonEndRange   = [rawMessageString rangeOfString:@"}" options:NSBackwardsSearch];
    if ( (jsonStartRange.location != NSNotFound) && (jsonEndRange.location != NSNotFound) ){
        suspectedJsonString = [rawMessageString substringWithRange:NSMakeRange(jsonStartRange.location, jsonEndRange.location-jsonStartRange.location+1)];
    } else {
        return rawMessageString;
    }
    if ([NSJSONSerialization JSONObjectWithData:[suspectedJsonString dataUsingEncoding:NSUTF8StringEncoding]
                                        options:NSJSONReadingMutableContainers
                                          error:nil] == nil){
        return rawMessageString;
    }
    [cookedMessageMutableString appendString:[rawMessageString substringWithRange:NSMakeRange(0, jsonStartRange.location)] ];
    [cookedMessageMutableString appendString:@"\n"];
    for (int n = 0; n < PADDING_TABS; ++n) {
        [cookedMessageMutableString appendString:@"\t"];
    }
    for (NSUInteger i = jsonStartRange.location; i <= jsonEndRange.location; ++i)
    {
        NSString *oneCharString = [rawMessageString substringWithRange:NSMakeRange(i, 1)];
        if ([oneCharString isEqualToString: @" "]){
            if (!(doubleQuotePairs%2)==0) {
                [cookedMessageMutableString appendString:oneCharString];
            }
        }else if ([oneCharString isEqualToString: @"\""]){
            switch (++doubleQuotePairs%4) {
                case 1:
                    [cookedMessageMutableString appendString:@"\n"];
                    for (int n = 0; n < jsonCounterInt + PADDING_TABS; ++n) {
                        [cookedMessageMutableString appendString:@"\t"];
                    }
                    [cookedMessageMutableString appendString:oneCharString];
                    break;
                case 2:
                case 3:
                case 0:
                    [cookedMessageMutableString appendString:oneCharString];
                    break;
                default:
                    break;
            }
        }else if ([oneCharString isEqualToString: @"{"]){
            doubleQuotePairs = 0;
            [cookedMessageMutableString appendString:oneCharString];
            ++jsonCounterInt;
            for (int n = 0; n < jsonCounterInt + PADDING_TABS; ++n) {
                [cookedMessageMutableString appendString:@"\t"];
            }
        }else if ([oneCharString isEqualToString: @"}"]){
            [cookedMessageMutableString appendString:@"\n"];
            --jsonCounterInt;
            for (int n = 0; n < jsonCounterInt + PADDING_TABS; ++n) {
                [cookedMessageMutableString appendString:@"\t"];
            }
            [cookedMessageMutableString appendString:oneCharString];
        }else if ([oneCharString isEqualToString: @","]){
            [cookedMessageMutableString appendString:oneCharString];
            if (doubleQuotePairs%2 == 0) {
                doubleQuotePairs = 0;
            }
        }else {
            [cookedMessageMutableString appendString:oneCharString];
        }
    }
    NSInteger stringLength = [rawMessageString length];
    if (jsonEndRange.location < stringLength) {
        [cookedMessageMutableString appendString:[rawMessageString substringWithRange:NSMakeRange(jsonEndRange.location+1, stringLength-jsonEndRange.location-1)]];
    }
    return [cookedMessageMutableString copy];
}

@end

