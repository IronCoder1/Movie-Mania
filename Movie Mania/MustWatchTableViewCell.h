//
//  MustWatchTableViewCell.h
//  Movie Mania
//
//  Created by MBPinTheAir on 16/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MustWatchTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *posterImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

@end
