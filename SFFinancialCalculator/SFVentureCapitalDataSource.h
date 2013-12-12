//
//  SFVentureCapitalDataSource.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/12/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"
#import "SFLabelSource.h"
#import "SFInvestment.h"
#import "SFVentureCapitalCalculator.h"
#import "SFPresentValueCalculator.h"

@interface SFVentureCapitalDataSource : NSObject <CPTPlotDataSource, SFLabelSource>
@property (nonatomic, copy) NSArray *investments;
// Other info
@end
