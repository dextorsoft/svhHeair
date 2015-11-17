//
//  HairViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 22..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "HairViewController.h"

@interface HairViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *images;
    NSMutableArray *imageLabel;
    NSArray *URLArr;
}

@end

@implementation HairViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1]];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithHue:255/255.0 saturation:255/255.0 brightness:255/255.0 alpha:0.5]];
    UIImage *navBack = [UIImage imageNamed:@"nav_black.png"];        //네비게이션바 투명 처리
    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.title = @"Hair";
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self dataURLCallStack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataURLCallStack{
    ForToolClass *forToolClass = [[ForToolClass alloc] init];
    images = [[NSMutableArray alloc] init];
    imageLabel = [[NSMutableArray alloc] init];
    NSString *URL = [NSString stringWithFormat:@"http://%s/m_bbs_content_list.php?m_TN=2_1&m_Page=1&Result=1&top=0", KN_HOST_NAME];
    NSLog(@"URL == %@", URL);
    URL = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *URLData = [forToolClass GetHTMLString:URL encoding:KN_SERVER_LANG];
    NSLog(@"URLData == %@", URLData);
    URLData = [URLData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    URLArr = [URLData componentsSeparatedByString:@"<br>"];
    NSLog(@"URLArr.count == %ld", (long)URLArr.count);
    for(int i = 0; i < URLArr.count - 2; i++){
        if (URLArr.count == 0) {
            //AlertControll 첨부
        }else{
            NSArray *URLImageName = [[URLArr objectAtIndex:i] componentsSeparatedByString:@"|"];
            NSLog(@"URLImageName == %@", [URLImageName objectAtIndex:0]);
            NSString *imgName = [NSString stringWithFormat:@"http://%s/bbs_manager/2_1/%@.png", KN_HOST_NAME, [URLImageName objectAtIndex:0]];
            imgName = [imgName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //[images addObject:[UIImage imageNamed:[URLImageName objectAtIndex:0]]];
            [images addObject:[URLImageName objectAtIndex:0]];
            [imageLabel addObject:[URLImageName objectAtIndex:15]];
            
            NSLog(@"imageName == %d - %@", i, [URLImageName objectAtIndex:0]);
            NSLog(@"imageLabel == %d - %@", i, [URLImageName objectAtIndex:15]);
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate and DataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    UIImageView*iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    tableView.backgroundColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor blackColor];
    iv.backgroundColor = [UIColor blackColor];
    iv.window.backgroundColor = [UIColor blackColor];
    
    //iv.image = images[indexPath.row%7];
    [iv setImageURLString:[NSString stringWithFormat:@"http://%s/bbs_manager/2_1/%@.png", KN_HOST_NAME, [images objectAtIndex:indexPath.row]]];

    [cell.contentView addSubview:iv];
    //cell.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, self.view.bounds.size.width, 44)];
    //NSString*text = [NSString stringWithFormat:@"%@",[imageLabel objectAtIndex:(long)indexPath.row]];
    //[label setText:text];
    //[label setTextColor: [UIColor blackColor]];
    //label.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:15];
    //label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview: label];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return URLArr.count - 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //return 200;
    return self.view.bounds.size.height/3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSLog(@"touch");
    NSLog(@"indexPath == %ld", (long)indexPath.row);
    indexRow = (int)indexPath.row;
    [self performSegueWithIdentifier:@"HairDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HairDetailViewController *hairDetail = segue.destinationViewController;
    //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"indexPath.row == %d", (int)indexRow);
    NSLog(@"URLArr == %@", [URLArr objectAtIndex:indexRow]);///////////////////
    hairDetail.indexPathRow = (int)indexRow;
    hairDetail.hairData = [URLArr objectAtIndex:indexRow];///////////////////
    indexRowCode = [images objectAtIndex:indexRow];        //code 값 저장
    hairDetail.titleNum = indexRowCode;
}

-(void)NavigationSetting{
    self.navigationController.navigationBarHidden = YES;
    //UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    //[[self navigationItem] setBackBarButtonItem:navBarItem];
}

@end
