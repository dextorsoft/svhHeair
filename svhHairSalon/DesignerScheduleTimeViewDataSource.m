//
//  DesignerScheduleTimeViewDataSource.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "DesignerScheduleTimeViewDataSource.h"
#import "DesignerScheduleTimeViewCell.h"

@implementation DesignerScheduleTimeViewDataSource

- (id) init {
    if (self = [super init]) {

    }
    
    return self;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    static NSString *CellIdentifierDesignerList = @"DesignerReserveTimeCell";
    UINib *reuseCell = [UINib nibWithNibName:@"DesignerScheduleTimeViewCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierDesignerList];
    
    DesignerScheduleTimeViewCell *cell = (DesignerScheduleTimeViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierDesignerList];
    
    if (cell == nil) {
        cell = (DesignerScheduleTimeViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierDesignerList];
    }
    
    for (NSDictionary *dic in _designerCutList) {
        NSString *reserveDate = dic[@"reserveDate"];
        NSRange range = NSMakeRange(11, 2);
        reserveDate = [reserveDate substringWithRange:range];
        
        NSString *timeList = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 10];
        
        if ([reserveDate isEqualToString:timeList]) {
            cell.lbl_reserveYN.text = @"예약불가";
            cell.lbl_reserveYN.textColor = [UIColor redColor];
        }
        else {
            cell.lbl_reserveYN.text = @"예약가능";
            cell.lbl_reserveYN.textColor = [UIColor blueColor];
        }
    }
    
    cell.lbl_time.text = [NSString stringWithFormat:@"%ld시", (long)indexPath.row + 10];
        
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 13;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(TimeListSelectedIndex:)]) {
        [self.delegate TimeListSelectedIndex:indexPath];
    }
}

@end