//
//  NSString+UTF8.h
//  SocketRocket
//
//  Created by Kirils Sivokozs on 24/04/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSString (UTF8)

+ (NSString *)lossyUTF8StringWithData:(NSData *)data;

@end
