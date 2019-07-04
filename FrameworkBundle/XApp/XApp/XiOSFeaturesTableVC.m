//
//  XiOSFeaturesTableVC.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XiOSFeaturesTableVC.h"
#import "XDrawViewController.h"
#import "XHomebrewViewController.h"


#define kCellRID @"cell reuseIdentifier"
@interface XiOSFeaturesTableVC ()
@property (nonatomic, copy) NSArray * iOSFeatures;
@end

@implementation XiOSFeaturesTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS Features";
    self.iOSFeatures = @[@[@"Draw-UIBezierPath", @"Draw-CGContext", @"Draw-UnitWord", @"Draw-CAShapeLayer"], @[@"View-LoadNib", @"View-Captcha"] ];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellRID];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * features = self.iOSFeatures[indexPath.section];
    NSString * feature = features[indexPath.row];
    NSString * featureCat = [feature substringToIndex:[feature rangeOfString:@"-"].location];
    NSString * featureName = [feature substringFromIndex:[feature rangeOfString:@"-"].location+1];
//    NSString * featureCat = [feature substringToIndex:0];
    XUIViewController * xvc = nil;
    if ([featureCat isEqualToString:@"Draw"]) {
        xvc = [XDrawViewController new];
        
    }else if ([featureCat isEqualToString:@"View"]){
        xvc = [XHomebrewViewController new];
    }else{
//        xvc = [XUIViewController new];
    }
    if (xvc) {
        [xvc setValue:featureName forKey:@"feature"];
        xvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:xvc animated:YES];
    }
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.iOSFeatures.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSArray * features = self.iOSFeatures[section];
    return features.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellRID forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray * features = self.iOSFeatures[indexPath.section];
    cell.textLabel.text = features[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
