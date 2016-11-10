//
//  GameViewController.m
//  Runner
//
//  Created by Arki_Jester on 15/12/21.
//  Copyright © 2015年 Arki_Jester. All rights reserved.
//
#define ScreenWidth     CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight    CGRectGetHeight([UIScreen mainScreen].bounds)
#import "AJ_UIView+QuickSize.h"
#import "GameViewController.h"

@interface GameViewController ()<UIAlertViewDelegate>
{
    UIView *_runner;
    UIView *_opponent;
    UILabel *_countLabel;
    NSInteger _count;
    UIView *_backView;
    NSTimer *_runnerTimer;
    NSTimer *_opponentTimer;
    NSTimer *_countTimer;
    float _opponentV;
    NSInteger _stage;
}
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _stage = 1;
    self.title = [NSString stringWithFormat:@"stage %zd",_stage];
    _count = 3;
    _opponentV = 0.1;
    [self setRunner];
    [self setButtons];
}
- (void)setRunner
{
    UIView *oppotent = [[UIView alloc]initWithFrame:CGRectMake(0, 150, 20, 20)];
    oppotent.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:oppotent];
    _opponent = oppotent;
    
    UIView *runner = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 20, 20)];
    runner.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:runner];
    _runner = runner;
}
- (void)setButtons
{
    UIButton *tapBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, ScreenHeight-70, (ScreenWidth-40), 50)];
    tapBtn.layer.cornerRadius = 5;
    tapBtn.layer.borderWidth = 0.5;
    tapBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:tapBtn];
    [tapBtn setTitle:@"Tap me" forState:UIControlStateNormal];
    [tapBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [tapBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];


    UIView *backView = [[UIView alloc]initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [self.view addSubview:backView];
    _backView = backView;
    
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    countLabel.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    countLabel.backgroundColor = [UIColor whiteColor];
    countLabel.layer.cornerRadius = 50;
    countLabel.clipsToBounds = YES;
    [self.view addSubview:countLabel];
    countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel = countLabel;
    countLabel.text = @"Ready!";
    
   _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countNumber) userInfo:nil repeats:YES];

}
- (void)countNumber
{

    if (_count != 0) {
        _countLabel.text = [NSString stringWithFormat:@"%zd",_count];
        _count --;
    }else{
        [_countTimer invalidate];
        _backView.hidden = YES;
        _countLabel.hidden = YES;
       _opponentTimer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(oppotentRun) userInfo:nil repeats:YES];
        [_countTimer invalidate];
        _count = 3;
    }
}
- (void)click
{
    _runner.x +=2.5;
    if (_runner.x > ScreenWidth - 20) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"You win" delegate:nil cancelButtonTitle:@"Next race" otherButtonTitles:nil, nil];
        alert.delegate = self;
        alert.tag = 101;
        [alert show];
        [_opponentTimer invalidate];
    }
}
- (void)oppotentRun
{
    _opponent.x += _opponentV;
    if (_opponent.x > ScreenWidth - 20) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"You lose" delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles:@"Quit", nil];
        alert.delegate = self;
        alert.tag = 102;
        [alert show];
        [_opponentTimer invalidate];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101) {//next race
        
        _opponentV += 0.1;
        
        _countLabel.text = @"Ready!";
        _backView.hidden = NO;
        _countLabel.hidden = NO;
        _runner.x=0;
        _opponent.x =0;
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countNumber) userInfo:nil repeats:YES];
        _stage ++;
        self.title = [NSString stringWithFormat:@"stage %zd",_stage];
        
        [self saveBestRecordWithStage:(NSInteger)_stage];

    }
    else
    {
        if (buttonIndex == 0) {//try again
            NSLog(@"count=%zd",_count);
            _countLabel.text = @"Ready!";
            _backView.hidden = NO;
            _countLabel.hidden = NO;
            _runner.x=0;
            _opponent.x =0;
            _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countNumber) userInfo:nil repeats:YES];
        }
        else//quit
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
- (void)saveBestRecordWithStage:(NSInteger)stage
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
    NSString *path = [arr objectAtIndex:0];
    NSString *pStr = [path stringByAppendingString:@"/data.txt"];
    
    
    NSData *data1=[NSData dataWithContentsOfFile:pStr];
    NSString *oldStage=[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    if (stage > [oldStage intValue]) {
        NSString *string = [NSString stringWithFormat:@"%zd",stage];
        NSData *data=[[NSData alloc]init];
        data=[NSKeyedArchiver archivedDataWithRootObject:string];
        [data writeToFile:pStr atomically:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
