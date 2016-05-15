//
//  MainViewController.m
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "MainViewController.h"
#import "CellViewMain.h"

@interface MainViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate,UITextFieldDelegate>

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Movie Mania";

    self.movieListArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
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


-(void)getJson{
    
    
    NSString *apiAddress = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=json",self.searchTextField.text];
    
    NSURL *titleUrl = [NSURL URLWithString:apiAddress];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:titleUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
//            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                
                NSDictionary *omdbJSON =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                self.movieListArray =  [[NSMutableArray alloc]init];
                if   (!jsonError){
                
                    self.aMovie.title = omdbJSON[@"Title"];
                    self.aMovie.posterName = omdbJSON[@"Poster"];
                    self.aMovie.genre = omdbJSON[@"Genre"];
                    self.aMovie.director = omdbJSON[@"Director"];
                    self.aMovie.runtime = omdbJSON[@"Runtime"];
                    self.aMovie.rated = omdbJSON[@"Rated"];
                    self.aMovie.releaseDate = omdbJSON[@"Released"];
                    self.aMovie.shortPlot = omdbJSON[@"Plot"];
                    
                    [self.movieListArray addObject:self.aMovie];
                }
           // }
        } else{
            
            UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Incorrect Film Title, please correct title" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            }];
            [myAlert addAction:ok];
            [myAlert addAction:cancel];
            [self presentViewController:myAlert animated:YES completion:nil];
            
        }
    }];
    
                    dispatch_async(dispatch_get_main_queue(), ^{[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    
                    });
    
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
    
    static NSString *myTableIdentifier = @"customCell";
   
    CellViewMain *cell = (CellViewMain *)[tableView dequeueReusableCellWithIdentifier:myTableIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = self.aMovie.title;
    cell.genreLabel.text = self.aMovie.genre;
    
    return cell;
}



/*
 
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 //call performseguemethod on herotableview instance and the sender is nil
 [self performSegueWithIdentifier:@"toDetailSegue" sender:nil];
 
 }
 
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
 NSIndexPath *newPath = [self.tableView indexPathForSelectedRow];
 
 AOACustomer  *customerObject = self.customerList[newPath.row];
 dvc.holdingCustomerObject  = customerObject;
 
 //dvc.holdingAddress = addressObject;
 
 }
 
*/

@end
