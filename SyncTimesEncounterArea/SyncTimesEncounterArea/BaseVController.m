//
//  BaseVController.m
//  SyncTimesEncounterArea
//
//  Created by Dhanaraj on 04/06/15.
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
    
    [self showProgressBarOnMainThreadWithDescription:@"Fetching.." andWithProgressBarBlock:^(MBProgressHUD * progressBar){
        self.progressBar = progressBar;
    }];
    
    [self runBlockOnMainThread:^{
        [self setInstance:@"synctimescesium.azurewebsites.net"];
        EncounterDataRequest *requestForEncounterData = [EncounterDataRequest new];
        requestForEncounterData.URL = @"";
        [self getEncounterData:requestForEncounterData];
    }];
}


- (void)getEncounterData:(EncounterDataRequest *)request {
    request.URL = nil;
    [self.accessLayer GetEncounterData:request];
}

- (void)didGetEncounterData:(id<EncounterDataProtocol>)encounterData {
    NSLog(@"Encounter Data %@", encounterData);
    [self hideProgressBarOnMainThread];
}

- (void)onSyncTimesServiceError:(NSError *)error StatusCode:(int)statusCode {
    NSLog(@"Error Info : %@, Status Code : %d", error, statusCode);
}

- (void)runBlockOnMainThread:(MainThreadBlock)voidBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        voidBlock();
    });
}

- (void)showProgressBarOnMainThreadWithDescription:(NSString *)loaderDescription andWithProgressBarBlock:(ProgressBarBlock)progressBlock {
    if (self.progressBar) {
        return;
    }
    
    //Run operation on UI Thread
    [self runBlockOnMainThread:^{
        MBProgressHUD *progressBar = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressBar.mode = (MBProgressHUDMode) MBProgressHUDModeDeterminate;
        progressBar.labelText = loaderDescription;
        if (progressBlock) {
            progressBlock(progressBar);
        }
        self.progressBar = progressBar;
    }];
    
}

- (void)hideProgressBarOnMainThread {
    [self runBlockOnMainThread:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.progressBar = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
