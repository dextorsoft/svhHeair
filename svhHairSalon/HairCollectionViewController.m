//
//  HairCollectionViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 16..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "HairCollectionViewController.h"
#import "HairDetailViewController.h"
#import "HairCollectionViewCell.h"
#import "ForToolClass.h"
#import "UIImageView+AsyncAndCache.h"

#define kCellID @"CellHair"
#define kSupplementaryViewID @"SUP_VIEW_ID"

@interface HairCollectionViewController () {
    ForToolClass *forToolClass;
}

@property (strong, nonatomic) NSMutableArray* dataList;
@property (strong, nonatomic) UIPopoverController* infoPopover;

@end

@implementation HairCollectionViewController


#pragma mark - View Life-Cycle

- (void)viewDidLoad {
    
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    self.title = @"Hair";
///////////////////////////////////
    forToolClass = [[ForToolClass alloc] init];
    
    _dataList = [[NSMutableArray alloc] init];
    
    [self.dataList removeAllObjects];
    
    NSString *URL = [NSString stringWithFormat:@"http://%s/m_bbs_content_list.php?m_TN=2_1&m_Page=1&Result=2130&top=0",KN_HOST_NAME];

    NSLog(@"URL == %@", URL);
    HairData = [forToolClass GetHTMLString:URL encoding:KN_PHONE_LANG];
    NSLog(@"HairData1111111 == %@", HairData);
    HairData = [HairData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"HairData2222222 == %@", HairData);
    NSArray *URLimages = [HairData componentsSeparatedByString:@"<br>"];
    
    for (int i = 1; i <= URLimages.count - 2; i++) {
        
        if (URLimages.count == 0) {
            
        }else{
            
            NSArray *URLImageName = [[URLimages objectAtIndex:i] componentsSeparatedByString:@"|"];
            
            NSString *imageName = [NSString stringWithFormat:@"http://%s/bbs_manager/2_1/%@.png", KN_HOST_NAME, [URLImageName objectAtIndex:0]];
            
            [_dataList addObject:imageName];
            NSLog(@"imageName == %d - %@",i,imageName);
            
        }
    }
///////////////////////////////////
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


#pragma mark - PrepareForSegue
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    HairDetailViewController *destController = segue.destinationViewController;
    
    NSIndexPath *index = [indexPaths objectAtIndex:0];
    
    destController.indexPathRow = index.row;

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_dataList count] - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 재사용 큐에 셀을 가져온다
    HairCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    //표시할 이미지 설정
    //UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:100];

    [cell.HairCellImage setImageURLString:[_dataList objectAtIndex:indexPath.item]];
    
    [cell.HairCellImage.layer setCornerRadius:50];
    [cell.HairCellImage.layer setMasksToBounds:YES];
    
    //NSLog(@"size == %@", );
    
    return cell;
}
/*      --> header & footer Setting
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    }
    return view;
}
*/

////////////////////////////////////////

////////////////////////////////////////
@end
