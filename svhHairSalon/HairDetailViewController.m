//
//  HairDetailViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 15..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "HairDetailViewController.h"

@interface HairDetailViewController ()

    //instance 로 IB 구성...
    //

@end

@implementation HairDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@", _titleNum];      //나중에 삭제... bm_Title 로 변경할 것 임...
    NSLog(@"indexPathRow == %d", (int)_indexPathRow);
    
    //Navigation Setting
    [self navigationSetting];
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

-(void)DataParsing{
    
    ForToolClass *fortoolclass = [[ForToolClass alloc] init];
    
    NSLog(@"hairData == %@", _hairData);
}

//Navigation Setting Method
-(void)navigationSetting{
    
    
    
}

@end
