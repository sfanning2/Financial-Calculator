//
//  SFRoundDetailsViewController.m
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/12/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import "SFRoundDetailsViewController.h"

@interface SFRoundDetailsViewController ()

@end

@implementation SFRoundDetailsViewController

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
    if (_investment)
    {
        _titleLabel.text = [NSString stringWithFormat:@"Round %d", _roundNumber];
        _theNewSharesTextField.text = [NSString stringWithFormat:@"%d", _investment.newShares];
        _totalCurrentSharesTextField.text = [NSString stringWithFormat:@"%d",_investment.totalShares ];
        _currentPercentOwnershipTextField.text = [NSString stringWithFormat:@"%.2f%%",_investment.currentPercentOwnership * 100.0 ];
        _finalPercentOwnershipTextField.text = [NSString stringWithFormat:@"%.2f%%",_investment.finalPercentOwnership * 100.0];
        _sharePriceTextField.text = [NSString stringWithFormat:@"$%.4f",_investment.currentSharePrice ];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
