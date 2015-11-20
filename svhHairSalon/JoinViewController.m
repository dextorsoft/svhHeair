//
//  JoinViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation JoinViewController

#define kOFFSET_FOR_KEYBOARD 215.0


#pragma mark - View Read Part

- (void)viewDidLoad {
    ///////////////
    forToolClass = [[ForToolClass alloc] init];
    ///////////////
    NSLog(@"check");
    setMoveChk = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JoinURL = [NSString stringWithFormat:@"http://%s/top_bg.html",KN_HOST_NAME];
    [_WVJoinView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:JoinURL]]];
    
    //TextField Delegate
    [self.TFUserNum addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //전화번호 TextField 감시;
    _TFUserName.delegate = self;
    [self.TFUserName addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //성명 TextField 감시;
    _TFUserNickName.delegate = self;
    [self.TFUserNickName addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //별명 TextField 감시;
    _TFUserID.delegate = self;
    [self.TFUserID addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //아이디 TextField 감시;
    _TFUserPass.delegate = self;
    [self.TFUserPass addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //비밀번호 TextField 감시;
    _TFUserPassChk.delegate = self;
    [self.TFUserPassChk addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //비밀번호 확인 TextField 감시;
    _TFUserIntroducerID.delegate = self;
    [self.TFUserIntroducerID addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];      //추천인 아이디 TextField 감시;
    //
    
    //Keyboard setting
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    return;
}

-(void)viewWillAppear:(BOOL)animated{
    ///////////////
    forToolClass = [[ForToolClass alloc] init];
    ///////////////
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Catch the Changing
///////텍스트 변화 감지 메소드
-(void)textFieldChanged:(UITextField *)textField{
    if (textField.tag == 7) {
        JoinNum = textField.text;
    }
    if (textField.tag == 1) {
        JoinName = textField.text;
    }
    if (textField.tag == 2) {
        if ([_BtnUserNickChk.titleLabel.text isEqualToString:@"Ok"]) {
            [_BtnUserNickChk setTitle:@"Check" forState:UIControlStateNormal];
            JoinNickName = textField.text;
            NSLog(@"JoinNickName == %@", JoinNickName);
        }else{
            JoinNickName = textField.text;
        }
    }
    if (textField.tag == 3) {
        if ([_BtnUserIDChk.titleLabel.text isEqualToString:@"Ok"]) {
            [_BtnUserIDChk setTitle:@"Check" forState:UIControlStateNormal];
            JoinID = textField.text;
        }else{
            JoinID = textField.text;
        }
    }
    if (textField.tag == 4) {
        JoinPass = textField.text;
    }
    if (textField.tag == 5) {
        JoinPassChk = textField.text;
    }
    if (textField.tag == 6) {
        if ([_BtnUserIntroducerIDChk.titleLabel.text isEqualToString:@"Ok"]) {
            [_BtnUserIntroducerIDChk setTitle:@"Check" forState:UIControlStateNormal];
            JoinIntroducerID = textField.text;
        }else{
            JoinIntroducerID = textField.text;
        }
    }
    //TextField가 조건에 부합하지 않을 시 Join Button 이 활성화 되지 않음
    if ((JoinNum.length > 10) && (JoinName.length > 0) && (JoinNickName.length > 0) && (JoinID.length > 0) && (JoinPass.length > 0) && (JoinPassChk.length > 0)) {
        _BtnUserJoinChk.alpha = 1;      //join btn 활성화
    }
}
///////////////////////



#pragma mark - IBAction
- (IBAction)BtnUserNickAction:(UIButton *)sender {
    NSLog(@"JoinNickName == %@", JoinNickName);
    [self NickIDChk:JoinNickName andSecondString:@"3" andThirdString:_BtnUserNickChk];
}

- (IBAction)BtnUserIDAction:(UIButton *)sender {
    [self NickIDChk:JoinID andSecondString:@"2" andThirdString:_BtnUserIDChk];
}

- (IBAction)BtnUserBirthAction:(UIButton *)sender {
    [self DatePickerActionSheet];
}

- (IBAction)BtnUserGenderAction:(UISegmentedControl *)sender {
    JoinGender = [self ChkGender];
}
-(NSString *)ChkGender{
    NSString *gender = @"1";
    switch (_BtnUserGender.selectedSegmentIndex) {
        case 0:
            JoinGender = @"1";  //Man
            break;
        case 1:
            JoinGender = @"2";  //Woman
            break;
    }//end switch
    return gender;
}

- (IBAction)BtnUserIntroducerAction:(UIButton *)sender {
    [self NickIDChk:JoinIntroducerID andSecondString:@"1" andThirdString:_BtnUserIntroducerIDChk];
}
//////////////////
#pragma mark - IBAction Last Request Join Submit
//
- (IBAction)BtnUserJoinSubmit:(UIButton *)sender {

    BOOL JoinOK = [self joinInfoChk];
    
    if (JoinOK) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        JoinDevice = [prefs stringForKey:@"m_Device"];
        [prefs synchronize];
        
        NSString *title = @"회원가입을 하시겠습니까?";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        //회원가입 최종 결정 버튼
        UIAlertAction *correctAlertAction = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self saveRegInfo];     //회원가입 업로드 및 아카이브 저장 메소드
        }];
        
        [alertController addAction:cancelAlertAction];
        [alertController addAction:correctAlertAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
    }
}

//회원가입 업로드 및 아카이브 저장 메소드
-(void)saveRegInfo{
    
    NSLog(@"JoinNum == %@",JoinNum);
    NSLog(@"JoinName == %@",JoinName);
    NSLog(@"JoinNickName == %@",JoinNickName);
    NSLog(@"JoinID == %@",JoinID);
    NSLog(@"JoinPass == %@",JoinPass);
    NSLog(@"JoinPassChk == %@",JoinPassChk);
    NSLog(@"JoinBirthDate == %@", SimpleBirthDate);
    NSLog(@"JoinGender == %@",JoinGender);
    NSLog(@"JoinDevice == %@", JoinDevice);
    if (JoinIntroducerID.length == 0 || JoinIntroducerID == nil) {
        //[self TextLengthWarning:@"추천인 아이디가 없습니다"];
        JoinIntroducerID = @"";
    }
    NSString *JoinURL = [NSString stringWithFormat:@"http://%s/m_join.php?m_Name=%@&m_PH=%@&m_Device=%@&m_Section=1&m_ID=%@&m_PW=%@&m_NID=%@&m_NICK=%@&m_Date=%@&m_sex=%@",
                         KN_HOST_NAME,
                         JoinName,
                         JoinNum,
                         JoinDevice,
                         JoinID,
                         JoinPass,
                         JoinIntroducerID,
                         JoinNickName,
                         SimpleBirthDate,
                         JoinGender];
    NSLog(@"JoinHtml == %@", JoinURL);
    
    NSString *MyCode = [forToolClass GetHTMLString:JoinURL encoding:KN_SERVER_LANG];
    NSLog(@"MyCode == %@", MyCode);
    if ([MyCode isEqualToString:@""] || MyCode == nil || MyCode.length == 0 || [MyCode isEqualToString:@"error"]) {
        [self TextLengthWarning:@"통신상태가 좋지 않습니다\n확인 후 다시 시도 하세요"];
        [self performSegueWithIdentifier:@"SignBack" sender:self];
    }else{
        
        //Token Upload in the Server
        NSString *tokenURL = [NSString stringWithFormat:@"http://%s/m_c2dm.php?sid=%@&svalue=%@&type=1",KN_HOST_NAME ,MyCode ,[JoinDevice stringByAddingPercentEscapesUsingEncoding:KN_SERVER_LANG]];
        NSString *tokenChk = [forToolClass GetHTMLString:tokenURL encoding:KN_SERVER_LANG];
        tokenChk = [tokenChk stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        //가입정보 Server 에서 확인
        NSString *regChkURL = [NSString stringWithFormat:@"http://%s/m_setup_check.php?m_Code=%@", KN_HOST_NAME, MyCode];
        regChkURL = [regChkURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *regChkData = [forToolClass GetHTMLString:regChkURL encoding:KN_SERVER_LANG];
        
        NSArray *regInfo = [regChkData componentsSeparatedByString:@"|"];
        
        //아카이브 호출
        ArchivingConnect *archive = [[ArchivingConnect alloc] init];
        [archive MyProfileFile];
        [archive MyProfileWrite:MyCode name:JoinName PH:JoinNum Department:[regInfo objectAtIndex:4] Grade:[regInfo objectAtIndex:24] UserLevel:[regInfo objectAtIndex:2] Gender:JoinGender Bdate:SimpleBirthDate ID:JoinID Pass:JoinPass Boss:@"0" Best:@"0" Nick:JoinNickName Item:@"0" PN:[regInfo objectAtIndex:33]];
        
        if (![archive.fileManager fileExistsAtPath:archive.dataFilePath]) {
            NSString *title = @"내부파일 작성이 되지 않았습니다.";
            UIAlertController *archiveFail = [UIAlertController alertControllerWithTitle:title
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"재시도"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *noAction){
                
            }];
            [archiveFail addAction:retryAction];
            [archiveFail presentViewController:archiveFail animated:YES completion:nil];
        }else if([archive.fileManager fileExistsAtPath:archive.dataFilePath]){
            
            [self performSegueWithIdentifier:@"SignUp" sender:self];        //로그인 화면으로 segue 타기
        }
    }
}

////////////////////
//회원가입 체크 버튼 메소드
-(BOOL)joinInfoChk{
    //if 가 들어갈 것임.
    JoinGender = [self ChkGender];
    
    if (JoinNum.length <= 9) {
        NSLog(@"check1");
        [self TextLengthWarning:@"올바르지 않은 전화번호입니다"];
        [self textFieldShouldReturn:_TFUserNum];
        return NO;
    }else if(JoinName.length< 2){
        [self TextLengthWarning:@"이름은 2자 이상으로 입력하세요"];
        [self textFieldShouldReturn:_TFUserName];
        return NO;
    }else if(JoinNickName.length< 2){
        [self TextLengthWarning:@"별명은 2자 이상으로 입력하세요"];
        [self textFieldShouldReturn:_TFUserNickName];
        return NO;
    }else if(JoinID.length< 2){
        [self TextLengthWarning:@"아이디는 2자 이상으로 입력하세요"];
        [self textFieldShouldReturn:_TFUserID];
        return NO;
    }else if(JoinPass.length< 2){
        [self TextLengthWarning:@"비밀번호는 2자 이상으로 입력하세요"];
        [self textFieldShouldReturn:_TFUserPass];
        return NO;
    }else if(![JoinPassChk isEqualToString:JoinPass]){
        [self TextLengthWarning:@"비밀번호와 비밀번호 확인이 일치하지 않습니다"];
        [self textFieldShouldReturn:_TFUserPassChk];
        return NO;
    }else if((SimpleBirthDate.length<= 0) || SimpleBirthDate == nil){
        [self TextLengthWarning:@"생년월일을 선택하세요"];
        return NO;
    }else if(![_BtnUserNickChk.titleLabel.text isEqualToString:@"Ok"]){
        [self TextLengthWarning:@"별명 중복을 확인하세요"];
        return NO;
    }else if(![_BtnUserIDChk.titleLabel.text isEqualToString:@"Ok"]){
        [self TextLengthWarning:@"아이디 중복을 확인하세요"];
        return NO;
    }else{
        return YES;
    }
}
////////////////////
//textField Return Event 찾기
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        if (!(_TFUserName.text.length >=2) ) {
            [self TextLengthWarning:@"이름은 2자 이상으로 입력하세요!"];
            [_TFUserName becomeFirstResponder];
        }else{
            [_TFUserNickName becomeFirstResponder];
        }
    }else if(textField.tag == 2){
        if (!(_TFUserNickName.text.length >=2) ) {
            [self TextLengthWarning:@"별명은 2자 이상으로 입력하세요!"];
            [_TFUserNickName becomeFirstResponder];
        }else{
            [_TFUserID becomeFirstResponder];
        }
    }else if(textField.tag == 3){
        if (!(_TFUserID.text.length >=2) ) {
            [self TextLengthWarning:@"아이디는 2자 이상으로 입력하세요!"];
            [_TFUserID becomeFirstResponder];
        }else{
            [_TFUserPass becomeFirstResponder];
        }
    }else if(textField.tag == 4){
        if (!(_TFUserPass.text.length >=2) ) {
            [self TextLengthWarning:@"비밀번호는 2자 이상으로 입력하세요!"];
            [_TFUserPass becomeFirstResponder];
        }else{
            [_TFUserPassChk becomeFirstResponder];
        }
    }else if(textField.tag == 5){
        if (![_TFUserPass.text isEqualToString:_TFUserPassChk.text]) {
            [self TextLengthWarning:@"비밀번호와 확인 번호가 일치 하지 않습니다!"];
            [_TFUserPassChk becomeFirstResponder];
        }else{
            [textField resignFirstResponder];
            return NO;
        }
    }
    return YES;
}
///////////////

//BtnUserNickAction, BtnUserIDAction, BtnUserIntroducerAction => 별명 중복확인 버튼, 아이디 중복확인 버튼, 추천인 확인 버튼 메소드
-(void)NickIDChk:(NSString *)Url andSecondString:(NSString *)Type andThirdString:(UIButton *)which{
    NSLog(@"Url == %@", Url);
    NSLog(@"Type == %@", Type);
    NSLog(@"JoinNickName == %@", JoinNickName);
    if (Url.length <= 0) {
        if([Type isEqualToString:@"3"]){
            [self TextLengthWarning:@"별명은 2자 이상이에요"];
            [which setTitle:@"Empty" forState:UIControlStateNormal];
        }else if ([Type isEqualToString:@"2"] || [Type isEqualToString:@"1"]) {
            NSLog(@"확인");
            [self TextLengthWarning:@"아이디를 입력하세요"];
            [which setTitle:@"Empty" forState:UIControlStateNormal];
        }
    }else{
        NSString *UrlChk = [NSString stringWithFormat:@"http://%s/m_join_check.php?m_type=%@&m_id=%@",KN_HOST_NAME,Type,Url];
        NSString *UrlChkData = [forToolClass GetHTMLString:UrlChk encoding:KN_SERVER_LANG];
        NSLog(@"UrlChkData == %@", UrlChkData);
        if ([UrlChkData isEqualToString:@"ok"]) {
            if ([Type isEqualToString:@"1"]) {
                [self TextLengthWarning:@"추천인 아이디를 확인 했어요"];
            }
            [which setTitle:@"Ok" forState:UIControlStateNormal];
        }else if(UrlChkData == nil || UrlChkData.length == 0){
            [self TextLengthWarning:@"에러!!\n연결을 확인 하세요"];
            [which setTitle:@"error" forState:UIControlStateNormal];
        }else{
            if ([Type isEqualToString:@"3"]) {
                [self TextLengthWarning:@"중복된 별명이에요"];
                JoinNickName = nil;
                _TFUserNickName.text = @"";
                [forToolClass Vibrator];
                [self textFieldShouldReturn:_TFUserNickName];
            }else if ([Type isEqualToString:@"2"]) {
                [self TextLengthWarning:@"중복된 아이디에요"];
                JoinID = nil;
                _TFUserID.text = @"";
                [forToolClass Vibrator];
                [self textFieldShouldReturn:_TFUserID];
            }else if ([Type isEqualToString:@"1"]){
                [self TextLengthWarning:@"존재하지 않는 아이디에요"];
                JoinIntroducerID = nil;
                _TFUserIntroducerID.text = @"";
                [forToolClass Vibrator];
                [self textFieldShouldReturn:_TFUserIntroducerID];
            }
            [which setTitle:@"No" forState:UIControlStateNormal];
        }
    }
}
////////////////////////
#pragma mark - AlertController Part
//AlertController TextLengthWarning;
-(void)TextLengthWarning:(NSString *)where{
    UIAlertController *textLengthWarn = [UIAlertController alertControllerWithTitle:where
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
    [textLengthWarn addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"check"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           //action nil;
        }];
        action;
    })];
    [self presentViewController:textLengthWarn animated:YES completion:nil];
}
////////////////////
//AlertController TextLengthWarning;
-(void)AlertYesOrNo:(NSString *)Title Message:(NSString *)message Yes:(NSString *)yes No:(NSString *)no Type:(NSString *)type{
    UIAlertController *alertYesOrNo = [UIAlertController alertControllerWithTitle:Title
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
    [alertYesOrNo addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:no
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *noAction) {
                                                           //action nil;
                                                       }];
        action;
    })];
    [alertYesOrNo addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:yes
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *yesAction) {
                                                           //action nil;
                                                       }];
        action;
    })];
    [self presentViewController:alertYesOrNo animated:YES completion:nil];
}
////////////////////
////////////////////AlertController UIDatePicker;
-(void)DatePickerActionSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.maximumDate = [NSDate date];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [alertController.view addSubview:picker];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"%@",picker.date);
            
            //date format UIAlertController UIDatePicker Button Title Label Edit Reference;
            self.dateFormatter = [[NSDateFormatter alloc] init];
            self.dateFormatter.dateStyle = NSDateFormatterFullStyle;
            //Variable set Birth Date
            JoinBirthDate = [self.dateFormatter stringFromDate:picker.date];
            NSMutableArray *YYMMDD = [[NSMutableArray alloc] initWithArray:[JoinBirthDate componentsSeparatedByString:@" "]];
            JoinBirthDate = [NSString stringWithFormat:@"%@%@%@", YYMMDD[0],YYMMDD[1],YYMMDD[2]];
            /////
            YYMMDD[0] = [[YYMMDD objectAtIndex:0] stringByReplacingOccurrencesOfString:@"년" withString:@""];
            YYMMDD[1] = [[YYMMDD objectAtIndex:1] stringByReplacingOccurrencesOfString:@"월" withString:@""];
            YYMMDD[2] = [[YYMMDD objectAtIndex:2] stringByReplacingOccurrencesOfString:@"일" withString:@""];
            SimpleBirthDate = [NSString stringWithFormat:@"%@-%@-%@", YYMMDD[0],YYMMDD[1],YYMMDD[2]];
            /////
            NSLog(@"YYMMDD == %@", SimpleBirthDate);
            //Button Title Label Edit
            [_BtnUserBirth setTitle:JoinBirthDate forState:UIControlStateNormal];
        }];
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}
////////////////////
//Keyboard Animation
#pragma mark - Keyboard Boolean

-(void) keyboardWillShow:(NSNotification *)note{
    NSLog(@"keyboardWillShow");
    if (setMoveCnt <= 0) {
        [self setViewMoveUP:YES];
    }
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSLog(@"keyboardWillHide");
    [self setViewMoveUP:setMoveChk];
}

#pragma mark - setViewMove Animation method

-(void)setViewMoveUP:(BOOL)movedUp{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = _joinMainView.frame;
    
    if (movedUp) {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        setMoveChk = NO;
        setMoveCnt += 1;
    }else{
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        setMoveChk = YES;
        setMoveCnt = 0;
    }
    _joinMainView.frame = rect;

    [UIView commitAnimations];
}

#pragma mark - UIStatusBar Hidden
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
