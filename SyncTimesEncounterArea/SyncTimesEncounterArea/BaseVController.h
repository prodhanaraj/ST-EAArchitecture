//
//  BaseVController.h
//  SyncTimesEncounterArea
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncounterData.h"
#import "SyncTimesAL.h"

@interface BaseVController : UIViewController <SyncTimesEncounterServiceInteractionsProtocol>

- (void)setInstance:(NSString * )instance;
- (void)getEncounterData:(EncounterDataRequest * )request;

@end