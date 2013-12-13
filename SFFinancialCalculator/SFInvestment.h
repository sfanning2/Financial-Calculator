//
//  SFInvestment.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

// Sort by entry time
@interface SFInvestment : NSObject
@property double entryTime;

/** Amount in billions */
@property double amount;
/** The ROI */
@property double requiredIRR;

/* externally set properties */
@property double exitTime;
/* calculated properties */
@property NSUInteger newShares;
@property NSUInteger totalShares;//Maybe
@property double currentPercentOwnership;
@property double finalPercentOwnership;
@property double retentionPercent;
@property double currentSharePrice;
@property (nonatomic) double requiredFutureValueAtExit;

//- (double)requiredFutureValueAtExit:(double)exitTime;
//- (double)finalOwnerShipRequiredGiveTerminalValue:(double)terminalValue andExitTime:(double)exitTime;



- (id)initWithEntryTime:(double)entryTime amount:(double)amount requiredIRR:(double)requiredIRR;

/* Sorting code

 NSArray *sortedArray;
 sortedArray = [drinkDetails sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
 double *first = [(SFInvestment*)a entryTime];
 double *second = [(SFInvestment*)b entryTime];
 return [first compare:second];
 }];
 
 */
@end
