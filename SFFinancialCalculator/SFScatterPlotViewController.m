//
//  SFScatterPlotViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/8/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFScatterPlotViewController.h"

@interface SFScatterPlotViewController ()

@end

@implementation SFScatterPlotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initPlot];
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
	self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	self.hostView.allowPinchScaling = YES;
	[self.view addSubview:self.hostView];
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	[graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
	self.hostView.hostedGraph = graph;
	// 2 - Set graph title
	NSString *title = @"Cash Flows";
	graph.title = title;
	// 3 - Create and set text style
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor whiteColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
	// 4 - Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft:30.0f];
	[graph.plotAreaFrame setPaddingBottom:30.0f];
	// 5 - Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots {
	// 1 - Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	// 2 - Create the plots
	CPTScatterPlot *sumPlot = [[CPTScatterPlot alloc] init];
	sumPlot.dataSource = self.dataSource;
	sumPlot.identifier = @"SUM";
	CPTColor *sumColor = [CPTColor redColor];
	[graph addPlot:sumPlot toPlotSpace:plotSpace];
    
    NSMutableArray *plots = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.dataSource.cashFlows count]; i++) {
        CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];
        plot.dataSource = self.dataSource;
        plot.identifier = [NSString stringWithFormat:@"%d",i];
        [graph addPlot:plot toPlotSpace:plotSpace];
        [plots addObject:plot];
    }
    CPTColor *flowColor = [CPTColor greenColor];
    

	// 3 - Set up plot space
    NSMutableArray *allPlots = [NSMutableArray arrayWithArray:plots];
    [allPlots addObject:sumPlot];
	[plotSpace scaleToFitPlots:allPlots];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
	plotSpace.yRange = yRange;
    
	// 4 - Create styles and symbols
    CPTMutableLineStyle *sumLineStyle = [sumPlot.dataLineStyle mutableCopy];
    sumLineStyle.lineWidth = 2.5;
    sumLineStyle.lineColor = sumColor;
    sumPlot.dataLineStyle = sumLineStyle;
    CPTMutableLineStyle *sumSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    sumSymbolLineStyle.lineColor = sumColor;
    CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:sumColor];
    aaplSymbol.lineStyle = sumSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(6.0f, 6.0f);
    sumPlot.plotSymbol = aaplSymbol;
    
    for (CPTScatterPlot *plot in plots){
        CPTMutableLineStyle *lineStyle = [plot.dataLineStyle mutableCopy];
        lineStyle.lineWidth = 1;
        lineStyle.lineColor = flowColor;
        plot.dataLineStyle = lineStyle;
        CPTMutableLineStyle *flowSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        flowSymbolLineStyle.lineColor = flowColor;
        CPTPlotSymbol *flowSymbol = [CPTPlotSymbol diamondPlotSymbol];
        flowSymbol.fill = [CPTFill fillWithColor:flowColor];
        flowSymbol.lineStyle = flowSymbolLineStyle;
        flowSymbol.size = CGSizeMake(3.0f, 3.0f);
        plot.plotSymbol = flowSymbol;
    }

}

-(void)configureAxes {
	// 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 1.0f;
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.title = @"Time (Years)";
	x.titleTextStyle = axisTitleStyle;
	x.titleOffset = 15.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
//	CGFloat dateCount = [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
//	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
//	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
//	NSInteger i = 0;
//	for (NSString *date in [[CPDStockPriceStore sharedInstance] datesInMonth]) {
//		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
//		CGFloat location = i++;
//		label.tickLocation = CPTDecimalFromCGFloat(location);
//		label.offset = x.majorTickLength;
//		if (label) {
//			[xLabels addObject:label];
//			[xLocations addObject:[NSNumber numberWithFloat:location]];
//		}
//	}
//	x.axisLabels = xLabels;
//	x.majorTickLocations = xLocations;
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.title = @"Price";
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -40.0f;
	y.axisLineStyle = axisLineStyle;
	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;
	y.tickDirection = CPTSignPositive;
	NSInteger majorIncrement = 100;
	NSInteger minorIncrement = 50;
	CGFloat yMax = 700.0f;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
//	for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
//		NSUInteger mod = j % majorIncrement;
//		if (mod == 0) {
//			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
//			NSDecimal location = CPTDecimalFromInteger(j);
//			label.tickLocation = location;
//			label.offset = -y.majorTickLength - y.labelOffset;
//			if (label) {
//				[yLabels addObject:label];
//			}
//			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
//		} else {
//			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
//		}
//	}
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations;
}


#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
