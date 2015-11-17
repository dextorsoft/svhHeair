//
//  PriceViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self priceWebShow:@"1"];
    
    // Do any additional setup after loading the view.
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

- (IBAction)price01Show:(UIButton *)sender {
    [self priceWebShow:@"1"];
}

- (IBAction)price02Show:(UIButton *)sender {
    [self priceWebShow:@"2"];
}

- (IBAction)price03Show:(UIButton *)sender {
    [self priceWebShow:@"3"];
}

-(void)priceWebShow:(NSString *)cn{
    [_priceWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%s/m_price.php?cn=%@",KN_HOST_NAME, cn]]]];
}

#pragma mark - hidden status bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
