//
//  SFVentureCapitalDataSource.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/12/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFVentureCapitalDataSource.h"

@implementation SFVentureCapitalDataSource
#pragma mark - SFLabelSource
- (NSString *)getPlotTitle
{
    return @"Venture Capital Plot";
}
- (NSString *)getXAxisTitle
{
    return @"Time (Years)";
}
- (NSString *)getYAxisTitle
{
    return @"Required Investment Value";
}
- (NSString *)labelOnXAxisForIndex:(NSUInteger)index
{
    return nil;
}
- (NSString *)labelOnYAxisForIndex:(NSUInteger)index
{
    return nil;
}
- (NSUInteger)getXCount
{
    return 0;
}
- (NSUInteger)getYCount
{
    return 0;
}
- (NSUInteger)getYMaxValue
{
    return 0;
}


#pragma mark - CPTPlotDataSource
//-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
//{
//    return nil;
//}
//-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
//{
//    return 0;
//}
//-(NSArray *)numbersForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange
//{
//    
//}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    SFInvestment *inv;
//    if ([plot.identifier isEqual:@"SUM"]) {
//        //Max number...
//        inv = [_investments objectAtIndex:0];
//    } else {
//        NSUInteger index = [self getIndexFromPlotIdentifier:plot];
//        inv = [_investments objectAtIndex:index]; //Maybeeee?
//    }
    inv = [_investments objectAtIndex:0];
	return inv.exitTime - inv.entryTime; //Might want this to change more....
}

-(NSArray *)numbersForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange
{
    // An array of values. indicate relevant ones....
    return nil;
}

#pragma mark - Other stuff
-(double)getSUMValueAtIndex:(NSUInteger)index
{
//    NSArray *relevantCashFlows = [_cashFlows subarrayWithRange:NSMakeRange (0, index + 1)];//include the current index
//    // Not sure if right...
//    double value =  [calc presentValueOfCashFlows:relevantCashFlows forYield:_annualYield withPeriodsPerYear:_periodsPerYear];
//    double valueAtIndex = [calc futureValueOf:[NSNumber numberWithDouble:value] forYield:_annualYield withPeriodsPerYear:_periodsPerYear andTotalCompounds:((int)index)];
//    NSLog(@"Present sum:%f", value);
//    NSLog(@"Future sum:%f", valueAtIndex);
//    return valueAtIndex;
    return 0;
}

-(NSUInteger)getIndexFromPlotIdentifier:(CPTPlot *)plot
{
    return [(NSString *)plot.identifier integerValue];
}

@end
