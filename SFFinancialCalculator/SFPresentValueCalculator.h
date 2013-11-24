//
//  SFPresentValueCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFPresentValueCalculator : NSObject
// Generic
- (double)presentValueOfCashFlows:(NSArray *)cashFlows withParams:(NSDictionary *)params;
// Specific (y is the nominal annual yield)
// Multiple cash flows
- (double)presentValueOfCashFlows:(NSArray *)cashFlows forYield:(double)y withPeriodsPerYear:(double)m andTotalPeriods:(int)M;
// PV
- (double)presentValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// FV
- (double)futureValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
// Calculating y
// Multiple cash flows
- (double)annualYieldOfCashFlows:(NSArray *)cashFlows withPV:(double)P withPeriodsPerYear:(double)m andTotalPeriods:(int)M;
// Single amount
- (double)annualYieldOf:(NSNumber *)amount withPV:(double)P withPeriodsPerYear:(double)m andTotalCompounds:(int)M;



@end
