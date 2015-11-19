//
//  ScheduleViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 12..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@property (nonatomic, strong) CalendarView * customCalendarView;
@property (nonatomic, strong) NSCalendar * gregorian;
@property (nonatomic, assign) NSInteger currentYear;

@end

@implementation ScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor blackColor]];
    
//    UIImage *navBack = [UIImage imageNamed:@"nav_back.png"];
//    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
    forToolClass = [[ForToolClass alloc] init];
    scheduleDetail = [[ScheduleDetailViewController alloc] init];
    
    //IOS 화면 사이즈 구하기
    CGRect screenRect = [[UIScreen mainScreen] bounds];     //스크린에 관한 모든 정보
    
    //self.title = @"Custom Calendar";
    
    _gregorian       = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    _customCalendarView                             = [[CalendarView alloc]initWithFrame:CGRectMake(0, 70, screenRect.size.width, screenRect.size.height)];
    _customCalendarView.delegate                    = self;
    _customCalendarView.datasource                  = self;
    _customCalendarView.calendarDate                = [NSDate date];
    _customCalendarView.monthAndDayTextColor        = RGBCOLOR(0, 174, 255);
    _customCalendarView.dayBgColorWithData          = RGBCOLOR(208, 208, 214);
    _customCalendarView.dayBgColorWithoutData       = RGBCOLOR(21, 124, 229);
    _customCalendarView.dayBgColorSelected          = RGBCOLOR(94, 94, 94);
    _customCalendarView.dayTxtColorWithoutData      = RGBCOLOR(57, 69, 84);
    _customCalendarView.dayTxtColorWithData         = [UIColor whiteColor];
    _customCalendarView.dayTxtColorSelected         = [UIColor whiteColor];
    _customCalendarView.borderColor                 = RGBCOLOR(159, 162, 172);
    _customCalendarView.borderWidth                 = 1;
    _customCalendarView.allowsChangeMonthByDayTap   = YES;
    _customCalendarView.allowsChangeMonthByButtons  = YES;
    _customCalendarView.keepSelDayWhenMonthChange   = YES;
    _customCalendarView.nextMonthAnimation          = UIViewAnimationOptionTransitionFlipFromRight;
    _customCalendarView.prevMonthAnimation          = UIViewAnimationOptionTransitionFlipFromLeft;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_customCalendarView];
        _customCalendarView.center = CGPointMake(self.view.center.x, _customCalendarView.center.y);
    });
    
    NSDateComponents * yearComponent = [_gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    _currentYear = yearComponent.year;
    
}

#pragma mark - Gesture recognizer

-(void)swipeleft:(id)sender
{
    [_customCalendarView showNextMonth];
}

-(void)swiperight:(id)sender
{
    [_customCalendarView showPreviousMonth];
}

#pragma mark - CalendarDelegate protocol conformance

-(void)dayChangedToDate:(NSDate *)selectedDate{
    
    NSLog(@"dayChangedToDate %@(GMT)",selectedDate);
    
    NSString *dateString = [forToolClass getStringFromDate:selectedDate];
    NSLog(@"dateString == %@", dateString);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:dateString forKey:@"SelectDateString"];

    [self performSegueWithIdentifier:@"SelectDate" sender:nil];
    
    [prefs synchronize];
    
}

#pragma mark - CalendarDataSource protocol conformance

-(BOOL)isDataForDate:(NSDate *)date
{
    if ([date compare:[NSDate date]] == NSOrderedAscending)
        return YES;
    return NO;
}

-(BOOL)canSwipeToDate:(NSDate *)date
{
    NSDateComponents * yearComponent = [_gregorian components:NSYearCalendarUnit fromDate:date];
    return (yearComponent.year == _currentYear || yearComponent.year == _currentYear+1);
}

#pragma mark - Action methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
