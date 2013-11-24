//
//  SFPresentValueCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFPresentValueCalculator.h"

@implementation SFPresentValueCalculator

// Specific (y is the nominal annual yield)
// Multiple cash flows
- (double)presentValueOfCashFlows:(NSArray *)cashFlows forYield:(double)y withPeriodsPerYear:(double)m andTotalPeriods:(int)M
{
    double presentValue = 0.0;
    for (int i = 0; i < [cashFlows count]; i++) {
        // Sum up the PV of each cash flow
        NSNumber *currentFlow = [cashFlows objectAtIndex:i];
        presentValue += [self presentValueOf:currentFlow forYield:y withPeriodsPerYear:m andTotalCompounds:i];
    }
    return presentValue;
}

// PV
- (double)presentValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M
{
    double C = [amount doubleValue];
    double denominator = pow((1.0 + y/m), M);
    return C/denominator;
}

// FV
- (double)futureValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M
{
    double C = [amount doubleValue];
    double term = pow((1.0 + y/m), M);
    return C * term;
}

// Calculating y
// Multiple cash flows
- (double)annualYieldOfCashFlows:(NSArray *)cashFlows withPV:(double)P withPeriodsPerYear:(double)m andTotalPeriods:(int)M
{
    // y = -m * (P/C)^(-1/M) * [(P/C)^(1/M) - 1]
    return 0.0;
}

// Single amount
- (double)annualYieldOf:(NSNumber *)amount withPV:(double)P withPeriodsPerYear:(double)m andTotalCompounds:(int)M
{
    // y = -m * (P/C)^(-1/M) * [(P/C)^(1/M) - 1]
    double C = [amount doubleValue];
    return -m * pow(P/C, -1.0/M) * (pow(P/C, 1.0/M) - 1);
}
// Repeated Amount
// P = C/(1 + y/m)^x
// =m(P/CM)^(-1/M) * ((P/CM)^(1/M) - 1)
@end
