//
//  DesignerCutListViewDataSource.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "DesignerCutListViewDataSource.h"

@implementation DesignerCutListViewDataSource

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    static NSString *CellIdentifierCutList = @"CutCellCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierCutList];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierCutList];
    }
    
    NSDictionary *dic = [_cutArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"cutKind"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cutArray.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(CutSelectedIndex:)]) {
        [self.delegate CutSelectedIndex:indexPath];
    }
}

@end
