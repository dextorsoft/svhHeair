//
//  ScheduleDetailTableViewDataSource.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 18..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ScheduleDetailTableViewDataSource.h"
#import "ScheduleDetailTableViewCell.h"

@implementation ScheduleDetailTableViewDataSource

- (id) init {
    if (self = [super init]) {
        _designerCachedImages = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    static NSString *CellIdentifierDesignerList = @"DesignerCell";
    UINib *reuseCell = [UINib nibWithNibName:@"ScheduleDetailTableViewCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierDesignerList];
    
    ScheduleDetailTableViewCell *cell = (ScheduleDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifierDesignerList];
    if (cell == nil) {
        cell = (ScheduleDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifierDesignerList];
    }
    
    NSDictionary *originalDesignerDic = [_designList objectAtIndex:indexPath.row];
    
    for (NSDictionary *dic in _designDate) {
        
        NSString *designerCode = [dic objectForKey:@"designerCode"];
        NSString *productName = [dic objectForKey:@"productName"];
        
        if ([designerCode isEqualToString:[originalDesignerDic objectForKey:@"code"]] && [productName isEqualToString:@"휴무"]) {
            cell.lbl_reserveYN.text = @"예약불가";
            [cell.lbl_reserveYN setTextColor:[UIColor redColor]];
        }
        else {
            cell.lbl_reserveYN.text = @"예약가능";
            [cell.lbl_reserveYN setTextColor:[UIColor blueColor]];
        }
    }
    
    // 각 셀 바인딩 시작
    
    // 캐싱 이미지
    
    NSString *imageIdentifier = [NSString stringWithFormat:@"Cell%ld", (long)indexPath.row];
    if ([_designerCachedImages objectForKey:imageIdentifier] != nil) {
        
        if (![[_designerCachedImages objectForKey:imageIdentifier] isKindOfClass:[NSString class]]) {
            [cell.designerImage setImage:[_designerCachedImages valueForKey:imageIdentifier]];
        }
    }
    else {
        char const * s = [imageIdentifier  UTF8String];
        dispatch_queue_t queue = dispatch_queue_create(s, 0);
        dispatch_async(queue, ^{
            
            UIImage *designerImg = nil;
            NSString *imgUrl = [NSString stringWithFormat:@"http://%s/member_img/%@.png", KN_HOST_NAME, [originalDesignerDic objectForKey:@"code"]];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            
            designerImg = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!imageData) {
                    [_designerCachedImages setValue:@"no" forKey:imageIdentifier];
                }
                else {
                    [_designerCachedImages setValue:designerImg forKey:imageIdentifier];
                    [cell.designerImage setImage:[_designerCachedImages valueForKey:imageIdentifier]];
                }
            });
        });
    }
    
    cell.lbl_designerName.text = [originalDesignerDic objectForKey:@"name"];

    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _designList.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(DesignerListSelectedIndex:)]) {
        
        // 디자이너 코드 넘겨주기
        NSDictionary *originalDesignerDic = [_designList objectAtIndex:indexPath.row];
        [self.delegate DesignerListSelectedIndex:[originalDesignerDic objectForKey:@"code"]];
    }    
}

@end
