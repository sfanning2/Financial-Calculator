//
//  SFAnnuityCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/25/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFAnnuityCalculator.h"
#import "SFCalculator.h"

@implementation SFAnnuityCalculator
- (id)initWithPeriods:(double)n periodsPerYear:(double)m
{
    self = [self init];
    if (self)
    {
        _n = n;
        _m = m;
    }
    return self;
}

//P: solve for
- (double)DebtForCoupon:(double)C andAnnualYield:(double)y
{
    // P = Cm/y *(1 - (1 + y/m)^-M)
    return (C * _m / y) * (1 - pow(1+y/_m, -(double)_n * _m));
}

//C: solve for
- (double)couponForDebt:(double)P andAnnualYield:(double)y
{
    return (P * y / _m) / (1 - pow(1+y/_m, -(double)_n * _m));
}

//y: solve for
- (double)annualYieldForDebt:(double)P andCoupon:(double)C
{
    // Given a y
    double M = _m * (double)_n;
    double (^function)(double) = ^ double (double y){
        
        return C * _m * (pow(1 + y/_m, -M) - 1) + P * y;
    };
    double (^derivative)(double) = ^ double (double y){
        
        return P - C * M * pow(1 + y / _m, -M - 1);
    };
    return [SFCalculator newtonRaphson:function derivative:derivative initialGuess:0.5];
}
@end
