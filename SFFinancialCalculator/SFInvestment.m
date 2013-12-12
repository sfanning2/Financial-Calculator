//
//  SFInvestment.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFInvestment.h"

@implementation SFInvestment
//@synthesize requiredFutureValueAtExit = _requiredFutureValueAtExit;

- (id)initWithEntryTime:(double)entryTime amount:(double)amount requiredIRR:(double)requiredIRR
{
    self = [super init];
    if (self)
    {
        _entryTime = entryTime;
        _amount = amount;
        _requiredIRR = requiredIRR;
    }
    return self;
}

//- (double)requiredFutureValueAtExit
//{
//    if (_requiredFutureValueAtExit == 0.0) {
//        _requiredFutureValueAtExit =
//    }
//}
//
//- (void)setRequiredFutureValueAtExit:(double)requiredFutureValueAtExit
//{
//    _requiredFutureValueAtExit = requiredFutureValueAtExit;
//}

@end
