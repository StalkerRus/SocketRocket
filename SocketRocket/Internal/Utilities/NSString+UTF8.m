//
//  NSString+UTF8.m
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import "NSString+UTF8.h"

#import <unicode/utf8.h>

@implementation NSString (UTF8)

+ (NSString *)lossyUTF8StringWithData:(NSData *)data
{
    NSString *string = [[NSString alloc] initWithBytesNoCopy:(char *)[data bytes]
                                                      length:[data length]
                                                    encoding:NSUTF8StringEncoding
                                                freeWhenDone:NO];
    if (!string) {
        const Byte *buffer = [data bytes];
        NSMutableString *filteredString = [[NSMutableString alloc] init];

        unsigned long i = 0;
        while (i < [data length]) {
            uint32_t expectedLength = U8_LENGTH(buffer[i]);
            unsigned long length = MIN(expectedLength > 0 ? expectedLength : 1, [data length] - i);
            NSData *character = [NSData dataWithBytes:&buffer[i] length:(sizeof(Byte) * length)];
            NSString *possibleString = [NSString stringWithUTF8String:[character bytes]];
            if (possibleString) {
                [filteredString appendString:possibleString];
            } else {
                [filteredString appendString:@"\uFFFD"];
            }
            i = i + expectedLength;
        }
        string = filteredString;
    }

    return string;
}

@end
