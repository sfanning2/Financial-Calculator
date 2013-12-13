//
//  SFCashFlowDataSource.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/8/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"
#import "SFLabelSource.h"

@interface SFCashFlowDataSource : NSObject <CPTPlotDataSource, SFLabelSource>
@property (nonatomic, strong) NSArray *cashFlows;
@property (nonatomic, assign) double annualYield;
@property (nonatomic, assign) double years;
@property (nonatomic, assign) double periodsPerYear;

- (id)initWithCashFlows:(NSArray *)cashFlows annualYield:(double)annualYield years:(double)years periodsPerYear:(double)periodsPerYear;
@end
