//
//  BaseVController.h
//  SyncTimesEncounterArea
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncounterData.h"
#import "SyncTimesAL.h"
#import "MBProgressHUD.h"

@interface BaseVController : UIViewController <SyncTimesEncounterServiceInteractionsProtocol>

#pragma mark - Encounter Data Configuration

- (void)setInstance:(NSString * )instance;
- (void)getEncounterData:(EncounterDataRequest * )request;

#pragma mark - Progress Bar

@property (nonatomic, strong) MBProgressHUD *progressBar;
typedef void (^ProgressBarBlock)(MBProgressHUD * );
- (void)showProgressBarOnMainThreadWithDescription:(NSString *)loaderDescription andWithProgressBarBlock:(ProgressBarBlock)progressBlock;
- (void)hideProgressBarOnMainThread;

#pragma mark - Shared Methods

typedef void (^MainThreadBlock)(void);
- (void)runBlockOnMainThread:(MainThreadBlock)voidBlock;

@end