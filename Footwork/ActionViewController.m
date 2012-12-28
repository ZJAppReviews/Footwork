//
//  ActionViewController.m
//  Footwork
//
//  Created by Stephen Tarzia on 12/19/12.
//  Copyright (c) 2012 VaporStream, Inc. All rights reserved.
//

#import "ActionViewController.h"

@interface ActionViewController ()

@end

@implementation ActionViewController{
    UIView* _flash;
    NSArray* _markers;
}

@synthesize randomNumberLabel;
@synthesize badmintonMode;
@synthesize announcementDelay;
@synthesize marker1;
@synthesize marker2;
@synthesize marker3;
@synthesize marker4;
@synthesize marker5;
@synthesize marker6;
@synthesize courtImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // set default values
        self.announcementDelay = 2.0;
        self.badmintonMode = NO;
    }
    return self;
}

-(void)viewDidLoad{
    _markers = [NSArray arrayWithObjects:marker1, marker2, marker3,
                marker4, marker5, marker6, nil];
    // set up flash view
    _flash = [[UIView alloc] initWithFrame:self.view.frame];
    _flash.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _flash.alpha = 0;
    _flash.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_flash];
    
    // clear badminton features, if disabled
    for( UILabel* marker in _markers ){
        marker.hidden = !badmintonMode;
    }
    courtImage.hidden = !badmintonMode;
    
}

-(void)flash{
    [UIView animateWithDuration:0.1
                     animations:^(void){
                         _flash.alpha = 1.0;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                          animations:^(void){
                                              _flash.alpha = 0;
                                          }];
                     }];
}

#pragma mark - AnnouncerDelegate

-(void)gotNumber:(int)number{
    [self flash];
    randomNumberLabel.text = [NSString stringWithFormat:@"%d",number];
    
    // clear old marker
    for( UILabel* marker in _markers ){
        marker.backgroundColor = [UIColor clearColor];
    }
    // set new marker
    if( number <= 6 ){
        UILabel* marker = [_markers objectAtIndex:number-1];
        if( number == 5 || number == 6 ){
            marker.backgroundColor = [UIColor yellowColor];
        }else{
            marker.backgroundColor = [UIColor redColor];
        }
    }
}

-(float)delayForNumber:(int)number{
    if( self.badmintonMode ){
        if( number == 5 || number == 6 ){
            return self.announcementDelay * 0.667;
        }else if( number == 3 || number == 4 ){
            return self.announcementDelay * 1.3;
        }else{
            return self.announcementDelay;
        }
    }else{
        return self.announcementDelay;
    }
}


@end
