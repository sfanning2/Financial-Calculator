//
//  SFCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCalculator : NSObject
//- (NSNumber *)annuityWithNominalAnnualYield:(NSNumber *)y andCouponRate:(NSNumber *)C;
// (NSNumber *)presentValueOfCashFlows:(NSArray *)cashFlows forYield:(NSNumber *)nominalAnnualYield with;
- (NSNumber *)presentValueAnnualYieldforCashFlows:(NSArray *)cashFlows forPresentValue:(NSNumber *)presentValue;

@end
