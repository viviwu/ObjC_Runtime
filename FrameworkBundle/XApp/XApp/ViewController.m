//
//  ViewController.m
//  XApp
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "ViewController.h"
#import "XDrawView.h"
#include <math.h>
#import <Photos/Photos.h>

#if TARGET_FLAG         /*1*/
    #import <DynamicXKit/DynamicXKit.h>
#else
    #import <XKit/XKit.h>
#endif


@interface ViewController ()
@property (strong, nonatomic) XDrawView *drawView;
@property (strong, nonatomic) UIImage * image;

@property (strong, nonatomic) PHAssetCollection * createCollection;
@end

@implementation ViewController

//CSCOblue 0.05, 0.35, 0.65
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TARGET_FLAG == %d", TARGET_FLAG);
    //Dynamic Library
    //Static Library
    //Setting >Other Linker Flags> -ObjC
    
    _drawView = [[XDrawView alloc]initWithFrame:CGRectMake(0, 100, kScreenW, kScreenW)];
    _drawView.backgroundColor = [UIColor colorWithRed:0.05 green:0.40 blue:0.70 alpha:0.99];
    [self.view addSubview:_drawView];
    
    
    XGridView * grid = [[XGridView alloc]initWithFrame:CGRectMake(10, 500, 150, 200)];
    grid.imageView.image = [NSBundle xImageNamed:@"photos"];
    grid.titleLabel.text = @"XGridView";
    grid.rightSubLabel.text = @"right";
    grid.leftSubLabel.text = @"left";
    [self.view addSubview:grid];
     
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _drawView.redo = YES;
    [_drawView setNeedsDisplay];
}

- (IBAction)generateImageToSave:(id)sender {
    
    UIImage * image = [_drawView generateImageFromCurrentContext];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

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
