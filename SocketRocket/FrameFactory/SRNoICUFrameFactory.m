//
//  SRNoICUFrameFactory.m
//  SocketRocket
//
//  Created by Kirils Sivokozs on 25/04/2017.
//
//

#import "SRNoICUFrameFactory.h"

#import "SRNoICUTextFrame.h"

@implementation SRNoICUFrameFactory

- (SRTextFrame *)textFrameWithData:(NSData *)data
{
    return [[SRNoICUTextFrame alloc] initWithData:data];
}

@end
