//
//  DetectTVViewController.m
//  LGUItest
//
//  Created by Soosky on 18/06/2021.
//
#import "DetectTVViewController.h"
#import "DetectTVCell.h"
#import "ViewController.h"
#import "TabbarController.h"
#import "ChanelsVCViewController.h"
#import "ChanelsVCViewController.h"
#import "WebOSTVService.h"
#import "DIALService.h"
#import "WebOSTVService.h"
#import "SSDPDiscoveryProvider.h"
#import "AppDelegate.h"


@interface DetectTVViewController ()

@end

@implementation DetectTVViewController{
    NSMutableArray *_generatedDeviceList;
    DiscoveryManager *_discoveryManager;
    DevicePicker *_devicePicker;
    ConnectableDevice *_device;
    UIActivityIndicatorView *spinner;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detectTable.delegate = self;
    self.detectTable.dataSource = self;
//    _discoveryManager.pairingLevel = DeviceServicePairingLevelOn;
    _discoveryManager = [DiscoveryManager sharedManager];
    [_discoveryManager startDiscovery];
    _discoveryManager.delegate =self;
    UINib *nib = [UINib nibWithNibName:@"DetectTVCell" bundle:nil];
    [self.detectTable  registerNib:nib forCellReuseIdentifier:@"DetectTVCell"];
    _generatedDeviceList = [NSMutableArray array];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.connectAbleDevices = [NSMutableArray arrayWithArray:_generatedDeviceList];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self loadingAnimate];
    
}

-(void)loadingAnimate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        spinner.center = CGPointMake(self.detectTable.center.x,15);
    spinner.center = CGPointMake(self.detectTable.center.x,40);
    if(appDelegate.connectAbleDevices.count==0)
    {
        
//        spinner.tag = 0;
        
        [self.detectTable addSubview:spinner];
        [spinner startAnimating];
    }
    if (appDelegate.connectAbleDevices.count)
    {
        [spinner removeFromSuperview];
        
    }
}
-(void)removeSpinnerAnimate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.connectAbleDevices.count)
    {
        [spinner removeFromSuperview];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark UITableViewDelegate methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ConnectableDevice *device = (ConnectableDevice *) [appDelegate.connectAbleDevices objectAtIndex:(NSUInteger) indexPath.row];
    [self.sendDelegate Currentdevice:device];
    [self CancelScrenDetect];
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%lu",(unsigned long)appDelegate.connectAbleDevices.count);
    return appDelegate.connectAbleDevices.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ConnectableDevice *device = (ConnectableDevice *) [appDelegate.connectAbleDevices objectAtIndex:(NSUInteger) indexPath.row];
    DetectTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetectTVCell" forIndexPath:indexPath];
    cell.detectcellLable.text = device.friendlyName ;
    return cell;
}

#pragma mark DismissPage

- (IBAction)cacelBtn:(id)sender {
    [self CancelScrenDetect];
}
-(void)CancelScrenDetect
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark DiscoveryManagerDelegate

-(void)addDeviceToArray:(ConnectableDevice*)device{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appDelegate.connectAbleDevices containsObject:device]){
        [appDelegate.connectAbleDevices addObject:device];
        NSLog(@"dddd %lu",(unsigned long)appDelegate.connectAbleDevices.count);
    }
    [_detectTable reloadData];
}
-(void)discoveryManager:(DiscoveryManager *)manager didFindDevice:(ConnectableDevice *)device{
    [self addDeviceToArray:device];
    [self removeSpinnerAnimate];
    NSLog(@"did add decive %@",device.friendlyName);
}
-(void)discoveryManager:(DiscoveryManager *)manager didLoseDevice:(ConnectableDevice *)device{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.connectAbleDevices removeObject:device];
    [_detectTable reloadData];
    NSLog(@"did remove decive %@",device.friendlyName);
}
-(void)discoveryManager:(DiscoveryManager *)manager didUpdateDevice:(ConnectableDevice *)device{
    [self addDeviceToArray:device];
}
-(void)discoveryManager:(DiscoveryManager *)manager didFailWithError:(NSError *)error{
    [_detectTable reloadData];
}


@end
