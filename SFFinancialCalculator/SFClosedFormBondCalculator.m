//
//  SFClosedFormBondCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/25/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFClosedFormBondCalculator.h"
#import "SFCalculator.h"
@implementation SFClosedFormBondCalculator


- (id)initWithFaceValue:(double)F periods:(int)n periodsPerYear:(double)m
{
    self = [self init];
    if (self)
    {
        _F = F;
        _n = n;
        _m = m;
    }
    return self;
}
//F
//P: solve for
- (double)bondPriceForCouponPayment:(double)C andAnnualYield:(double)y
{
    double term = pow((1 + y/_m),((double)_n * _m));
    return C * (1/(y/_m) - 1/(y/_m * term)) + _F/term;
}
//C: solve for
- (double)couponPaymentForBondPrice:(double)P andAnnualYield:(double)y
{
    double term = pow((1 + y/_m),((double)_n * _m));
    return  (P - _F/term) / (1/(y/_m) - 1/(y/_m * term));
}
//y: solve for
- (double)annualYieldForBondPrice:(double)P andCouponPayment:(double)C
{
    // Given a y
    double (^function)(double) = ^ double (double y){
        double x = y/_m;
        double term = pow((1 + x),((double)_n * _m));
        return P * x * term - C * term - _F * x + C;
    };
    double (^derivative)(double) = ^ double (double y){
        double x = y/_m;
        double M = ((double)_n * _m);
        double term = pow((1 + x), M);
        double termD = pow((1 + x), (M - 1.0)) * M / _m;
        return P * term / _m + P * termD - C * termD - _F/_m;
    };
    return [SFCalculator newtonRaphson:function derivative:derivative initialGuess:0.5];
}


@end
