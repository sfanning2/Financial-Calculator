//
//  SFVentureCapitalCalculator.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFInvestment.h"

@interface SFVentureCapitalCalculator : NSObject
/** Ex. 5 years */
@property double timeToTerm;
/** Ex. 15 */
@property double termPER;
/** Ex. 2.5 million */
@property double termNetIncome;
/** Ex: 1,000,000 */
@property double startingShares;
/** Investment Rounds */
@property (nonatomic, copy) NSArray *investmentRounds; // not copied

/** optional */
@property double optionsPoolPercentageOfProjectedTotalShares;

/** Basic constructor 
 Set exit times of rounds here too
 */
- (id)initWithTimeToTerm:(double)timeToTerm
                   termPER:(double)termPER
             termNetIncome:(double)termNetIncome
            startingShares:(double)startingShares
                    investmentRounds:(NSArray *)investmentRounds;



+(NSArray *)sortInvestmentRounds:(NSArray *)investmentRounds;

@end
