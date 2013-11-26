//
//  SFPresentValueCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFPresentValueCalculator.h"
#import "SFCalculator.h"

@implementation SFPresentValueCalculator

// Specific (y is the nominal annual yield)
// Multiple cash flows
- (double)presentValueOfCashFlows:(NSArray *)cashFlows forYield:(double)y withPeriodsPerYear:(double)m andTotalPeriods:(int)M
{
    double presentValue = 0.0;
    for (int i = 1; i <= [cashFlows count]; i++) {
        // Sum up the PV of each cash flow
        NSNumber *currentFlow = [cashFlows objectAtIndex:(i-1)];
        presentValue += [self presentValueOf:currentFlow forYield:y withPeriodsPerYear:m andTotalCompounds:i];
    }
    return presentValue;
}

// PV
- (double)presentValueOf:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M
{
    double C = [amount doubleValue];
    double denominator = pow((1.0 + y/m), (double)M);
    return C/denominator;
}

- (double)presentValueOfRepeatedCashFlows:(NSNumber *)amount forYield:(double)y withPeriodsPerYear:(double)m andTotalCompounds:(int)M;
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < M; i ++) {
        [array addObject:amount];
    }
    return [self presentValueOfCashFlows:array forYield:y withPeriodsPerYear:m andTotalPeriods:M];
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
    // Given a y
    double (^function)(double) = ^ double (double y){
        double presentValue = [self presentValueOfCashFlows:cashFlows forYield:y withPeriodsPerYear:m andTotalPeriods:M];
        return presentValue - P;
    };
    double (^derivative)(double) = ^ double (double y){
        
        double expression = 0.0;
        for (int i = 1; i <= [cashFlows count]; i++) {
            // Sum up the PV of each cash flow
            NSNumber *currentFlow = [cashFlows objectAtIndex:(i-1)];
            expression += (-1.0 *(double)i ) *[self presentValueOf:currentFlow forYield:y withPeriodsPerYear:m andTotalCompounds:(i)];
        }
        return expression / (m + y);
    };
    return [SFCalculator newtonRaphson:function derivative:derivative initialGuess:0.001];
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
- (double)annualYieldOfRepeatedCashFlow:(NSNumber *)amount withPV:(double)P withPeriodsPerYear:(double)m andTotalCompounds:(int)M
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < M; i ++) {
        [array addObject:amount];
    }
    return [self annualYieldOfCashFlows:array withPV:P withPeriodsPerYear:m andTotalPeriods:M];
}
@end
