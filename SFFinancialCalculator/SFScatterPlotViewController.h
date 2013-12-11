//
//  SFScatterPlotViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/8/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "SFCashFlowDataSource.h"

@interface SFScatterPlotViewController : UIViewController
@property (nonatomic,strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) CPTGraphHostingView *hostView;
@property (nonatomic, strong) SFCashFlowDataSource<CPTPlotDataSource> *dataSource;

@property (nonatomic, strong) SFCashFlowDataSource<SFLabelSource> *labelSource; //TODO axislabels from here?


//TODO
@property (nonatomic, strong) NSString *graphTitle;


- (IBAction)back:(id)sender;
@end
