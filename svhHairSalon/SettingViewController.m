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

#pragma mark - 계정 삭제
- (IBAction)dropOutAction:(UIButton*)sender {
    
    NSLog(@"test");
    
    NSString *title = @"계정을 삭제 하겠습니까?";
    NSString *message = @"계정을 삭제하시면 어플이 종료됩니다.";

    UIAlertController *regDropOut = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel...");
    }];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"삭제하기" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"deleting...");
        
        ForToolClass *forToolClass = [[ForToolClass alloc] init];
        
        /*****
         아래 NSString 은 차후에 내부 DB나 환경변수에서 대입시켜야함... 잊지 않고 마무리 작업 때 바꾸자... 20151118
         *****/
        NSString *myCode = @"1";
        NSString *myId = @"test";
        
        NSString *dropOutString = [NSString stringWithFormat:@"http://%s/m_delete.php?m_Code=%@&m_myId=%@"
                                   ,KN_HOST_NAME
                                   ,myCode
                                   ,myId];
        
        [forToolClass GetHTMLString:dropOutString encoding:KN_SERVER_LANG];
        
        [self sqliteTerminated];        //sqlite 에서 정보 지우는 함수...
        
        exit(0);        //종료함수??
        
    }];
    [regDropOut addAction:cancelAction];
    [regDropOut addAction:doAction];
    
    [self presentViewController:regDropOut animated:YES completion:nil];
}

-(void)sqliteTerminated{
    /*****
     sqlite 와 환경변수(UserDefault) 에서 삭제 하는 함수를 만들어야함...
     *****/
}

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
        
        if ((qnaString.length <= 0) || (qnaString == nil)) {
            
            UIAlertView *notText = [[UIAlertView alloc] initWithTitle:@"문의할 내용을 등록하세요"
                                                              message:nil delegate:self
                                                    cancelButtonTitle:@"확인"
                                                    otherButtonTitles:nil];
            
            [notText show];
            
        }else{
            ForToolClass *forToolClass = [[ForToolClass alloc] init];
            
            /*****
            아래 NSString 은 차후에 내부 DB나 환경변수에서 대입시켜야함... 잊지 않고 마무리 작업 때 바꾸자... 20151118
            *****/
            NSString *m_KName = KN_Department_NAME;     //어플 이름
            NSString *m_Code = @"testNumber";       //유저 코드
            NSString *m_Name = @"이름";           //유저 이름 sqlite 나
            NSString *m_Content = qnaString;    //문의 내용
            NSString *m_Phone = @"전화번호";        //유저 전화번호
            NSString *qnaURL = [NSString stringWithFormat:@"http://%s/m_qna_singo.php?m_KName=%@&m_Code=%@&m_Name=%@&m_Content=%@&m_Phone=%@"
                                ,KN_HOST_NAME
                                ,m_KName
                                ,m_Code
                                ,m_Name
                                ,m_Content
                                ,m_Phone];
            NSString *qnaURLResult = [forToolClass GetHTMLString:qnaURL encoding:KN_SERVER_LANG];
            qnaURLResult = [qnaURLResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            qnaURLResult = [qnaURLResult stringByReplacingOccurrencesOfString:@"null" withString:@""];
            qnaURLResult = [qnaURLResult stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            if ([qnaURLResult isEqualToString:@"1"]) {
                UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:@"문의 내용이 등록 되었습니다."
                                                                  message:nil delegate:self
                                                        cancelButtonTitle:@"확인"
                                                        otherButtonTitles:nil];
                
                [okAlert show];
            }else{
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"접속이 불안정 합니다. \n 다시 등록해 주세요"
                                                                     message:nil delegate:self
                                                           cancelButtonTitle:@"확인"
                                                           otherButtonTitles:nil];
                
                [errorAlert show];
            }
            
        }
    }];
    
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