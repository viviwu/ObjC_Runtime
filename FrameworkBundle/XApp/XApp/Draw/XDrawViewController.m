//
//  XDrawViewController.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//
#import <Photos/Photos.h>
#import <QuartzCore/QuartzCore.h>

#import "XDrawViewController.h"
#import "XUnitWordView.h"
#import "XBezierDrawView.h"
#import "XCoreGraphicsDrawView.h"

@interface XDrawViewController ()

@property (strong, nonatomic) UIView* drawView;
@property (strong, nonatomic) PHAssetCollection * createCollection;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CALayer       *greenLayer;
@property (nonatomic, strong) CAShapeLayer  *redLayer;

@end
static CGFloat count;

@implementation XDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.feature;
    NSLog(@"TARGET_FLAG == %d", TARGET_FLAG);
    
    if ([self.feature isEqualToString:@"UIBezierPath"]) {
        _drawView = [[XBezierDrawView alloc]initWithFrame: CGRectMake(0, 100, kScreenW, kScreenW)];
        _drawView.backgroundColor = [UIColor colorWithRed:0.05 green:0.40 blue:0.70 alpha:0.99];
    }else if ([self.feature isEqualToString:@"CGContext"]){
        _drawView = [[XCoreGraphicsDrawView alloc]initWithFrame: CGRectMake(0, 100, kScreenW, kScreenH-100)];
        _drawView.backgroundColor = UIColor.whiteColor;
    }else if ([self.feature isEqualToString:@"UnitWord"]){
        _drawView = [[XUnitWordView alloc]initWithFrame: CGRectMake(0, 100, kScreenW, kScreenH-100)];
        _drawView.backgroundColor = UIColor.blackColor;
    }else{
        /**CAShapeLayer+UIBezierPath
        CAShapeLayer *shapeLayer = ({
            CGRect rect = CGRectMake(0, 0, kScreenW/2, kScreenW/2);
            UIBezierPath * bezierOvalPath = [UIBezierPath bezierPathWithOvalInRect: rect];
            CAShapeLayer *circle = [CAShapeLayer layer];
            circle.bounds        = rect;
            circle.position      = self.view.center;
            circle.path          = bezierOvalPath.CGPath;
            circle.strokeColor   = [UIColor redColor].CGColor;
            
            circle.fillColor     = [UIColor yellowColor].CGColor;
            circle.lineWidth     = 10;          //设置线宽
            circle.lineCap       = @"round";    //设置线头形状
            circle.strokeStart     = 0.25;
            circle.strokeEnd     = 0.75;        //设置轮廓结束位置
            
            circle;
        });
        [self.view.layer addSublayer:shapeLayer];
         **/
        count = 10;
        self.greenLayer = ({
            
            CALayer *layer        = [CALayer layer];
            layer.bounds          = CGRectMake(0, 0, 200, 45);
            layer.position        = self.view.center;
            layer.backgroundColor = [UIColor greenColor].CGColor;
            
            layer;
        });
        
        self.redLayer = ({
            
            CAShapeLayer *layer   = [CAShapeLayer layer];
            layer.bounds          = CGRectMake(0, 0, 200, 45);
            layer.position        = self.view.center;
            layer.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, count / 6 * 2, 45)].CGPath;
            layer.fillColor       = [UIColor redColor].CGColor;
            layer.fillRule        = kCAFillRuleEvenOdd;
            
            layer;
        });
        
        [self.view.layer addSublayer:self.greenLayer];
        [self.view.layer addSublayer:self.redLayer];
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    if(_drawView) [self.view addSubview:_drawView];
    
    // Do any additional setup after loading the view.
}

- (void)action {
    count ++;
    self.redLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, count / 6 * 2, 45)].CGPath;
    
    if (count > 60 * 10 -1) {
        [self.displayLink invalidate];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.displayLink) [self.displayLink invalidate];
}

- (IBAction)generateImageToSave:(id)sender {
    
    UIImage * image = [_drawView generateImageFromCurrentContext];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}


- (void)saveImageToPhotoLibrary{
    //保存图片到【相机胶卷】
    UIImage * image = [_drawView generateImageFromCurrentContext];
    /// 异步执行修改操作
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",@"保存失败");
        } else {
            NSLog(@"%@",@"保存成功");
        }
    }];
}

//创建新的相册
- (void)createNewAlbumToPhotoLibrary{
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        //获取app名字
        NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString*)kCFBundleNameKey];
        if(!title) title= @"XApp";
        //创建一个【自定义相册】
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
    } error:&error];
}


- (void)queryAlbumFromPhotoLibrary
{
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString*)kCFBundleNameKey];
    //查询所有【自定义相册】
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType: PHAssetCollectionTypeAlbum   subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHAssetCollection *createCollection = nil;
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            createCollection = collection;
            break;
        }
    }
    __block NSString *createCollectionID = nil;
    if (createCollection == nil) {
        //当前对应的app相册没有被创建
        //创建一个【自定义相册】
        NSError *error = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            //创建一个【自定义相册】
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        } error:&error];
        
        createCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createCollectionID] options:nil].firstObject;
    }
    NSLog(@"%@",createCollection);
}

- (void)saveImageToDiyAlbum{
    // 1.先保存图片到【相机胶卷】
    /// 同步执行修改操作
    NSError *error = nil;
    __block PHObjectPlaceholder *placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        placeholder =  [PHAssetChangeRequest creationRequestForAssetFromImage:self.image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        NSLog(@"保存失败");
        return;
    }
    // 2.拥有一个【自定义相册】
    PHAssetCollection * assetCollection = self.createCollection;
    if (assetCollection == nil) {
        NSLog(@"创建相册失败");
    }
    // 3.将刚才保存到【相机胶卷】里面的图片引用到【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *requtes = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [requtes addAssets:@[placeholder]];
    } error:&error];
    if (error) {
        NSLog(@"保存图片失败");
    } else {
        NSLog(@"保存图片成功");
    }
}

- (UIImage *)image{
    return _drawView.generateImageFromCurrentContext;
}

@end
