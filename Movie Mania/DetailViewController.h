//
//  DetailViewController.h
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) Movie *eMovie;
@property (weak, nonatomic) IBOutlet UIImageView *posterLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;

- (IBAction)addToMustWatch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *plotLabel;

@end
