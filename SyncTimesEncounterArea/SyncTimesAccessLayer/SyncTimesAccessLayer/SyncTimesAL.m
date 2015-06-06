//
//  SyncTimesAccessLayer.m
//  SyncTimesAccessLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "SyncTimesAL.h"
#import "ServiceFactory.h"
#import "InitServiceClient.h"

@interface SyncTimesAL()
@property (nonatomic, strong) id <EncounterAreaDataProxyProtocol> encounterAreaDataService;
@end

@implementation SyncTimesAL
@synthesize encounterAreaDataService = _encounterAreaDataService;

static NSString * instanceURL;

+ (instancetype)singletonInstance {
    static SyncTimesAL *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (id<EncounterAreaDataProxyProtocol>)encounterAreaDataService {
    if (!_encounterAreaDataService) {
        _encounterAreaDataService = [ServiceFactory CreateEncounterDataService:instanceURL];
    }
    return _encounterAreaDataService;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)init:(NSString *)instanceUrl {
    self = [self init];
    instanceURL = instanceUrl;
    return self;
}

- (void)GetEncounterAreaData:(id<EncounterAreaDataRequestProtocol>)requestParamerters {
    [self.encounterAreaDataService GetEncounterAreaData:requestParamerters onSuccess:^(id <EncounterAreaDataProtocol> encounterAreaData){
        if ([self.delegate respondsToSelector:@selector(didGetEncounterAreaData:)]) {
            [self.delegate didGetEncounterAreaData:encounterAreaData];
        }
    }onFailure:^(NSError * error, int statusCode){
        if ([self.delegate respondsToSelector:@selector(onSyncTimesServiceError:StatusCode:)]) {
            [self.delegate onSyncTimesServiceError:error StatusCode:statusCode];
        }
    }onProgressUpdate:^(float progress){
        if ([self.delegate respondsToSelector:@selector(OnProgressUpdate:)]) {
            [self.delegate OnProgressUpdate:progress];
        }
    }];
}

- (void)authenticateUser:(NSString *)username withPassword:(NSString *)password {
    //Do nothing here for now, since there is no need of authenticate, for fetching Encounter Area Data from the Web Service
}

@end
