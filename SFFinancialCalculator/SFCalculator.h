//
//  SFCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCalculator : NSObject

+ (double)newtonRaphson:(double (^)(double))function derivative:(double (^)(double))derivative initialGuess:(double)x;

@end
