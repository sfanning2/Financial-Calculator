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
	self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.contentView.bounds];
	self.hostView.allowPinchScaling = YES;
	[self.contentView addSubview:self.hostView];
    NSLog(@"%@", self.contentView);
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
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	[self configureXAxis:x];
	CGFloat xMax = [self.labelSource getXCount];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:xMax];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:xMax];
	NSInteger i = 0;
    for (i = 0; i < xMax; i ++)
    {
        NSString *text =[self.labelSource labelOnXAxisForIndex:i];
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:text textStyle:x.labelTextStyle];
//        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:@"a" textStyle:x.labelTextStyle];
        label.tickLocation = CPTDecimalFromCGFloat((CGFloat)[ text doubleValue]);
        label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:(CGFloat)i]];
		}
    }
//	for (NSString *year in [[CPDStockPriceStore sharedInstance] datesInMonth]) {
//		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:year  textStyle:x.labelTextStyle];
//		CGFloat location = i++;
//		label.tickLocation = CPTDecimalFromCGFloat(location);
//		label.offset = x.majorTickLength;
//		if (label) {
//			[xLabels addObject:label];
//			[xLocations addObject:[NSNumber numberWithFloat:location]];
//		}
//	}
	x.axisLabels = xLabels;
	x.majorTickLocations = xLocations;
    
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	[self configureYAxis:y];
	
	CGFloat yMax = [self.labelSource getYMaxValue];//700.0f;  // should determine dynamically based on max price [self.labelSource getYMaxValue];//
    NSInteger majorIncrement = 100;//100 //yMax / 10
	NSInteger minorIncrement = 50;//FIIIIXX
    NSLog(@"%f",yMax);
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
	for (NSInteger j = minorIncrement; j <= (yMax + majorIncrement); j += minorIncrement) {
		NSUInteger mod = j % majorIncrement;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations;
}


-(void)configureXAxis:(CPTAxis *)x
{
    x.title = @"Time (Years)";
	x.titleTextStyle = [self getAxisTitleStyle];
	x.titleOffset = 20.0f;
    x.labelOffset = 5.0f;
	x.axisLineStyle = [self getAxisLineStyle];
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = [self getAxisTextStyle];
	x.majorTickLineStyle = [self getAxisLineStyle];
	x.majorTickLength = 1.0f;
	x.tickDirection = CPTSignNegative;
    x.labelRotation = M_PI_2;
    x.minorTickLabelRotation = M_PI_2;
}

-(void)configureYAxis:(CPTAxis *)y
{
    y.title = @"Price";
	y.titleTextStyle = [self getAxisTitleStyle];
	y.titleOffset = -40.0f;
	y.axisLineStyle = [self getAxisLineStyle];
	y.majorGridLineStyle = [self getGridLineStyle];
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = [self getAxisTextStyle];
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = [self getAxisLineStyle];
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;
	y.tickDirection = CPTSignPositive;
}

-(CPTMutableTextStyle *)getAxisTextStyle
{
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
    return axisTextStyle;
}

-(CPTMutableTextStyle *)getAxisTitleStyle
{
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
    return axisTitleStyle;
}

- (CPTMutableLineStyle *)getAxisLineStyle
{
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
    return axisLineStyle;
}

- (CPTMutableLineStyle *)getGridLineStyle
{
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	gridLineStyle.lineColor = [CPTColor blackColor];
	gridLineStyle.lineWidth = 1.0f;
    return gridLineStyle;
}

- (CPTMutableLineStyle *)getTickLineStyle
{
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
    return tickLineStyle;
}

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(BOOL)shouldAutorotate {
    return ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft);
}
#pragma mark - Dismissal
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
