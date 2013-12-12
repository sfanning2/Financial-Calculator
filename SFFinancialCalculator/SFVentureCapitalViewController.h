//
//  SFVentureCapitalViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFInvestmentRoundViewController.h"
@interface SFVentureCapitalViewController : UIViewController <UITextFieldDelegate, SFInvestmentDelegate>
/** noon blank; numerical */
@property (nonatomic, weak) IBOutlet UITextField *timeToTermTextField;
/** non blank; numerical */
@property (nonatomic, weak) IBOutlet UITextField *terminalPERTextField;
/** non blank; numerical */
@property (nonatomic, weak) IBOutlet UITextField *terminalNetIncomeTextField;
/** non zero */
@property (nonatomic, weak) IBOutlet UITextField *startingSharesTextField;
/** any number or blank */
@property (nonatomic, weak) IBOutlet UITextField *optionsPoolPercentTextField;

@property (nonatomic, weak) IBOutlet UILabel *roundsLabel;

- (IBAction)addInvestmentRound:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)clearRounds:(id)sender;
@end
