//
//  ChanelsCollectionViewCell.m
//  LGUItest
//
//  Created by Soosky on 08/06/2021.
//

#import "ChanelsCollectionViewCell.h"

@implementation ChanelsCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    _appview.layer.cornerRadius = 12;
    _AppImage.layer.cornerRadius = 12;
    // Initialization code

}

-(id)initWithFrame:(CGRect)frame

{

    self = [super initWithFrame:frame];

    if (self) {

        // Initialization code

    }

    return self;

}


@end
