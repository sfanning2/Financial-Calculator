//
//  SFRoundDetailsViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 12/12/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFInvestment.h"

@interface SFRoundDetailsViewController : UIViewController

@property (nonatomic, strong) SFInvestment *investment;
@property NSUInteger roundNumber;


@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *theNewSharesTextField;
@property (nonatomic, weak) IBOutlet UITextField *totalCurrentSharesTextField;
@property (nonatomic, weak) IBOutlet UITextField *currentPercentOwnershipTextField;
@property (nonatomic, weak) IBOutlet UITextField *finalPercentOwnershipTextField;
@property (nonatomic, weak) IBOutlet UITextField *sharePriceTextField;

- (IBAction)back:(id)sender;
@end
