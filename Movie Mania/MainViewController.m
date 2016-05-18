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
#import "MustWatchTableViewController.h"

@interface MainViewController ()
- (IBAction)goToMustWatch:(id)sender;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Mania";
  //  self.searchTextField.delegate = self;
    self.myMustWatchArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.movieListArray = [[NSMutableArray alloc]initWithCapacity:10];
   
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

- (NSURL *)urlComposer:(NSString *)title{
    
    NSString *common = @"http://www.omdbapi.com/?t=";
    NSString *titleWithPlus = title;
    
    NSRange replaceRange = [title rangeOfString:@" "];
    if (replaceRange.location != NSNotFound){
        titleWithPlus = [titleWithPlus stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    }
    
    NSString *secondURL = [common stringByAppendingString:titleWithPlus];
    NSString *thirdURL = [secondURL stringByAppendingString:@"&y=&plot=short&r=json"];
    
    NSURL *finalUrl = [NSURL URLWithString:thirdURL];

    return finalUrl;
}

-(void)getJson{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *titleUrl = [[NSURL alloc]init];

    if ([self.searchTextField.text containsString:@" "]) {
     titleUrl = [self urlComposer:self.searchTextField.text];
    } else{
  
    
    NSString *apiAddress = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=json",self.searchTextField.text];
    
    titleUrl = [NSURL URLWithString:apiAddress];
        
    }
    self.session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:titleUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                /// if (httpResp.statusCode == 200) {
              NSError *jsonError;
            
                NSDictionary *omdbJSON =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
            
                if   (jsonError || omdbJSON[@"Title"] == nil ){
                    dispatch_async(dispatch_get_main_queue(), ^{
               
                        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Movie not found! please check title" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
                        [myAlert addAction:ok];
                        [myAlert addAction:cancel];
                        [self presentViewController:myAlert animated:YES completion:nil];
                        
                         });
                    
                    }if (!jsonError && omdbJSON[@"Title"] != nil){
                        
                        /* need to implement check on exisiting titles before adding to tableview
                         if ([omdbJSON[@"Title"] isEqualToString:bMovie.title])
                         {
                         UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Movie already checked! please scroll down" preferredStyle:UIAlertControllerStyleAlert];
                         UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                         UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
                         [myAlert addAction:ok];
                         [myAlert addAction:cancel];
                         [self presentViewController:myAlert animated:YES completion:nil];
                         }else {
                         */
                        
                        
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
     
     [self performSegueWithIdentifier:@"toDetailSegue" sender:nil];
     
 
 }

-(void)returnMustWatch:(Movie *)myMustWatch{
    
    [self.myMustWatchArray addObject:myMustWatch];
    
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.identifier isEqualToString:@"toDetailSegue"]) {
         DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
         NSIndexPath *newPath = [self.tableView indexPathForSelectedRow];

         dvc.moviesArray = self.movieListArray;
         dvc.indexPath = newPath;
         
         //set delegagte for detailview
         dvc.delegate = self;
     }
     
        if ([segue.identifier isEqualToString:@"mustWatchSegue"]){
            MustWatchTableViewController *myMvc = (MustWatchTableViewController *)[segue destinationViewController];
            
            myMvc.mustWatchNowArray = self.myMustWatchArray;
            
     }
     
 }


- (IBAction)goToMustWatch:(id)sender {
    
    [self performSegueWithIdentifier:@"mustWatchSegue" sender:nil];
    
    
}
@end
