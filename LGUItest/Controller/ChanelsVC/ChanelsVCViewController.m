//
//  ChanelsVCViewController.m
//  LGUItest
//
//  Created by Soosky on 08/06/2021.
//

#import "ChanelsVCViewController.h"
#import "ChanelsCollectionViewCell.h"
#import "TabbarSubView.h"




@interface ChanelsVCViewController (){
//    TabbarSubView *tablesubview;
}
@end

@implementation ChanelsVCViewController{
    NSMutableArray *_myCollectionArray;
    NSArray *_appList;
    NSArray *AppImageName;
    int _currentApp;
    ServiceSubscription *_runningAppSubscription;
//    tabbarsubview *subview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    AppImageName = [NSArray arrayWithObjects:@"YouTube", @"iQIYI", @"VieON", @"Twitch", @"Netflix", @"Magic Number", @"Live Zoom App", @"Live HbbTV", @"LG Content Store", @"Google Assistant", @"FPT Play", @"Galaxy Play", @"Cài đặt", @"Ảnh & Video", @"Brand Shop", @"Apple TV", @"Âm nhạc", @"Amazon Prime Video", @"AirPlay", @"AV1", @"AV2", @"AV", @"Trình duyệt Web", nil];
//    NSString *emailRegex = @"Tìm kiếm web";
//    NSArray *filteredArray = [AppImageName filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@", emailRegex]];
//    NSLog(@"%@",filteredArray[0]);
//    NSLog(@"abcd %lu",(unsigned long)filteredArray.count);

//    tablesubview.screenDelegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.device)
    {
        _appList = [[NSArray alloc] init];

        if ([self.device hasCapability:kLauncherAppList])
        {
            [self.device.launcher getAppListWithSuccess:^(NSArray *appList)
            {
                NSLog(@"Get app list success");
                self->_appList = appList;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self reloadData];
                });
            } failure:^(NSError *err)
            {
                NSLog(@"Get app list Error %@", err.description);
            }];
        }
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"ChanelsCollectionViewCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"ChanelsCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width - 2.0 ;
//    CGFloat viewW = collectionView.bounds.size.width - 2.0;
    NSLog(@"bbb %f",viewW);
    NSLog(@" vvv %f",self.view.frame.size.width);
//    NSLog(@"ssss %f",self.collectionView.cel);
    return CGSizeMake(viewW/2, 164);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"xxxxx.  %lu",(unsigned long)_appList.count);
    AppInfo *app = (AppInfo *) [_appList objectAtIndex:(NSUInteger) indexPath.row];
    [self.device.launcher launchAppWithInfo:app success:^(LaunchSession *launchSession)
    {
        NSLog(@"Launched application %@", launchSession);
    }                               failure:^(NSError *error)
    {
        NSLog(@"no launchApp %@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _appList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"xxxxx.  %lu",(unsigned long)_appList.count);
    AppInfo *appInfo = (AppInfo *) [_appList objectAtIndex:(NSUInteger) indexPath.row];
   
    ChanelsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChanelsCollectionViewCell" forIndexPath:indexPath];
    cell.AppLabel.text = appInfo.name;
//    cell.detailTextLabel.text = appInfo.id;
    [cell.AppLabel setText:[NSString stringWithFormat:@"%@", cell.AppLabel.text]];
    
    NSArray *filteredArray = [AppImageName filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@", appInfo.name]];
    NSLog(@"%@",filteredArray);
    NSLog(@"%lu",(unsigned long)filteredArray.count);
    NSLog(@"xzxzx");
//    BOOL isTheObjectThere = [AppImageName containsObject: appInfo.name];
//    NSLog(@"%@", isTheObjectThere);
    if (filteredArray && (![appInfo.name  isEqual: @"Ảnh & Video"]) ){
        NSString* AppImagename = [NSString stringWithFormat:@"%@.png",appInfo.name];
        cell.AppImage.image = [UIImage imageNamed:AppImagename];
    }
    if ([appInfo.name isEqual: @"Ảnh & Video"]){
        cell.AppImage.image = [UIImage imageNamed:@"Ảnh _ Video.png"];
    }
    
    
    if (filteredArray.count == 0){
          
        cell.AppImage.image = [UIImage imageNamed:@"default.png"];
        }
    
    return cell;
}

- (void) reloadData
{
    NSSortDescriptor *titleSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:titleSortDescriptor];
    _appList = [_appList sortedArrayUsingDescriptors:sortDescriptors];
    
    [_collectionView reloadData];
}

@end
