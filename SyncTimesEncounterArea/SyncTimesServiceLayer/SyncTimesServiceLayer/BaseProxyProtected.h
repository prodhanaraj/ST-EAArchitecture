//
//  BaseProxyProtected.h
//  SyncTimesServiceLayer
//
//  Created by Dexter on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProxy.h"
#import "RestKit/RestKit.h"
#import "WCObjectManager.h"

#ifndef SyncTimesServiceLayer_BaseProxyProtected_h
#define SyncTimesServiceLayer_BaseProxyProtected_h

@interface BaseProxy()

@property (nonatomic, strong, readonly) ServiceClient * serviceClient;
@property (nonatomic, strong) WCObjectManager *ObjectManager;

- (Endpoint * )getEndPointForOperation:(NSString * )operationName;
+ (NSString * )getInstanceURL;
- (void)setHTTPHeaders:(Endpoint * )endpoint;

@end

#endif
