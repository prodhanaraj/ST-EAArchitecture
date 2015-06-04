//
//  SyncTimesAccessLayer.h
//  SyncTimesAccessLayer
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entities.h"
#import "SyncTimesEncounterServiceInteractionsProtocol.h"

@interface SyncTimesAL : NSObject

@property (nonatomic, strong) id <SyncTimesEncounterServiceInteractionsProtocol> delegate;

+ (instancetype)singletonInstance;

- (instancetype)init;

- (instancetype)init:(NSString * )instanceUrl;

- (void)authenticateUser:(NSString * )username withPassword:(NSString * )password;

- (void)GetEncounterData:(id <EncounterDataRequestProtocol>)requestParameters;

@end
