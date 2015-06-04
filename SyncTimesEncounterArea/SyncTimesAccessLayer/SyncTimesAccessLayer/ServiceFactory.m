//
//  ServiceFactory.m
//  SyncTimesAccessLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "ServiceFactory.h"

@implementation ServiceFactory

//Returns instance of the EncounterData Service
+(id <EncounterDataProxyProtocol>)CreateEncounterDataService:(NSString *)instanceUrl {
    [EncounterDataProxy setInstanceURL:instanceUrl];
    return [[EncounterDataProxy alloc] init];
}

+ (void)setAuthorizationCredentials:(NSString *)username Password:(NSString *)password {
    [BaseProxy setAutorizationCredentials:nil Password:nil];
}

@end
