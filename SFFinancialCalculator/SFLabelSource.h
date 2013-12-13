//
//  SFLabelSource.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/12/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SFLabelSource
-(NSString *)getPlotTitle;
-(NSString *)getXAxisTitle;
-(NSString *)getYAxisTitle;
-(NSString *)labelOnYAxisForIndex:(NSUInteger)index;
-(NSString *)labelOnXAxisForIndex:(NSUInteger)index;
-(NSUInteger)getXCount;
-(NSUInteger)getYCount;
-(NSUInteger)getYMaxValue;
@end
