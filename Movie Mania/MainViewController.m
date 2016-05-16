//
//  MainViewController.m
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "MainViewController.h"
#import "CellViewMain.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Mania";
  //  self.searchTextField.delegate = self;
    self.
    self.movieListArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.aMovie = [[Movie alloc]init];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self getJson];
    [self.searchTextField resignFirstResponder];


//    [tableView reloadData];  //tableview not a recognised object?
    
    return YES;
}

//- (NSURL *)urlComposer:(NSString *)title{
//    
//    NSString *common = @"http://www.omdbapi.com/?t=";
//    NSString *titleWithPlus = title;
//    
//    NSRange replaceRange = [title rangeOfString:@" "];
//    if (replaceRange.location != NSNotFound){
//        titleWithPlus = [titleWithPlus stringByReplacingOccurrencesOfString:@" " withString:@"+"];
//    }
//    
//    NSString *secondURL = [common stringByAppendingString:titleWithPlus];
//    NSString *thirdURL = [secondURL stringByAppendingString:@"&y=&plot=short&r=json"];
//    
//    NSURL *finalUrl = [NSURL URLWithString:thirdURL];
//
//    return finalUrl;
//}

-(void)getJson{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
   
  

    NSString *apiAddress = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=json",self.searchTextField.text];
    
    NSURL *titleUrl = [NSURL URLWithString:apiAddress];
    
    self.session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:titleUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                /// if (httpResp.statusCode == 200) {
              NSError *jsonError;
            
                NSDictionary *omdbJSON =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                self.movieListArray =  [[NSMutableArray alloc]init];
                if   (jsonError){
                    dispatch_async(dispatch_get_main_queue(), ^{
               
                        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Movie not found!, please correct title" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                        }];
                        [myAlert addAction:ok];
                        [myAlert addAction:cancel];
                        [self presentViewController:myAlert animated:YES completion:nil];
                         });
                    }else{
                        Movie *bMovie = [[Movie alloc]init];
                    bMovie.title = omdbJSON[@"Title"];
                    bMovie.posterName = omdbJSON[@"Poster"];
                    bMovie.genre = omdbJSON[@"Genre"];
                    bMovie.director = omdbJSON[@"Director"];
                    bMovie.runtime = omdbJSON[@"Runtime"];
                    bMovie.rated = omdbJSON[@"Rated"];
                    bMovie.releaseDate = omdbJSON[@"Released"];
                    bMovie.shortPlot = omdbJSON[@"Plot"];
                    NSURL *posterUrl = [NSURL URLWithString:bMovie.posterName];
                    UIImage *posterImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:posterUrl]];
                        bMovie.posterImage = posterImage;
                    
                    [self.movieListArray addObject:bMovie];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [self.tableView reloadData];
                          });
                }
           //}
        }
    }];
    
    
    
    [dataTask resume];
                                      
}

#pragma tableveiew delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.movieListArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
  
    CellViewMain *cell = (CellViewMain *)[tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    Movie *cMovie = [self.movieListArray objectAtIndex:row];

    
    cell.titleLabel.text = [NSString stringWithFormat:@"Title: %@", cMovie.title];
    cell.ratedLabel.text = [NSString stringWithFormat:@"Ratings: %@", cMovie.rated];
    cell.genreLabel.text = [NSString stringWithFormat:@"Genre: %@", cMovie.genre];
    cell.imageView.image  = cMovie.posterImage;
    cell.releaseLabel.text = [NSString stringWithFormat:@"Release Date: %@", cMovie.genre];
    return cell;
}


 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 //call performseguemethod on main instance and the sender is nil
 [self performSegueWithIdentifier:@"toDetailSegue" sender:nil];
     
 
 }


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
     DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
     NSIndexPath *newPath = [self.tableView indexPathForSelectedRow];
 
     Movie *dMovie = self.movieListArray[newPath.row];
     
     dvc.eMovie  = dMovie;
     
}
@end
