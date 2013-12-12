//
//  SFInvestmentRoundViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFInvestmentRoundViewController.h"

@interface SFInvestmentRoundViewController ()

@end

@implementation SFInvestmentRoundViewController

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


- (IBAction)submit:(id)sender
{
    if (_investmentDelegate != nil) {
        [_investmentDelegate addInvestmentRound:[[_investmentAmountTextField text] doubleValue]
                                    requiredIRR:[[_requiredIRRTextField text] doubleValue]
                                      startTime:[[_startTimeTextfield text] doubleValue]];
    }
}

- (IBAction)cancel:(id)sender
{
    if (_investmentDelegate != nil) {
        [_investmentDelegate cancel];
    }
}

@end
