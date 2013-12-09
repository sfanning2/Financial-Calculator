//
//  SFAnnuityCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/25/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFAnnuityCalculator : NSObject
//P: solve for
- (double)DebtForCoupon:(double)C andAnnualYield:(double)y;
//C: solve for
- (double)couponForDebt:(double)P andAnnualYield:(double)y;
//y: solve for
- (double)annualYieldForDebt:(double)P andCoupon:(double)C;


//mTNM
//F
- (id)initWithPeriods:(double)n periodsPerYear:(double)m;
@property (assign) double m;//m:periods per year
@property (assign) double n;//n:periods; M = n*m

@end
