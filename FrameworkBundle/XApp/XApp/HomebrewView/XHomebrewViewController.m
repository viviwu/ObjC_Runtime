//
//  XHomebrewViewController.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XHomebrewViewController.h"

@interface XHomebrewViewController ()

@property (strong, nonatomic) XCaptchaView * captchaView;
@end

@implementation XHomebrewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.feature;
    // Do any additional setup after loading the view.
    
    if ([self.feature isEqualToString:@"LoadNib"]) {
        XGridView * grid = [[XGridView alloc]initWithFrame: CGRectMake(10, 100, 150, 200)];
        grid.imageView.image = [NSBundle xImageNamed:@"photos"];
        grid.titleLabel.text = @"XGridView";
        grid.rightSubLabel.text = @"right";
        grid.leftSubLabel.text = @"left";
        [self.view addSubview:grid];
    }else if([self.feature isEqualToString:@"Captcha"]){
        _captchaView = [[XCaptchaView alloc]initWithFrame:CGRectMake(20, 100, 200, 80)];
        [self.view addSubview:_captchaView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_captchaView addGestureRecognizer:tap];
    }
    
}


- (void)tapClick:(UITapGestureRecognizer*)tap{
    [_captchaView changeCaptcha];
    NSLog(@"captcha == %@", _captchaView.captcha);
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
