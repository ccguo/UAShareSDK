//
//  ViewController.m
//  UAShareSDK
//
//  Created by guochaoyang on 15/12/3.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "ViewController.h"
#import "UASocialShareManager.h"
#import "UASocialSDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)share:(id)sender {
    NSArray *list = [UASocialSDK getShareListWithType:1,2,3, nil];

    [[UASocialShareManager shareInstance] shareWithModel:nil shareList:list completion:^(NSDictionary *shareInfo,BOOL result){
        NSLog(@"saasas");
    }];
}

@end
