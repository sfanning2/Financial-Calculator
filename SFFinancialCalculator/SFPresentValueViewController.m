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
    
    PV = [pVText doubleValue];
    FV = [fVText doubleValue];
    y = [yText doubleValue];
    
    
    M = [MText intValue];
    m = [mText doubleValue];
    n = [nText intValue];
    // Calculate missing value...
    M = ([MText length] == 0) ? n*m : M;
    m = ([mText length] == 0) ? (double)M/(double)n : m;
    n = ([nText length] == 0) ? M/m : n;
    
    SFPresentValueCalculator *calc = [[SFPresentValueCalculator alloc]init];
    if ([pVText length] == 0 )
    {
        // Compute PV
        PV = [calc presentValueOf:[NSNumber numberWithDouble:FV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
    }
    else if ([fVText length] == 0)
    {
        // Compute FV
        FV = [calc futureValueOf:[NSNumber numberWithDouble:PV] forYield:y withPeriodsPerYear:m andTotalCompounds:M];
    }
    else if ([yText length] == 0)
    {
        // Compute y
        y = [calc annualYieldOf:[NSNumber numberWithDouble:FV] withPV:PV withPeriodsPerYear:m andTotalCompounds:M];
    }
    
    //self.tempOutput
    _tempOutput.text = [NSString stringWithFormat:@"TEST%f",PV];
    [self updateFields];
}

- (void)updateFields
{
    _presentValue.text = [NSString stringWithFormat:@"%f",PV];
    _futureValue.text = [NSString stringWithFormat:@"%f",FV];
    _numberOfTimesCompounded.text = [NSString stringWithFormat:@"%d",M];
    _compoundingFrequency.text = [NSString stringWithFormat:@"%f",m];
    _annualInterestRate.text = [NSString stringWithFormat:@"%f",y];
    _interestPeriods.text = [NSString stringWithFormat:@"%d",n];
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
