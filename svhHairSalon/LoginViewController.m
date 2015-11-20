//
//  LoginViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self NavigationSetting];
    LoginURL = [NSString stringWithFormat:@"http://%s/top_bg.html",KN_HOST_NAME];
    [_WVLoginView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:LoginURL]]];

    [self performSegueWithIdentifier:@"MovetoLife" sender:self];//////////////////나중에 삭제....20151012mon

}
///////////////////
-(void)viewWillAppear:(BOOL)animated{
    [self NavigationSetting];

    [self performSegueWithIdentifier:@"MovetoLife" sender:self];//////////////////나중에 삭제....20151012mon

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


-(void)NavigationSetting{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:navBarItem];
    [navBarItem setTintColor:[UIColor whiteColor]];
}

#pragma mark - UIStatusBar Hidden
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end