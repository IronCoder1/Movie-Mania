//
//  DetailViewController.m
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger row = [_indexPath row];
    Movie *dMovie = [self.moviesArray objectAtIndex:row];
    
    self.eMovie  = dMovie;
    
    self.title = self.eMovie.title;
    
    self.titleLabel.text = [NSString stringWithFormat:@"Title: %@", self.eMovie.title];
   
    self.genreLabel.text = [NSString stringWithFormat:@"Genre: %@", self.eMovie.genre];
    self.posterLabel.image  = self.eMovie.posterImage;
    self.directorLabel.text = [NSString stringWithFormat:@"Director: %@", self.eMovie.director];
    self.runtimeLabel.text = [NSString stringWithFormat:@"Runtime: %@", self.eMovie.runtime];
    
//    NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
//    self.releaseLabel.text = [NSString stringWithFormat:@"Release Date: %@",[dateformater stringFromDate:self.eMovie.releaseDate]];
    
    self.releaseLabel.text = [NSString stringWithFormat:@"Release Date: %@",self.eMovie.releaseDate];
    self.plotLabel.text = [NSString stringWithFormat:@"Plot: %@", self.eMovie.shortPlot];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToMustWatch:(id)sender {
    
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Add Movie" message:@"Add To Must Watch?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         [self.delegate returnMustWatch:self.eMovie];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [myAlert addAction:ok];
    [myAlert addAction:cancel];
    [self presentViewController:myAlert animated:YES completion:nil];
    
    
    
}
@end
