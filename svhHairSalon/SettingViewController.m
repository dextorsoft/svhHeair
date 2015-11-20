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

#pragma mark - LifeCycle!!
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
    
    NSString *title = @"계정을 삭제 하겠습니까?";
    NSString *message = @"계정을 삭제하시면 어플이 종료됩니다.";

    UIAlertController *regDropOut = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel...");
    }];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"삭제하기" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"deleting...");
        
        NSString *alTitle = @"계정삭제 알림";
        NSString *alMessage = @"계정삭제가 진행되지 않았습니다.\n나중에 다시 시도해 주세요.";
        if (![self ArchiveDropOut]) {   //계정삭제 실패...안내 문구 뛰워 주기
            UIAlertController *DropOutAlert = [UIAlertController alertControllerWithTitle:alTitle
                                                                                  message:alMessage
                                                                           preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"나중에" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                NSLog(@"fault");
            }];
            UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"재시도" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [regDropOut presentViewController:DropOutAlert animated:YES completion:nil];        //retry!!!
            }];
            [DropOutAlert addAction:exitAction];
            [DropOutAlert addAction:retryAction];
            [regDropOut presentViewController:DropOutAlert animated:YES completion:nil];    //일단 테스트 오류가 나는 지 확인하기....
        }else if ([self ArchiveDropOut]){
            [self WebdropOut];  //웹계정 삭제
            exit(0);        //종료함수
        }
        
    }];
    [regDropOut addAction:cancelAction];
    [regDropOut addAction:doAction];
    
    [self presentViewController:regDropOut animated:YES completion:nil];
}
//웹에서 계정삭제 시도
-(void)WebdropOut{
    ForToolClass *forToolClass = [[ForToolClass alloc] init];
    ArchivingConnect *archivingConnect = [[ArchivingConnect alloc] init];
    [archivingConnect MyProfileFile];   //아카이브 파일 연결
    NSString *myCode = [archivingConnect MyProfileCall:@"myCode"];
    NSString *myID = [archivingConnect MyProfileCall:@"myID"];
    
    NSString *dropOutString = [NSString stringWithFormat:@"http://%s/m_delete.php?m_Code=%@&m_myId=%@"
                               ,KN_HOST_NAME
                               ,myCode
                               ,myID];
    
    [forToolClass GetHTMLString:dropOutString encoding:KN_SERVER_LANG];
}
//아카이빙 파일이 삭제되지 않을경우와 삭제되는 경우 return BOOL
-(BOOL)ArchiveDropOut{
    BOOL OkDropOut;
    ArchivingConnect *archivingConnect = [[ArchivingConnect alloc] init];
    [archivingConnect MyProfileFile];   //아카이브 파일 연결
    if ([archivingConnect.fileManager fileExistsAtPath:archivingConnect.dataFilePath]) {
        if (![archivingConnect MyProfileRemove]) {
            OkDropOut = [archivingConnect MyProfileRemove];
        }else if ([archivingConnect MyProfileRemove]){
            OkDropOut = [archivingConnect MyProfileRemove];
        }
    }
    return OkDropOut;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////여기까지 계정삭제 파트!!
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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