//
//  EventTableViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "EventTableViewController.h"

@interface EventTableViewController (){
    
}

@end

@implementation EventTableViewController{
    ForToolClass *forToolClass;
}

static NSString *CellIdentifier = @"CellEvent";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //navigation setting
    UIImage *navBack = [UIImage imageNamed:@"nav_back.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //참조 클래스 호출
    forToolClass = [[ForToolClass alloc]init];  //ForToolClass 호출
    eventTableViewCell = [[EventTableViewCell alloc] init];     //Cell Class 호출
    
    //Refresh View
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"다시읽기 당기기"];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    //////////
    
    //////////
    [self TableDataSource];
    //////////
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////
#pragma mark - ImageView Resizing
-(void)ImageViewresizing{
    eventTableViewCell.CellImage.layer.cornerRadius = 10;
    eventTableViewCell.CellImage.layer.masksToBounds = YES;
    eventTableViewCell.CellImage.layer.borderColor = [UIColor yellowColor].CGColor;
    eventTableViewCell.CellImage.layer.borderWidth = 1.0;
}

////////////
#pragma mark - Table view data source parsing

-(void)TableDataSource{
    NSString *TableIndexNo = [[NSString alloc] init];
    URL = [NSString stringWithFormat:@"http://%s/m_bbs_content_list2.php?m_TN=%@&m_Page=%@",KN_HOST_NAME,@"5_1",@"1"];
    TableData = [forToolClass GetHTMLString:URL encoding:KN_SERVER_LANG];
    TableData = [TableData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    TableArray = [TableData componentsSeparatedByString:@"<br>"];           //열로 자르기
    NSLog(@"tableArray.count == %lu", (unsigned long)TableArray.count);
    NSLog(@"TableData == %@", TableData);
    for (int i =0; i < TableArray.count -1; i++) {
        NSArray *TableForArray = [[TableArray objectAtIndex:i] componentsSeparatedByString:@"|"];       //개체별 자르기
        NSLog(@"TableForArray == %@", [TableForArray objectAtIndex:0]);
        /*
        if (TableArray.count-1 > 1) {
            TableIndexNo = [TableIndexNo stringByAppendingString:@","];
        }
        */
        TableIndexNo = [TableIndexNo stringByAppendingString:[TableForArray objectAtIndex:0]];
        NSLog(@"NSArray == %@", TableIndexNo);
        TableIndexNo = [TableIndexNo stringByAppendingString:@"<br>"];
    }
    TableIndexNoArray = [TableIndexNo componentsSeparatedByString:@"<br>"];
    NSLog(@"TableIndexNoArray == %@", [TableIndexNoArray objectAtIndex:0]);
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source/////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"TableArray.count == %lu", (unsigned long)TableArray.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TableArray.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath == %lu", (unsigned long)indexPath.row);
    
    // Configure Cell
    EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *imgUrl = [NSString stringWithFormat:@"http://%s/bbs_manager/5_1/%@-1.png", KN_HOST_NAME, [TableIndexNoArray objectAtIndex:indexPath.row]];
    NSLog(@"imgUrl == %@", imgUrl);
    [cell.CellImage setImageURLString:imgUrl];
    
    [self ImageViewresizing];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSNumber *height;
    if (!height) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        height = @(cell.bounds.size.height);
    }
    return [height floatValue];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
///////////

//TableView Selected Cell
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EventDetailViewController *destController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    destController.indexPathRow = (int)indexPath.row;
    destController.CellPathRow = [TableIndexNoArray objectAtIndex:indexPath.row];   //게시물 넘버 -> 오리지날 이미지 넘버가 된다.
}
/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Section Header : %d", section];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"End of Section : %d", section];
}
*/
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
