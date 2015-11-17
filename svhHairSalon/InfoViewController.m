//
//  ProfileViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 13..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

-(void)viewDidLoad{

    //NSLog(@"indexPathRow == %d", self.indexPathRow);
    
    [_infoWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%s/info.php",KN_HOST_NAME]]]];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
