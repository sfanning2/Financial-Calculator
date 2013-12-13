//
//  SFVentureCapitalViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFVentureCapitalViewController.h"
#import "SFInvestment.h"
#import "SFVentureCapitalCalculator.h"
#import "SFResultTableViewController.h"
@interface SFVentureCapitalViewController ()

@end

@implementation SFVentureCapitalViewController
{
    NSArray *investmentRounds;
    NSMutableArray *mutableInvestmentRounds;
    NSArray *investmentRoundResults;
    UITextField *selectedTextField;
    NSString *timeToTermText;
    NSString *terminalPERText;
    NSString *terminalNetIncomeText;
    NSString *startingSharesText;
    NSString *optionsPoolPercentText;
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
    investmentRounds = @[];
    mutableInvestmentRounds = [[NSMutableArray alloc] init];
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

#pragma mark - text field related
- (void)readTextFields
{
    timeToTermText = [_timeToTermTextField text];
    terminalPERText = [_terminalPERTextField text];
    terminalNetIncomeText = [_terminalNetIncomeTextField text];
    startingSharesText = [_startingSharesTextField text];
    optionsPoolPercentText = [_optionsPoolPercentTextField text];
}

- (BOOL)validateTextFields
{
    [self readTextFields];

    if ([timeToTermText length] <= 0) {
        // throw error
        // Please specify the time to term
        [self alert:@"Please specify the time to term."];
        return NO;
    }
    
    if ([terminalPERText length] <= 0) {
        // throw error
        [self alert:@"Please specify the terminal PER."];
        return NO;
    }
    
    if ([terminalNetIncomeText length] <= 0) {
        // throw error
        [self alert:@"Please specify the terminal net income."];
        return NO;
    }
    
    if ([startingSharesText length] <= 0) {
        // throw error
        [self alert:@"Please specify the number of starting shares."];
        return NO;
    }
    
    return YES;
}


#pragma mark - alert
- (void)alert:(NSString *)message title:(NSString *)title
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [theAlert show];
}

- (void)alert:(NSString *)errorMessage
{
    [self alert:errorMessage title:@"Error"];
}

#pragma mark - IBActions and Segues

- (IBAction)addInvestmentRound:(id)sender
{
    [self performSegueWithIdentifier:@"AddRound" sender:self];
}

- (IBAction)submit:(id)sender
{
    if ([self validateTextFields])
    {
        // Perform calculations
        SFVentureCapitalCalculator *calc;
        calc = [[SFVentureCapitalCalculator alloc] initWithTimeToTerm:[timeToTermText doubleValue]
                                                              termPER:[terminalPERText doubleValue]
                                                        termNetIncome:[terminalNetIncomeText doubleValue]
                                                       startingShares:[startingSharesText integerValue]
                                                     investmentRounds:investmentRounds];
        investmentRoundResults = [[calc investmentRounds] copy];
        // Segue to Results
        [self performSegueWithIdentifier:@"DisplayRoundList" sender:self];
    }
}

- (IBAction)clearRounds:(id)sender
{
    [mutableInvestmentRounds removeAllObjects];
    investmentRounds = @[];
    self.roundsLabel.text = [self investmentRoundText];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddRound"])
    {
        SFInvestmentRoundViewController *dest = segue.destinationViewController;
        dest.investmentDelegate = self;
        
    }
    else if ([segue.identifier isEqualToString:@"DisplayRoundList"])
    {
        SFResultTableViewController *dest = segue.destinationViewController;
        dest.investments = investmentRoundResults;
        
    }
}

#pragma mark - SFInvestmentDelegate

- (void)addInvestmentRound:(double)amount requiredIRR:(double)requiredIRR startTime:(double)startTime
{
    SFInvestment *inv = [[SFInvestment alloc] initWithEntryTime:startTime amount:amount requiredIRR:requiredIRR];
    [mutableInvestmentRounds addObject:inv];
    investmentRounds = [SFVentureCapitalCalculator sortInvestmentRounds:mutableInvestmentRounds];
    [self cancel];
    self.roundsLabel.text = [self investmentRoundText];
}

- (void)cancel
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    selectedTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - keyboard
- (void)dismissKeyboard
{
    if (selectedTextField)
    {
        [selectedTextField resignFirstResponder];
    }
}
#pragma mark - label
- (NSString *)investmentRoundText
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int j = 0; j < [investmentRounds count]; j++) {
        SFInvestment *inv = [investmentRounds objectAtIndex:j];
        [string appendFormat:@"Round %d Entry: %.0f Amount %.2f ROI %.2f\n",j+1,inv.entryTime,inv.amount,inv.requiredIRR];
    }
    return string;
}
    

@end
