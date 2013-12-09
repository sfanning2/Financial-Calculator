//
//  SFCashFlowViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/26/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFCashFlowViewController.h"

@interface SFCashFlowViewController ()

@end

@implementation SFCashFlowViewController

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
    if (_cashFlowDelegate != nil) {
        [_cashFlowDelegate addCashFlow:[[_valueTextField text] doubleValue]
                                  time:[[_timeTextField text] intValue]
                           repetitions:[[_repeatTextField text] intValue]];
    }
}

- (IBAction)cancel:(id)sender
{
    if (_cashFlowDelegate != nil) {
        [_cashFlowDelegate cancel];
    }
}

@end
