//
//  DetailViewController.h
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@protocol DetailViewControllerDelegate<NSObject>

-(void)returnMustWatch:(Movie *)myMustWatch;

@end


@interface DetailViewController : UIViewController
@property (strong, nonatomic) Movie *eMovie;
@property (strong, nonatomic) NSMutableArray *moviesArray;
@property (weak, nonatomic) IBOutlet UIImageView *posterLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (nonatomic, weak)id<DetailViewControllerDelegate>delegate;
@property (assign, nonatomic) NSIndexPath *indexPath;

- (IBAction)addToMustWatch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *plotLabel;

@end
