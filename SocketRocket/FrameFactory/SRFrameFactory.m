//
//  SRFrameFactory.m
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import "SRFrameFactory.h"

#import "SRNoICUTextFrame.h"

@implementation SRFrameFactory

- (SRTextFrame *)textFrameWithData:(NSData *)data
{
    return [[SRTextFrame alloc] initWithData:data];
}

@end
