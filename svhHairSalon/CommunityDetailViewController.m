//
//  CommunityDetailViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 15..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "CommunityDetailViewController.h"

@interface CommunityDetailViewController ()

@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"IndexRow == %lu", self.indexPathRow);
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

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
