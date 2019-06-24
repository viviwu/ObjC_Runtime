//
//  ViewController.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    NSString *str = [[NSString alloc] init];
    [str retain];
    str = @"jxl";
    [str release]; //指向常量区的对象不能release。
    */
    
    Animal * ani = [[Animal alloc]init];
    ani.name = @"Mon key";
    ani.age = 2;
    ani.weight= 3.6;
    [ani descriptionSelf];
    [ani yell];
    [ani release];
    // Do any additional setup after loading the view.
    /*
#if 0
    @autoreleasepool {
        for (int i=0; i<100000; i++) {
            Animal * anim = [[Animal alloc]init];
            [anim autorelease];
            //难以立即释放 在循环结束前可能会造成内存溢出的问题
        }
    }
    
#else
    @autoreleasepool {
        for (int i=0; i<100000; i++) {
            @autoreleasepool {
                Animal * anim = [[Animal alloc]init];
                [anim autorelease];
            }
        }
    }
#endif
     */
}

- (void)dealloc
{
    [super dealloc];
}

@end
