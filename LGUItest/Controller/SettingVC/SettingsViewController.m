//
//  SettingsViewController.m
//  LGUItest
//
//  Created by Soosky on 08/06/2021.
//
#import <StoreKit/StoreKit.h>
#import "SettingsViewController.h"
#import "TableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>

static NSString * const AppId = @"1552327401";
static NSString * const policy = @"https://sites.google.com/view/remotecontroltvpolicy/";
static NSString * const term = @"https://sites.google.com/view/remotecontroltermsofuse/";
//NSArray * const GroupMail = [NSArray arrayWithObject:@"bestfreeappsgames@gmail.com"];
static NSString * const MoreAppslink = @"https://apps.apple.com/us/developer/technology-product-and-service-llc/id1463254585";

@interface SettingsViewController ()

@end

@implementation SettingsViewController{
    NSArray *celllist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.UItableview.delegate = self;
    self.UItableview.dataSource = self;
    celllist = [NSArray arrayWithObjects:@"Rate App",@"Feedback", @"Privacy Policy", @"Terms of Use", @"More App",nil];
//    NSLog(@"zzzz %lu",(unsigned long)celllist.count);
    
    UINib *nib = [UINib nibWithNibName:@"tablecellsubview" bundle:nil];
    [self.UItableview  registerNib:nib forCellReuseIdentifier:@"tablecellsubview"];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecellsubview"];
    cell.Tablecelllabel.text = [celllist objectAtIndex: indexPath.row] ;
    
    return cell;
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger select = indexPath.row;

    switch (select){
        case 0:[self RateApp:Constants.APP_ID];
            
            break;
        case 1:[self Feedback];
        
            break;
        case 2:[self PrivacyPolicy];
           
            break;
        case 3:[self TermsOfUse];
            
            break;
        case 4:[self MoreApps];
            
            break;
        default:break;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return celllist.count;
}


-(void)RateApp:(NSString*)AppID
{
    if (@available(iOS 10.3, *)) {
            [SKStoreReviewController requestReview];
        }
    else
    {
        NSString *bodyurl = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@?mt=8&action=write-review",AppID];
        NSLog(@"1234 %@",bodyurl);
    //    NSLog(@"vvvv %@",body);
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:bodyurl];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Rate App");
            }
        }];
    }
}

-(void)Feedback{
//    NSLog(@"Feedback");
    NSURL* urls = [[NSURL alloc]init];
    NSArray * const GroupMail = [NSArray arrayWithObject:@"bestfreeappsgames@gmail.com"];
    NSString* appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString* subJect = [NSString stringWithFormat:@"[FEEDBACK] %@",appName];
    NSString* body = @"<p>You're so awesome!</p>";
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer;
        mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:GroupMail];
        [mailer setSubject:subJect];
        [mailer setMessageBody:body isHTML:YES];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else if ((urls =[self createEmailUrl:GroupMail[0] Subject:subJect Body:body])){
        UIApplication *application = [UIApplication sharedApplication];
        NSLog(@"%@", urls);
        [application openURL:urls options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"send mail sucess");
            } else {
                NSLog(@"send mail error");
            }
        }];
    }
    else{
        [self showMailError];
    }
}

-(NSURL*)createEmailUrl:(NSString*)to Subject:(NSString*)subject Body:(NSString*)body  {
    NSURL* url;
    url = [[NSURL alloc]init];
    NSString *subjectEncoded = [subject stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *bodyEncoded = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString* gmailUrlstring = [NSString stringWithFormat:@"googlegmail://co?to=%@&subject=%@&body=%@",to,subjectEncoded,bodyEncoded];
    NSURL* gmailUrl = [NSURL URLWithString:gmailUrlstring];
    
    NSString* outlookUrlstring = [NSString stringWithFormat:@"ms-outlook://compose?to=%@&subject=\%@",to,subjectEncoded];
    NSURL* outlookUrl = [NSURL URLWithString:outlookUrlstring];
    
    NSString* yahooMailstring = [NSString stringWithFormat:@"ymail://mail/compose?to=%@&subject=%@&body=%@",to,subjectEncoded,bodyEncoded];
    NSURL* yahooMail = [NSURL URLWithString:yahooMailstring];
    
    NSString* sparkUrlstring = [NSString stringWithFormat:@"readdle-spark://compose?recipient=%@&subject=%@&body=%@",to,subjectEncoded,bodyEncoded];
    NSURL* sparkUrl = [NSURL URLWithString:sparkUrlstring];
    
    NSString* defaultstring = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",to,subjectEncoded,bodyEncoded];
    NSURL* defaultlUrl = [NSURL URLWithString:defaultstring];
    
    if ([[UIApplication sharedApplication] canOpenURL:gmailUrl]){
        url = gmailUrl;
    }
    else if ([[UIApplication sharedApplication] canOpenURL:outlookUrl]){
        url = outlookUrl;
    }
    else if ([[UIApplication sharedApplication] canOpenURL:yahooMail]){
        url = yahooMail;
    }
    else if ([[UIApplication sharedApplication] canOpenURL:sparkUrl]){
        url = sparkUrl;
    }
    else {
        url = defaultlUrl;
    }
    return url;
}

-(void)showMailError {
    UIAlertController* sendMailErrorAlert = [UIAlertController alertControllerWithTitle:@"My Alert"
                               message:@"This is an alert."
                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [sendMailErrorAlert addAction:dismiss];
    [self presentViewController:sendMailErrorAlert animated:YES completion:nil];
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)PrivacyPolicy{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:policy];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"policy");
        }
    }];
}

-(void)TermsOfUse{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:term];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Term");
        }
    }];
}

-(void)MoreApps{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:MoreAppslink];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"More Apps");
        }
    }];
}

@end




