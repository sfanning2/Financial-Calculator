//
//  SFAnnuityViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/25/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFAnnuityViewController.h"
#import "SFAnnuityCalculator.h"

@interface SFAnnuityViewController ()

@end

@implementation SFAnnuityViewController
{
    NSString *_debtText;
    NSString *_couponPaymentText;
    NSString *_annualInterestRateText;
    
    NSString *_numberOfTimesCompoundedText;
    NSString *_interestPeriodsText;
    NSString *_compoundingFrequencyText;
    NSString *_timeToTermText;
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

- (IBAction)submitForm:(id)sender
{
    // Read fields
    [self readTextFields];
    // Deal with mnMT
    int count = 0;
    if ([_numberOfTimesCompoundedText length] != 0) count++;
    if ([_interestPeriodsText length] != 0) count++;
    if ([_compoundingFrequencyText length] != 0) count++;
    
    if (count < 2) {
        // Problem
        // Please supply at least 2 of mnMT
        [self alert:@"Please supply at least two of mnMT!"];
        return;
    }
    
    int M = [_numberOfTimesCompoundedText intValue];
    int n = [_interestPeriodsText intValue];
    double m = [_compoundingFrequencyText doubleValue];
    //double T = [_timeToTermText doubleValue];//????
    // compute from each other
    M = ([_numberOfTimesCompoundedText length] == 0) ? n*m : M;
    m = ([_compoundingFrequencyText length] == 0) ? (double)M/(double)n : m;
    n = ([_interestPeriodsText length] == 0) ? M/m : n;
    
    
    
    SFAnnuityCalculator *calc = [[SFAnnuityCalculator alloc] initWithPeriods:n periodsPerYear:m];
    // Deal with PCy
    if ([_debtText length] == 0 && [_couponPaymentText length] > 0 && [_annualInterestRateText length] > 0) {
        // Calc P
        double P = [calc DebtForCoupon:[_couponPaymentText doubleValue] andAnnualYield:[_annualInterestRateText doubleValue]];
        // Display P
        _debtTextField.text = [NSString stringWithFormat:@"%.2f",P];
    }
    else if ([_couponPaymentText length] == 0 && [_debtText length] > 0 && [_annualInterestRateText length] > 0) {
        // C
        double C = [calc couponForDebt:[_debtText doubleValue] andAnnualYield:[_annualInterestRateText doubleValue]];
        // Display C
        _couponPaymentTextField.text = [NSString stringWithFormat:@"%.2f",C];
    }
    else if ([_annualInterestRateText length] == 0 && [_couponPaymentText length] > 0 && [_debtText length] > 0) {
        // y
        double y = [calc annualYieldForDebt:[_debtText doubleValue] andCoupon:[_couponPaymentText doubleValue]];
        // Display P
        _annualInterestRateTextField.text = [NSString stringWithFormat:@"%.4f",y];
    } else {
        // Bad
        // Please leave one and only one of P, C, or y blank.
        [self alert:@"Please leave one and only one of P, C, or y blank."];
    }
        
}

- (void)dismissKeyboard {
    for (id subView in [self.view subviews])
    {
        if ([subView isKindOfClass:[UITextField class]])
        {
            [subView resignFirstResponder];
        }
        for (id subSubView in [subView subviews])
        {
            if ([subSubView isKindOfClass:[UITextField class]])
            {
                [subSubView resignFirstResponder];
            }
        }
    }
}

- (void)readTextFields
{
    _debtText = [_debtTextField text];
    _couponPaymentText = [_couponPaymentTextField text];
    _annualInterestRateText = [_annualInterestRateTextField text];
    
    _numberOfTimesCompoundedText = [_numberOfTimesCompoundedTextField text];
    _interestPeriodsText = [_interestPeriodsTextField text];
    _compoundingFrequencyText = [_compoundingFrequencyTextField text];
    _timeToTermText = [_timeToTermTextField text];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
@end
