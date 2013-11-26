//
//  SFPresentValueViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/22/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFPresentValueViewController : UIViewController <UITextFieldDelegate>
@property (weak) IBOutlet UITextField *presentValue;
@property (weak) IBOutlet UITextField *futureValue;
@property (weak) IBOutlet UITextField *annualInterestRate;//i or y
@property (weak) IBOutlet UITextField *numberOfTimesCompounded;//M = n*f
@property (weak) IBOutlet UITextField *interestPeriods;//n
@property (weak) IBOutlet UITextField *compoundingFrequency;//m or f
@property (weak) IBOutlet UIButton *submit;
@property (weak) IBOutlet UILabel *tempOutput;

@property (weak) IBOutlet UISwitch *repeatCF;


- (IBAction)submit:(id)sender;
@end
