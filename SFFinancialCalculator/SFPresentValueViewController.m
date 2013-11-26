//
//  SFPresentValueViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFPresentValueViewController.h"
#import "SFPresentValueCalculator.h"

@interface SFPresentValueViewController ()

@end

@implementation SFPresentValueViewController
{
    double PV;
    double FV;
    double y;//i or y
    int M;//M = n*f
    double m;//m or f
    int n;
    
}

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
    [_futureValue resignFirstResponder];
    [_numberOfTimesCompounded resignFirstResponder];
    [_compoundingFrequency resignFirstResponder];
    [_annualInterestRate resignFirstResponder];
    [_interestPeriods resignFirstResponder];
}

- (IBAction)submit:(id)sender
{
    //Read input
    NSString * pVText = [_presentValue text];
    NSString * fVText = [_futureValue text];
    NSString * MText = [_numberOfTimesCompounded text];
    NSString * mText = [_compoundingFrequency text];
    NSString * nText = [_interestPeriods text];
    NSString *yText = [_annualInterestRate text];

    // Deal with mnMT
    int count = 0;
    if ([MText length] != 0) count++;
    if ([mText length] != 0) count++;
    if ([nText length] != 0) count++;
    
    if (count < 2) {
        // Problem
        // Please supply at least 2 of mnMT
        [self alert:@"Please supply at least two of mnMT!"];
        return;
    }
    
    M = [MText intValue];
    n = [nText intValue];
    m = [mText doubleValue];
    
    // Calculate missing values
    M = ([MText length] == 0) ? n*m : M;
    m = ([mText length] == 0) ? (double)M/(double)n : m;
    n = ([nText length] == 0) ? M/m : n;
    
    //
    
    PV = [pVText doubleValue];
    y = [yText doubleValue];
    // M must equal array
    NSArray *flows = [fVText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([flows count] != 1 && [flows count] != M) {
        [self alert:@"Problem with flow input."]; return;
    }
    FV = [fVText doubleValue];
    
    
    // Check repetition
    BOOL repeat = _repeatCF.on;
    
    SFPresentValueCalculator *calc = [[SFPresentValueCalculator alloc]init];
    if ([pVText length] == 0 && [fVText length] > 0 && [yText length] > 0)
    {
        // Compute PV
        if (repeat)
        {
            PV = [calc presentValueOfRepeatedCashFlows:[NSNumber numberWithDouble:FV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
        }
        else
        {
            if ([flows count] == 1) {
                PV = [calc presentValueOf:[NSNumber numberWithDouble:FV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
            }
            else if ([flows count] > 0){
                PV = [calc presentValueOfCashFlows:flows forYield:y withPeriodsPerYear:m andTotalPeriods:M];
            } else {[self alert:@"Problem with flows."]; return;};
        }
        _presentValue.text = [NSString stringWithFormat:@"%f",PV];
            }
    else if ([fVText length] == 0 && [pVText length] > 0 && [yText length] > 0)
    {
        // Compute FV
        FV = [calc futureValueOf:[NSNumber numberWithDouble:PV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
        _futureValue.text = [NSString stringWithFormat:@"%f",FV];
    }
    else if ([yText length] == 0 && [fVText length] > 0 && [pVText length] > 0)
    {
        // Compute y
        
        if (repeat)
        {
            y = [calc annualYieldOfRepeatedCashFlow:[NSNumber numberWithDouble:FV] withPV:PV withPeriodsPerYear:m andTotalCompounds:M];
        }
        else
        {
            if ([flows count] == 1) {
                // Normal
                y = [calc annualYieldOf:[NSNumber numberWithDouble:FV] withPV:PV withPeriodsPerYear:m andTotalCompounds:M];
            }
            else if ([flows count] > 0){
                y = [calc annualYieldOfCashFlows:flows withPV:PV withPeriodsPerYear:m andTotalPeriods:M];
            } else {[self alert:@"Problem with flow input."]; return;};
        }
        _annualInterestRate.text = [NSString stringWithFormat:@"%f",y];
    }
    else
    {
        [self alert:@"Please leave one and only one of P, C, or y blank."];
    }


}

- (void)alert:(NSString *)message
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [theAlert show];
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
/*
 – textFieldShouldBeginEditing:
 – textFieldDidBeginEditing:
 – textFieldShouldEndEditing:
 – textFieldDidEndEditing:
*/
/*
 – textField:shouldChangeCharactersInRange:replacementString:
 – textFieldShouldClear:
 – textFieldShouldReturn:
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
