//
//  Movie.h
//  Movie Mania
//
//  Created by MBPinTheAir on 15/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *posterName;
@property (copy, nonatomic) NSString *genre;
@property (copy, nonatomic) NSString *director;
@property (copy, nonatomic) NSString *runtime;
@property (copy, nonatomic) NSString *rated;
@property (copy, nonatomic) NSString *shortPlot;
@property (copy, nonatomic) NSString *longPlot;
@property (assign, nonatomic) NSDate *releaseDate;


@end

