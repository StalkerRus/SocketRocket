//
//  SRFrameFactoryProtocol.h
//  SocketRocket
//
//  Created by Kirils Sivokozs on 25/04/2017.
//
//

#import <Foundation/Foundation.h>

@class SRTextFrame;

@protocol SRFrameFactoryProtocol <NSObject>

- (SRTextFrame *)textFrameWithData:(NSData *)data;

@end
