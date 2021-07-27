//
//  DetectTVCell.m
//  LGUItest
//
//  Created by Soosky on 18/06/2021.
//

#import "DetectTVCell.h"

@implementation DetectTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected){
    _detectviewImage.image = [UIImage imageNamed:@"big button.png"];
    _detectcellLable.highlightedTextColor  = [UIColor colorWithRed:(0/255.f) green:(126/255.f) blue:(118/255.f) alpha:1.0];
    }
    else{
        _detectviewImage.image = [UIImage imageNamed:@"big button common.png"];
    }
    
}

@end
