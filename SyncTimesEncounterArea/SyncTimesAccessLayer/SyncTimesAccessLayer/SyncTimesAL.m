//
//  SyncTimesAccessLayer.m
//  SyncTimesAccessLayer
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "SyncTimesAL.h"
#import "ServiceFactory.h"
#import "InitServiceClient.h"

@interface SyncTimesAL()
@property (nonatomic, strong) id <EncounterDataProxyProtocol> encounterDataService;
@end

@implementation SyncTimesAL
@synthesize encounterDataService = _encounterDataService;

static NSString * instanceURL;

+ (instancetype)singletonInstance {
    static SyncTimesAL *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (id<EncounterDataProxyProtocol>)encounterDataService {
    if (!_encounterDataService) {
        _encounterDataService = [ServiceFactory CreateEncounterDataService:instanceURL];
    }
    return _encounterDataService;
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

- (void)GetEncounterData:(id<EncounterDataRequestProtocol>)requestParameters {
    EncounterDataRequest *encounterDataRequest = requestParameters;
    
    if (!encounterDataRequest) {
        //Do nothing here since we are not going to authenticate for hitting WEB API for now
    }
    
    [self.encounterDataService GetEncounterData:requestParameters onSuccess:^(id <EncounterDataProtocol> encounterData){
        if ([self.delegate respondsToSelector:@selector(didGetEncounterData:)]) {
            [self.delegate didGetEncounterData:encounterData];
        }
    }onFailure:^(NSError * error, int statusCode){
        if ([self.delegate respondsToSelector:@selector(onSyncTimesServiceError:StatusCode:)]) {
            [self.delegate onSyncTimesServiceError:error StatusCode:statusCode];
        }
    }];
}

@end
