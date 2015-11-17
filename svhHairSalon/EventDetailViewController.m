//
//  EventDetailViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /////////
    IntorViewRef = [[IntroViewController alloc] init];
    [IntorViewRef prefersStatusBarHidden];      //IOS status Hidden;
    /////////
    // Do any additional setup after loading the view.
    
    NSLog(@"indexPathRow == %d", self.indexPathRow);        //Table Row No.
    NSLog(@"CellPathRow == %@", self.CellPathRow);          //Server Row No.
    
    [self ImageViewConnecting];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ImageView data Connect/////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)ImageViewConnecting{
    ImgUrl = [NSString stringWithFormat:@"http://%s/bbs_manager/5_1/%@.png", KN_HOST_NAME,self.CellPathRow];
    NSLog(@"ImgUrl == %@", ImgUrl);
    
    [self.ImgEventDetail setImageURLString:ImgUrl];
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
