//
//  MustWatchTableViewController.h
//  Movie Mania
//
//  Created by MBPinTheAir on 16/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MustWatchTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *mustWatchNowArray;

@property (strong, nonatomic) Movie *fMovie;

@end
