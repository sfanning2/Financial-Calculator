//
//  SFCashFlowViewController.h
//  SFFinancialCalculator
//
//  Created by Sarah Fanning on 11/26/13.
//  Copyright (c) 2013 University of Nebraska - Lincoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFCashFlowDelegate <NSObject>
- (void) addCashFlow:(double)value time:(int)time repetitions:(int)repetitions;
- (void) cancel;
@end

@interface SFCashFlowViewController : UIViewController 
@property (weak) IBOutlet UITextField *valueTextField; //F
@property (weak) IBOutlet UITextField *timeTextField; //t
@property (weak) IBOutlet UITextField *repeatTextField; //n
@property (nonatomic, weak) id<SFCashFlowDelegate> cashFlowDelegate;
- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;
@end



