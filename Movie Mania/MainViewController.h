//
//  MainViewController.h
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (strong, nonatomic) Movie *aMovie;
@property (strong, nonatomic) NSMutableArray *movieListArray;
@end
