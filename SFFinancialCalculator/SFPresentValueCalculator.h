//
//  SFPresentValueCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFPresentValueCalculator : NSObject

// Specific (y is the nominal annual yield)
// Multiple cash flows
- (double)presentValueOfCashFlows:(NSArray *)cashFlows forYield:(double)y withPeriodsPerYear:(double)m;
- (double)presentValueOfRepeatedCashFlows:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// PV
- (double)presentValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// FV
- (double)futureValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// Calculating y
// Multiple cash flows
- (double)annualYieldOfCashFlows:(NSArray *)cashFlows withPV:(double)P withPeriodsPerYear:(double)m;
- (double)annualYieldOfRepeatedCashFlow:(NSNumber *)amount withPV:(double)P withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// Single amount
- (double)annualYieldOf:(NSNumber *)amount withPV:(double)P withPeriodsPerYear:(double)m andTotalCompounds:(int)M;



@end
