//
//  SyncTimesServiceLayer.h
//  SyncTimesServiceLayer
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProxyProtocol.h"
#import "ServiceClient.h"

@interface BaseProxy : NSObject <BaseProxyProtocol, NSURLConnectionDelegate> {
    @protected
    ServiceClient * _serviceClient;
}

- (id)initWithClient:(ServiceClient * )serviceClient;

+ (void)setInstanceURL:(NSString * )instanceUrl;

+ (void)setAutorizationCredentials:(NSString * )username Password:(NSString * )password;

@end
