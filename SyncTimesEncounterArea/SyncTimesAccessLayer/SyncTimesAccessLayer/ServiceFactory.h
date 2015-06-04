//
//  ServiceFactory.h
//  SyncTimesAccessLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncounterDataProxy.h"

@protocol EncounterDataProxyProtocol;

@interface ServiceFactory : NSObject

+ (void)setAuthorizationCredentials:(NSString *)username Password:(NSString *)password;

+ (id <EncounterDataProxyProtocol>)CreateEncounterDataService:(NSString * )instanceUrl;

@end
