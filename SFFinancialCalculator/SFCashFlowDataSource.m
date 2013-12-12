//
//  SFCashFlowDataSource.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/8/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFCashFlowDataSource.h"
#import "SFPresentValueCalculator.h"

@implementation SFCashFlowDataSource
{
    SFPresentValueCalculator *calc;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        calc = [[SFPresentValueCalculator alloc]init];
    }
    return self;
}

- (id)initWithCashFlows:(NSArray *)cashFlows annualYield:(double)annualYield years:(double)years periodsPerYear:(double)periodsPerYear
{
    self = [super init];
    if (self)
    {
        calc = [[SFPresentValueCalculator alloc]init];
        _cashFlows = cashFlows;
        _annualYield = annualYield;
        _years = years;
        _periodsPerYear = periodsPerYear;
    }
    return self;
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return _years * _periodsPerYear + 1; //Might want this to change more....
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // The value ar the index for the field
	NSInteger valueCount = _years * _periodsPerYear + 1; //plus 1 for zero position
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
            // Time axis
			if (index < valueCount) {
                // The x-axis shows years
				return [NSNumber numberWithDouble:(double)index/_periodsPerYear];
			}
			break;
			
		case CPTScatterPlotFieldY:
			if ([plot.identifier isEqual:@"SUM"] == YES) {
                double valueAtIndex = [self getSUMValueAtIndex:index];
                return [NSNumber numberWithDouble:valueAtIndex];
                break;
            }
            else
            {
                // Assume integer?
                NSInteger flowIndex = [(NSString *)plot.identifier integerValue];
                if (index < flowIndex) {
                    // No point yet
                    return 0; // or nothing?
                }
                else if (index >= valueCount)
                {
                    return 0; // or nothing?
                }
                else
                {
                    int compounds = (int)index - (int)flowIndex;
                    NSNumber *flowValue = [_cashFlows objectAtIndex:flowIndex];
                    double value = [calc futureValueOf:flowValue forYield:_annualYield withPeriodsPerYear:_periodsPerYear andTotalCompounds:compounds];
                    NSLog(@"%f", value);
                    return [NSNumber numberWithDouble:value];
                }
                break;
            }
	}
	return [NSDecimalNumber zero];
}

-(double)getSUMValueAtIndex:(NSUInteger)index
{
    NSArray *relevantCashFlows = [_cashFlows subarrayWithRange:NSMakeRange (0, index + 1)];//include the current index
    // Not sure if right...
    double value =  [calc presentValueOfCashFlows:relevantCashFlows forYield:_annualYield withPeriodsPerYear:_periodsPerYear];
    double valueAtIndex = [calc futureValueOf:[NSNumber numberWithDouble:value] forYield:_annualYield withPeriodsPerYear:_periodsPerYear andTotalCompounds:((int)index)];
    NSLog(@"Present sum:%f", value);
    NSLog(@"Future sum:%f", valueAtIndex);
    return valueAtIndex;
}

#pragma mark - label protocol thing

-(NSString *)labelOnXAxisForIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%.2f",((double)index / _periodsPerYear)];
}

-(NSString *)labelOnYAxisForIndex:(NSUInteger)index
{
    return nil;
}

-(NSUInteger)getXCount
{
    return [_cashFlows count];
}

-(NSUInteger)getYCount
{
    return [self getXCount];
}

-(NSUInteger)getYMaxValue
{
    return [self getSUMValueAtIndex:([self getYCount] - 1)];
}



-(NSString *)getPlotTitle {return @"Cash Flows";}
-(NSString *)getXAxisTitle; {return @"Time (Years)";}
-(NSString *)getYAxisTitle; {return @"Value";}

@end
