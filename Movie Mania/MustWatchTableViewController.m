//
//  MustWatchTableViewController.m
//  Movie Mania
//
//  Created by MBPinTheAir on 16/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "MustWatchTableViewController.h"
#import "MustWatchTableViewCell.h"

@interface MustWatchTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MustWatchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mustWatchNowArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MustWatchTableViewCell *cell = (MustWatchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mustWatchCell" forIndexPath:indexPath];
    Movie *gMovie = [[Movie alloc]init];
    
    
    NSInteger row = indexPath.row;
    
    Movie *cMovie = [self.mustWatchNowArray objectAtIndex:row];
    gMovie = cMovie;
    
    cell.titleLabel.text = [NSString stringWithFormat:@"Title: %@", gMovie.title];
    cell.imageView.image  = gMovie.posterImage;
    cell.releaseLabel.text = [NSString stringWithFormat:@"Release Date: %@", gMovie.releaseDate];
    return cell;
}

//-(void)setMustWatchNowArray:(NSMutableArray *)mustWatchNowArray{
//    if (mustWatchNowArray == nil) {
//        self.mustWatchNowArray = mustWatchNowArray;
//    }
//}


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
