//
//  EncounterProxy.h
//  SyncTimesBusinessLayer
//
//  Created by Dexter on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProxyProtected.h"
#import "EncounterDataProxyProtocol.h"
#import "EncounterDataRequest.h"
#import "Organization.h"
#import "Action.h"
#import "CurrentAction.h"
#import "Occupant.h"

@interface EncounterDataProxy : BaseProxy<EncounterDataProxyProtocol>

@end
