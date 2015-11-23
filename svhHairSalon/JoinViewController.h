//
//  JoinViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"
#import "ArchivingConnect.h"

@interface JoinViewController : UIViewController<UITextFieldDelegate>{
    
    ForToolClass *forToolClass;     //참조 클래스
    
    int setMoveCnt;     //softKeyboard animation cnt;
    
    BOOL setMoveChk;    //softkeyboard animarion chk;
    
    NSString *JoinURL;      //뒷 배경화면 URL
    
    NSString *JoinNum, *JoinName, *JoinNickName, *JoinID, *JoinPass, *JoinPassChk, *JoinIntroducerID, *JoinGender, *JoinBirthDate, *SimpleBirthDate, *JoinDevice;      //Join 화면 TextField 잠시 저장 String
    
    UIDatePicker *datePicker;
    
    BOOL BtnUserNickChkBool;    //별명 중복확인 버튼 bool
    BOOL BtnUserIDChkBool;      //아이디 중복확인 버튼 bool
    BOOL BtnUserIntroducerIDChkBool;    //추천인 ID 존재여부 확인 버튼 bool
    
    NSString *dataFilePath;     //아카이브 데이터 경로 변수
}

@property (retain, nonatomic) IBOutlet UIView *joinMainView;
@property (retain, nonatomic) IBOutlet UIWebView *WVJoinView;

#pragma mark - Join Information Input View
//TextField Part
@property (retain, nonatomic) IBOutlet UITextField *TFUserNum;      //User Phone Num
@property (weak, nonatomic) IBOutlet UITextField *TFUserName;       //User Name
@property (weak, nonatomic) IBOutlet UITextField *TFUserNickName;       //User NickName
@property (weak, nonatomic) IBOutlet UITextField *TFUserID;     //User ID
@property (weak, nonatomic) IBOutlet UITextField *TFUserPass;       //User Password
@property (weak, nonatomic) IBOutlet UITextField *TFUserPassChk;        //User Password Check
@property (weak, nonatomic) IBOutlet UITextField *TFUserIntroducerID;       //User Introducer ID, but not Required
//Button Part
@property (weak, nonatomic) IBOutlet UIButton *BtnUserNickChk;
@property (weak, nonatomic) IBOutlet UIButton *BtnUserIDChk;
@property (weak, nonatomic) IBOutlet UIButton *BtnUserBirth;
@property (weak, nonatomic) IBOutlet UISegmentedControl *BtnUserGender;
@property (weak, nonatomic) IBOutlet UIButton *BtnUserIntroducerIDChk;
@property (weak, nonatomic) IBOutlet UIButton *BtnUserJoinChk;
//Button Action Part
- (IBAction)BtnUserNickAction:(UIButton *)sender;
- (IBAction)BtnUserIDAction:(UIButton *)sender;
- (IBAction)BtnUserBirthAction:(id)sender;
- (IBAction)BtnUserGenderAction:(UISegmentedControl *)sender;
- (IBAction)BtnUserIntroducerAction:(UIButton *)sender;
- (IBAction)BtnUserJoinSubmit:(UIButton *)sender;

@end
