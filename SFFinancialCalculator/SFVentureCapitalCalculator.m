//
//  SFVentureCapitalCalculator.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFVentureCapitalCalculator.h"
#import "SFPresentValueCalculator.h"

@implementation SFVentureCapitalCalculator
{
    SFPresentValueCalculator *pvCalc;
}

- (id)initWithTimeToTerm:(double)timeToTerm
                 termPER:(double)termPER
           termNetIncome:(double)termNetIncome
          startingShares:(double)startingShares
        investmentRounds:(NSArray *)investmentRounds
{
    self = [super init];
    if (self)
    {
        _timeToTerm = timeToTerm;
        _termPER = termPER;
        _termNetIncome = termNetIncome;
        _startingShares = startingShares;
        _investmentRounds = [self sortInvestmentRounds:investmentRounds];
        for (SFInvestment * investment in _investmentRounds)
        {
            investment.exitTime = timeToTerm;
            investment.requiredFutureValueAtExit = [self requiredFutureValueAtExitForInvestment:investment];
            investment.finalPercentOwnership = [self finalOwnershipRequiredForInvestment:investment];
        }
        NSUInteger oldShares = startingShares;
        for (NSUInteger i = 0; i < [_investmentRounds count]; i++)
        {
            SFInvestment * investment = (SFInvestment *)[_investmentRounds objectAtIndex:i];
            investment.retentionPercent = [self retentionPercentForInvestment:i];
            investment.currentPercentOwnership = [self currentPercentOwnershipForInvestment:investment];
            investment.newShares = [self newSharesForInvestment:investment withOldShares:oldShares];
            investment.totalShares = oldShares + investment.newShares;
            oldShares = investment.totalShares;
            investment.currentSharePrice = investment.amount / (double) investment.newShares;
        }
        pvCalc = [[SFPresentValueCalculator alloc] init];
    }
    return self;
}

-(NSArray *)sortInvestmentRounds:(NSArray *)investmentRounds
{
    NSArray *sortedArray;
    sortedArray = [investmentRounds sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        double first = [(SFInvestment*)a entryTime];
        double second = [(SFInvestment*)b entryTime];
        return first - second;
    }];
    return sortedArray;
}

- (double)totalTerminalValue
{
    return _termPER * _termNetIncome;
}

- (double)finalOwnershipRequiredForInvestment:(SFInvestment *)investment
{
    return investment.requiredFutureValueAtExit/[self totalTerminalValue];
}

- (double)requiredFutureValueAtExitForInvestment:(SFInvestment *)investment
{
    int compounds = round(investment.exitTime - investment.entryTime);
    double result =[pvCalc futureValueOf:[NSNumber numberWithDouble:investment.amount] forYield:investment.requiredIRR withPeriodsPerYear:1 andTotalCompounds:compounds];
    return result;
}

-(double)retentionPercentForInvestment:(NSUInteger)investmentIndex
{
    double sum = 0.0;
    for (NSUInteger i = ++investmentIndex; i < [_investmentRounds count]; i++) {
        SFInvestment *inv = (SFInvestment *)[_investmentRounds objectAtIndex:i];
        sum += inv.finalPercentOwnership;
    }
    return 1.0 - sum;
}

-(double)currentPercentOwnershipForInvestment:(SFInvestment *)investment
{
    return investment.finalPercentOwnership / investment.retentionPercent;
}

-(NSUInteger)newSharesForInvestment:(SFInvestment *)investment withOldShares:(NSUInteger)oldShares
{
    NSUInteger shares = investment.currentPercentOwnership
    / (1.0 - investment.currentPercentOwnership)
    * oldShares;
    return shares;
}

@end
