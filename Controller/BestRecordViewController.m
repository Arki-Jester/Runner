//
//  BestRecordViewController.m
//  Runner
//
//  Created by Arki_Jester on 15/12/21.
//  Copyright © 2015年 Arki_Jester. All rights reserved.
//

#import "BestRecordViewController.h"

@interface BestRecordViewController ()

@end

@implementation BestRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
    NSString *path = [arr objectAtIndex:0];
    NSString *pStr = [path stringByAppendingString:@"/data.txt"];
    
    NSData *data1=[NSData dataWithContentsOfFile:pStr];
    NSString *stage=[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    if (stage == nil) {
        stage = @"0";
    }
    self.bestRecordLabel.text = [NSString stringWithFormat:@"Stage %@",stage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
