//
//  SFCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFCalculator.h"

@implementation SFCalculator
+ (double)newtonRaphson:(double (^)(double))function derivative:(double (^)(double))derivative initialGuess:(double)x
{
    double xOld;
    int count = 0;
    while (count < 10000 && !(x - xOld < 0.000001 && x - xOld >= 0) && !(x - xOld > -0.000001 && x - xOld <= 0)) {
        xOld = x;
        x = x - function(x)/derivative(x);
        count++;
    }
    //return x_n+1 = x_n - f_x/f'_x
    return x;
}
@end
