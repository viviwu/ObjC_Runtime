//
//  ViewController.m
//  XApp
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "ViewController.h"

#if TARGET_FLAG         /*1*/
    #import <DynamicXKit/DynamicXKit.h>
#else
    #import <XKit/XKit.h>
#endif


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TARGET_FLAG == %d", TARGET_FLAG);
    //Dynamic Library
    //Static Library
    
    //Setting >Other Linker Flags> -ObjC
    XibView * ibv = [[XibView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    ibv.textLabel.text = @"ibv.textLabel.text";
    ibv.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:ibv];
    
    // Do any additional setup after loading the view.
}


@end
