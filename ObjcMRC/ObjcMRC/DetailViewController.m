//
//  DetailViewController.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "DetailViewController.h"
#import "Dog.h"

@interface DetailViewController ()
@property(nonatomic, retain) Dog * gog;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gog = [[Dog alloc]init];
    _gog.name = @"Doggle";
    [_gog descriptionSelf];
    [_gog yell];
    _gog.aBlock=^(NSString * str){
        NSLog(@"%@.aBlock -> %s", str, __func__);
    }; 
    /*  每个线程(包含主线程)都有一个Runloop。对于每一个Runloop，系统会隐式创建一个Autorelease pool，这样所有的release pool会构成一个像callstack一样的一个栈式结构，在每一个Runloop结束时，当前栈顶的Autorelease pool会被销毁，这样这个pool里的每个Object会被release。
     */
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"A ani.retainCount:%lu", (unsigned long)_gog.retainCount);
    [_gog yell];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"B ani.retainCount:%lu", (unsigned long)_gog.retainCount);
    [self.gog descriptionSelf];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [_gog release];
    [super dealloc];
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
