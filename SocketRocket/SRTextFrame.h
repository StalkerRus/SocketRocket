//
//  SRTextFrame.h
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import <Foundation/Foundation.h>

@interface SRTextFrame : NSObject

@property (nonatomic, readonly) NSData *data;

#pragma mark - Lifecycle

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithData:(NSData *)data;

#pragma mark - String representation

- (int32_t)length;
- (NSString *)value;

@end
