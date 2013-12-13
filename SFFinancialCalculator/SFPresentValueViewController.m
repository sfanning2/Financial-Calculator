//
//  SFPresentValueViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFPresentValueViewController.h"
#import "SFPresentValueCalculator.h"
#import "SFCashFlowViewController.h"
#import "SFScatterPlotViewController.h"
#import "SFCashFlowDataSource.h"

@interface SFPresentValueViewController ()

@end

@implementation SFPresentValueViewController
{
    double PV;
    double y;//i or y
    int M;//M = n*f
    double m;//m or f
    double n;
    NSMutableArray *flows;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        flows = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_presentValue resignFirstResponder];
    [_numberOfTimesCompounded resignFirstResponder];
    [_compoundingFrequency resignFirstResponder];
    [_annualInterestRate resignFirstResponder];
    [_interestPeriods resignFirstResponder];
}
- (IBAction)clearFlows:(id)sender
{
    //
    flows = [[NSMutableArray alloc]init];
    _cashFlowLabel.text = @"";
    [self displayCashFlowLabel];
}

- (BOOL) readData {
    //Read input
    NSString * pVText = [_presentValue text];
    NSString * MText = [_numberOfTimesCompounded text];
    NSString * mText = [_compoundingFrequency text];
    NSString * nText = [_interestPeriods text];
    NSString *yText = [_annualInterestRate text];
    
    // Deal with mnM
    
    if ([mText length] == 0) {
        // Problem
        [self alert:@"Please supply m!"];
        return NO;
    }
    
    M = [MText intValue];
    n = [nText intValue];
    m = [mText doubleValue];
    
    // Calculate missing values
    M = ([MText length] == 0) ? n*m : M;
    m = ([mText length] == 0) ? (double)M/(double)n : m;
    n = ([nText length] == 0) ? M/m : n;
    
    // M is one less than count
    
    PV = [pVText doubleValue];
    y = [yText doubleValue];
    // M must equal array
    // Add missing flows
    for (NSUInteger i = [flows count]; i <= M; i++) {
        [flows addObject:[NSNumber numberWithDouble:0.0]];
    }
    return YES;
}
- (IBAction)submit:(id)sender
{
    //Read input
    NSString * pVText = [_presentValue text];
    NSString * MText = [_numberOfTimesCompounded text];
    NSString * mText = [_compoundingFrequency text];
    NSString * nText = [_interestPeriods text];
    NSString *yText = [_annualInterestRate text];

    // Deal with mnM
    
    if ([mText length] == 0) {
        // Problem
        // Please supply at least 2 of mnMT
        [self alert:@"Please supply m!"];
        return;
    }
    
    M = [MText intValue];
    n = [nText intValue];
    m = [mText doubleValue];
    
    // Calculate missing values
    M = ([MText length] == 0) ? n*m : M;
    m = ([mText length] == 0) ? (double)M/(double)n : m;
    n = ([nText length] == 0) ? M/m : n;
    
    // M is one less than count
    
    PV = [pVText doubleValue];
    y = [yText doubleValue];
    // M must equal array
    // Add missing flows
    for (NSUInteger i = [flows count]; i < M; i++) {
        [flows addObject:[NSNumber numberWithDouble:0.0]];
    }
    
    
    SFPresentValueCalculator *calc = [[SFPresentValueCalculator alloc]init];
    if ([pVText length] == 0 && [yText length] > 0)
    {
        // Compute PV
        PV = [calc presentValueOfCashFlows:flows forYield:y withPeriodsPerYear:m];
        _presentValue.text = [NSString stringWithFormat:@"%.4f",PV];
    }
    else if ([pVText length] > 0 && [yText length] > 0)
    {
        // Compute FV
        // TODO: display somewhere
        double FV = [calc futureValueOf:[NSNumber numberWithDouble:PV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
        NSString *fVString = [NSString stringWithFormat:@"Future value = %.4f", FV];
        [self alert:fVString title:@"Future Value"];
    }
    else if ([yText length] == 0 && [pVText length] > 0)
    {
        // Compute y
        y = [calc annualYieldOfCashFlows:flows withPV:PV withPeriodsPerYear:m];
        _annualInterestRate.text = [NSString stringWithFormat:@"%.4f",y];
    }
    else
    {
        [self alert:@"Please leave one and only one of P, C, or y blank."];
    }


}

- (IBAction)viewPlot:(id)sender
{
    // read values
    if([self readData])
        [self performSegueWithIdentifier:@"ViewScatterPlot" sender:self];
}

- (void)alert:(NSString *)errorMessage
{
    [self alert:errorMessage title:@"Error"];
}

- (void)alert:(NSString *)message title:(NSString *)title
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [theAlert show];
}

- (IBAction)addFlow:(id)sender;
{
    [self performSegueWithIdentifier:@"AddFlow" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddFlow"])
    {
        // Do something
        SFCashFlowViewController *dest = segue.destinationViewController;
        dest.cashFlowDelegate = self;
        
    }
    else if ([segue.identifier isEqualToString:@"ViewScatterPlot"])
    {
        // Do something
        SFScatterPlotViewController *dest = segue.destinationViewController;
        SFCashFlowDataSource *ds = [[SFCashFlowDataSource alloc]initWithCashFlows:flows annualYield:y years:n periodsPerYear:m];
        dest.dataSource = ds;
        dest.labelSource = ds;
    }
}

- (void) addCashFlow:(double)value time:(int)time repetitions:(int)repetitions
{
    if (flows == nil) {
        flows = [[NSMutableArray alloc]init];
    }
    // Add it
    if (repetitions == 0) {repetitions = 1;}
    for (NSUInteger i = [flows count]; i < time + repetitions; i++) {
        [flows addObject:[NSNumber numberWithDouble:0.0]];
    }
    for (int i = time; i < time + repetitions; i++) {
        NSNumber *o =[flows objectAtIndex:i];
        [flows replaceObjectAtIndex:i withObject:[NSNumber numberWithDouble:([o doubleValue] + value)]];
    }
    
    _cashFlowLabel.text = [self cashFlowText];
    [self displayCashFlowLabel];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) cancel
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)displayCashFlowLabel
{
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:_cashFlowLabel.font forKey: NSFontAttributeName];
    
    CGSize expectedLabelSize = [_cashFlowLabel.text boundingRectWithSize:_cashFlowLabel.frame.size
                                                                 options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:stringAttributes context:nil].size;
    _cashFlowLabel.frame = CGRectMake(
                                      _cashFlowLabel.frame.origin.x, _cashFlowLabel.frame.origin.y,
                                      _cashFlowLabel.frame.size.width, expectedLabelSize.height);
}

- (NSString *)cashFlowText
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int j = 0; j < [flows count]; j++) {
        [string appendFormat:@"%d: %.4f\n",j,[[flows objectAtIndex:j] doubleValue]];
    }
    return string;
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
