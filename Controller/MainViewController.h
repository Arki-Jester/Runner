//
//  MainViewController.h
//  Runner
//
//  Created by Arki_Jester on 15/12/21.
//  Copyright © 2015年 Arki_Jester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
- (IBAction)startRace:(id)sender;
- (IBAction)bestRecordClick:(id)sender;
- (IBAction)aboutUsClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *bestBtn;
@property (weak, nonatomic) IBOutlet UIButton *aboutBtn;

@end
