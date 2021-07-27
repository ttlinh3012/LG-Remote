//
//  ChanelsVCViewController.h
//  LGUItest
//
//  Created by Soosky on 08/06/2021.
//

#import <UIKit/UIKit.h>
#import "ChanelsCollectionViewCell.h"
#import "ViewController.h"

@interface ChanelsVCViewController : ViewController<SetScreenDelegate,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end


