//
//  SFClosedFormBondViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/23/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFClosedFormBondViewController : UIViewController <UITextFieldDelegate>
// F
@property (weak) IBOutlet UITextField *faceValueTextField; //F
// 2/3
@property (weak) IBOutlet UITextField *bondPriceTextField; //P
@property (weak) IBOutlet UITextField *couponPaymentTextField;//C
@property (weak) IBOutlet UITextField *annualInterestRateTextField;//y
// 2/4
@property (weak) IBOutlet UITextField *numberOfTimesCompoundedTextField;//M = n*f
@property (weak) IBOutlet UITextField *interestPeriodsTextField;//n
@property (weak) IBOutlet UITextField *compoundingFrequencyTextField;//m or f
@property (weak) IBOutlet UITextField *timeToTermTextField;//T
// button
@property (weak) IBOutlet UIButton *button;
- (IBAction)submitForm:(id)sender;

@end
