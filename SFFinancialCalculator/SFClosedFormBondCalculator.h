//
//  SFClosedFormBondCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/25/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFClosedFormBondCalculator : NSObject

//P: solve for
- (double)bondPriceForCouponPayment:(double)C andAnnualYield:(double)y;
//C: solve for
- (double)couponPaymentForBondPrice:(double)P andAnnualYield:(double)y;
//y: solve for
- (double)annualYieldForBondPrice:(double)P andCouponPayment:(double)C;


//mTNM
//F
- (id)initWithFaceValue:(double)F periods:(double)n periodsPerYear:(double)m;
@property (assign) double m;//m:periods per year
@property (assign) double n;//n:periods; M = n*m
@property (assign) double F;//facevalue
@end
