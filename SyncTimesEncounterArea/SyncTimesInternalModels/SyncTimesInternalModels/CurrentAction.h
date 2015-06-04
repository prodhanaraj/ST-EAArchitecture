//
//  CurrentAction.h
//  SyncTimesInternalModels
//
//  Created by Dexter on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentAction : NSObject

@property (nonatomic, strong) NSString * ActionID;
@property (nonatomic, strong) NSString * Name;
@property (nonatomic, strong) NSString * ActionImageURL;
@property (nonatomic, strong) NSString * ActionOrder;
@property (nonatomic, strong) NSString * IsActiveAction;
@property (nonatomic, strong) NSString * Priority;
@property (nonatomic, strong) NSString * IsActionCompleted;

@end
