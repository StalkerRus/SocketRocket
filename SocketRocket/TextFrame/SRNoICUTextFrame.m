//
//  SRNoICUTextFrame.m
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import "SRNoICUTextFrame.h"

@implementation SRNoICUTextFrame

- (int32_t)length
{
    static const int maxCodepointSize = 3;

    for (int i = 0; i < maxCodepointSize; i++) {
        NSString *str = [[NSString alloc] initWithBytesNoCopy:(char *)self.data.bytes
                                                       length:self.data.length - i
                                                     encoding:NSUTF8StringEncoding
                                                 freeWhenDone:NO];
        if (str) {
            return (int32_t)self.data.length - i;
        }
    }

    return -1;
}

@end
