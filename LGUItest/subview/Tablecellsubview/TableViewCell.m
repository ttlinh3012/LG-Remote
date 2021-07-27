//
//  TableViewCell.m
//  LGUItest
//
//  Created by Soosky on 14/06/2021.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    _Tablecelllabel.highlighted = YES;
    _Tablecelllabel.highlightedTextColor = [UIColor colorWithRed:(10/255.f) green:1.0 blue:(239/255.f) alpha:1.0];
}

@end
