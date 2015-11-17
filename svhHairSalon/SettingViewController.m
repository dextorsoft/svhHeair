//
//  SettingViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 12..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UITextFieldDelegate>{
    
    NSString *qnaString;
    
}

@property (nonatomic, weak) UIAlertAction *qnaTextAlertAction;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ForToolClass *forToolClass = [[ForToolClass alloc] init];       //class ready
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //navigation setting
    UIImage *navBack = [UIImage imageNamed:@"nav_back.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.title = @"Setting";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ProfileViewController *destController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    destController.indexPathRow = indexPath.row;
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 개발자문의하기 버튼
-(IBAction)dev_qna:(id)sender{
    NSString *title = NSLocalizedString(@"개발자에게 문의할 내용을 작성하세요", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        textField.placeholder = @"문의사항을 입력해주세요";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancelled...");
    }];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"문의하기" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"문의한다...");
        
        qnaString = alertController.textFields.firstObject.text;    //문의내용 변수에 저장
        
        NSLog(@"qnaString == %@", qnaString);
        
    }];
    
    //submitAction.enabled = NO;        //enabled 동작이 되징 않는 부분 확인으로 일단 보류.....
    
    [alertController addAction:cancelAction];
    [alertController addAction:submitAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification{
    UITextField *textfield = notification.object;
    
    self.qnaTextAlertAction.enabled = textfield.text.length >= 2;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
