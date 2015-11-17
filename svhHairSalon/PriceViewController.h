//
//  PriceViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ViewController.h"

@interface PriceViewController : ViewController

@property (weak, nonatomic) IBOutlet UIWebView *priceWeb;
@property (weak, nonatomic) IBOutlet UIButton *price01;     //btn price01 property
@property (weak, nonatomic) IBOutlet UIButton *price02;     //btn price01 property
@property (weak, nonatomic) IBOutlet UIButton *price03;     //btn price01 property

- (IBAction)price01Show:(UIButton *)sender;     //btn price01 Action
- (IBAction)price02Show:(UIButton *)sender;     //btn price02 Action
- (IBAction)price03Show:(UIButton *)sender;     //btn price03 Action

@end
