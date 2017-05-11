//
//  SRTextFrame.m
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import "SRTextFrame.h"

#import <unicode/utf8.h>

@implementation SRTextFrame

#pragma mark - Lifecycle

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}


#pragma mark - String

- (NSString *)valueWithLength:(NSUInteger)length
{
    return [[NSString alloc] initWithBytesNoCopy:(char *)self.data.bytes
                                          length:length
                                        encoding:NSUTF8StringEncoding
                                    freeWhenDone:NO];
}


- (NSString *)value
{
    return [self valueWithLength:self.data.length];
}

- (int32_t)length
{
    if (self.data.length > INT32_MAX) {
        // INT32_MAX is the limit so long as this Framework is using 32 bit ints everywhere.
        return -1;
    }

    int32_t size = (int32_t)self.data.length;

    const void * contents = self.data.bytes;
    const uint8_t *str = (const uint8_t *)contents;

    UChar32 codepoint = 1;
    int32_t offset = 0;
    int32_t lastOffset = 0;
    while(offset < size && codepoint > 0)  {
        lastOffset = offset;
        U8_NEXT(str, offset, size, codepoint);
    }

    if (codepoint == -1) {
        // Check to see if the last byte is valid or whether it was just continuing
        if (!U8_IS_LEAD(str[lastOffset]) || U8_COUNT_TRAIL_BYTES(str[lastOffset]) + lastOffset < (int32_t)size) {

            size = -1;
        } else {
            uint8_t leadByte = str[lastOffset];
            U8_MASK_LEAD_BYTE(leadByte, U8_COUNT_TRAIL_BYTES(leadByte));

            for (int i = lastOffset + 1; i < offset; i++) {
                if (U8_IS_SINGLE(str[i]) || U8_IS_LEAD(str[i]) || !U8_IS_TRAIL(str[i])) {
                    size = -1;
                }
            }

            if (size != -1) {
                size = lastOffset;
            }
        }
    }

    if (size != -1 && ![[NSString alloc] initWithBytesNoCopy:(char *)self.data.bytes
                                                      length:size
                                                    encoding:NSUTF8StringEncoding
                                                freeWhenDone:NO]) {
        size = -1;
    }

    return size;
}

@end
