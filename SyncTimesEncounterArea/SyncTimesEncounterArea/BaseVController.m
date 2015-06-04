//
//  BaseVController.m
//  SyncTimesEncounterArea
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "BaseVController.h"

@interface BaseVController ()
@property (nonatomic, strong) SyncTimesAL *accessLayer;
@end

@implementation BaseVController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (SyncTimesAL *)accessLayer {
    if (!_accessLayer) {
        _accessLayer = [SyncTimesAL new];
        _accessLayer.delegate = self;
    }
    return _accessLayer;
}

- (void)setInstance:(NSString *)instance {
    _accessLayer = [[SyncTimesAL alloc] init:instance];
    if (!_accessLayer.delegate) {
        _accessLayer.delegate = self;
    }
}

- (IBAction)getEncounterData_Tapped:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            //Set the instance URL :
            [self setInstance:@"synctimescesium.azurewebsites.net"];
            EncounterDataRequest *requestForEncounterData = [EncounterDataRequest new];
            requestForEncounterData.URL = @"";
            [self getEncounterData:requestForEncounterData];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception Occured during EncouterData Fetching process : %@", exception);
        }
        @finally {
            
        }
    });
}


- (void)getEncounterData:(EncounterDataRequest *)request {
    request.URL = nil;
    [self.accessLayer GetEncounterData:request];
}

- (void)didGetEncounterData:(id<EncounterDataProtocol>)encounterData {
    NSLog(@"Encounter Data %@", encounterData);
}

- (void)onSyncTimesServiceError:(NSError *)error StatusCode:(int)statusCode {
    NSLog(@"Error Info : %@, Status Code : %d", error, statusCode);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
