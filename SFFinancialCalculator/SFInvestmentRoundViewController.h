//
//  SFInvestmentRoundViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/11/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFInvestmentDelegate <NSObject>
- (void) addInvestmentRound:(double)amount requiredIRR:(double)requiredIRR startTime:(double)startTime;
- (void) cancel;
@end

@interface SFInvestmentRoundViewController : UIViewController
@property (weak) IBOutlet UITextField *investmentAmountTextField; //F
@property (weak) IBOutlet UITextField *requiredIRRTextField; //t
@property (weak) IBOutlet UITextField *startTimeTextfield; //n
@property (nonatomic, weak) id<SFInvestmentDelegate> investmentDelegate;
- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;
@end
