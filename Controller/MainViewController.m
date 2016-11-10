//
//  MainViewController.m
//  Runner
//
//  Created by Arki_Jester on 15/12/21.
//  Copyright © 2015年 Arki_Jester. All rights reserved.
//
#define ScreenWidth     CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight    CGRectGetHeight([UIScreen mainScreen].bounds)
#import "MainViewController.h"
#import "GameViewController.h"
#import "BestRecordViewController.h"
#import "AboutUsViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    imageView.image = [UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:imageView];

    [self setupButtonStyle:self.startBtn];
    [self setupButtonStyle:self.bestBtn];
    [self setupButtonStyle:self.aboutBtn];
}
- (void)setupButtonStyle:(UIButton *)btn{
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = 5;
}

- (IBAction)startRace:(id)sender {
    
    GameViewController *vc = [[GameViewController alloc]init];
    UINavigationController *nc=[[UINavigationController alloc]initWithRootViewController:vc];

    [self presentViewController:nc animated:YES completion:nil];
}

- (IBAction)bestRecordClick:(id)sender {
    BestRecordViewController *bestVC = [[BestRecordViewController alloc]init];
    [self.navigationController pushViewController:bestVC animated:YES];
}

- (IBAction)aboutUsClick:(id)sender {
    AboutUsViewController *vc = [[AboutUsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
