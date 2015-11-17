//
//  CommunityViewControllerTableViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "CommunityTableViewController.h"

@interface CommunityTableViewController (){
    
}

@end

@implementation CommunityTableViewController{
    ForToolClass *forToolClass;
}

static NSString *CellIdentifier = @"CellCommunity";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle/////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //navigation setting
    UIImage *navBack = [UIImage imageNamed:@"nav_back.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //참조 클래스 호출
    forToolClass = [[ForToolClass alloc]init];  //ForToolClass 호출
    
    //Refresh View
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"다시읽기 당기기"];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    ///////////
    
    //Table Data Source 호출
    [self TableDataSource];
    
    ///////////
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //참조 클래스 호출
    forToolClass = [[ForToolClass alloc]init];  //ForToolClass 호출
    
    //Refresh View
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"다시읽기 당기기"];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    ///////////
    
    //Table Data Source 호출
    [self TableDataSource];
    ///////////

    [self tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////

#pragma mark - ImageView Resizing
-(void)ImageViewresizing{
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source parsing/////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)TableDataSource{     //커뮤니티 게시판 "전체", "인기순", "좋아요순", "댓글순", "조회순"
    
    NSLog(@"TableDataSource");
    
    ////스위치로 전체 인기 등.. 나누기 파트
    NSString *TableIndexNo = [[NSString alloc] init];
    //Test 전체만 호출
    URL = [NSString stringWithFormat:@"http://%s/m_bbs_content_list.php?m_TN=%@&m_Page=%@&serch=%@",KN_HOST_NAME,@"4_1",@"1",@"전체"];
    TableData = [forToolClass GetHTMLString:URL encoding:KN_SERVER_LANG];
    TableData = [TableData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    TableArray = [TableData componentsSeparatedByString:@"<br>"];       //행으로 잘라 배열에 저장 하기
    NSLog(@"URL == %@", URL);
    NSLog(@"TableData == %@", TableData);
    NSLog(@"TableArray.count == %lu", (unsigned long)TableArray.count);
    for (int i =0; i < TableArray.count - 1; i++) {
        TableArrayObject = [[TableArray objectAtIndex:i] componentsSeparatedByString:@"|"];       //개체별 자르기
        NSLog(@"TableForArray == %@", [TableArrayObject objectAtIndex:0]);
        if (TableArray.count - 1 > 1) {
            TableIndexNo = [TableIndexNo stringByAppendingString:@","];
        }
        TableIndexNo = [TableIndexNo stringByAppendingString:[TableArrayObject objectAtIndex:0]];
        NSLog(@"TableArrayObject == %@", TableIndexNo);
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source/////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return TableArray.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSNumber *height;
    
    NSLog(@"indexPath.row == %d",indexPath.row);
    NSString *TableIndexNo = [TableArray objectAtIndex:indexPath.row];
    TableArrayObject = [TableIndexNo componentsSeparatedByString:@"|"];
    NSLog(@"TableArrayObject == %@",[TableArrayObject objectAtIndex:2]);
    NSLog(@"TableArrayObject == %@",[TableArrayObject objectAtIndex:15]);
    // Configure the cell...
    CommunityTableViewCell *cell = (CommunityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    height = @(cell.bounds.size.height);
    
    cell.WriterLabel.text = [TableArrayObject objectAtIndex:2];
    cell.ContentLabel.text = [TableArrayObject objectAtIndex:15];

    NSString *imgUrl = [NSString stringWithFormat:@"http://%s/bbs_manager/4_1/%@-1.png", KN_HOST_NAME, [TableArrayObject objectAtIndex:0]];
    [cell.WriterImage setImageURLString:imgUrl];
    
    //if([[TableArrayObject objectAtIndex:1] isEqualToString:@"png"])       //첨부 게시물 종류에 따라 아이콘 바꾸기
    
    imgUrl = [NSString stringWithFormat:@"http://%s/image/%@.png", KN_HOST_NAME, [TableArrayObject objectAtIndex:1]];
    [cell.WriterImage setImageURLString:imgUrl];
    
    [cell.WriterImage.layer setCornerRadius:35];
    [cell.WriterImage.layer setMasksToBounds:YES];
    
    //[self ImageViewresizing];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSNumber *height;
    if (!height) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        height = @(cell.bounds.size.height);
    }
    return [height floatValue];

    // Data for the cell, e.g. text for label
    /*
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    id myData = [self myDataForIndexPath:indexPath];
    
    // Prototype knows how to calculate its height for the given data
    return [self.prototypeCell myHeightForData:myData];
     */
}
/*
- (MyCustomCell *)prototypeCell{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    return _prototypeCell;
}
*/
///////////
//TableView Selected Cell --> Segue 로 data 넘기기
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CommunityDetailViewController *destController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    destController.indexPathRow = indexPath.row;        //TableView Index No.
    //destController.CellPathRow = [TableIndexNoArray objectAtIndex:indexPath.row];   //게시물 넘버 -> 오리지날 이미지 넘버가 된다.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

//Selected Cell Color Change
-(void)SelectedCellColor{

}

//Refresh View Setting
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"다시 읽어오는 중..."];
    
    // custom refresh logic would be placed here...
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"마지막 업데이트 %@", [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}
///////////

- (IBAction)RefreshView:(UIRefreshControl *)sender {
    [self.refreshControl addTarget:self
                            action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
}
///////////

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
