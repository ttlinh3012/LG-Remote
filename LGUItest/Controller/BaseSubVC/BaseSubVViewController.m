//
//  BaseSubVViewController.m
//  LGUItest
//
//  Created by Soosky on 06/07/2021.
//

#import "BaseSubVViewController.h"
#import <StoreKit/StoreKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
//#import "RMStore.h"


@interface BaseSubVViewController ()

@end

@implementation BaseSubVViewController{
    NSString *user;
    NSUserDefaults *defaults;
    UIAlertView *_purChaseAlert;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
    defaults = [NSUserDefaults standardUserDefaults];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
}


-(void)subbutton:(RegisteredPurchase)keyname;
{
    NSString *keyString;

    switch (keyname)
    {
        
        case removeads  : keyString = @".removeads"; break;
        case weekly     : keyString = @".weekly"; break;
        case monthly    : keyString = @".monthly"; break;
        case yearly     : keyString = @".yearly"; break;
        case iap        : keyString = @".iap"; break;
        default:break;
    }
    if(keyString)
    {
        NSString *buttonString = [NSString stringWithFormat:@"com.lg.remote%@", keyString];
        self.productID = buttonString;
//        [self addPurchase:buttonString];
    }
}

-(void)addPurchase:(NSString*)productID{
    if([SKPaymentQueue canMakePayments]){
            SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productID]];
            request.delegate =self;
            [request start];
        }
        else{
    
            NSLog(@"please enable IAP");
        }
}







//-(void)getPurchase
//{
//    if([SKPaymentQueue canMakePayments]){
//        SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
//        request.delegate =self;
//        [request start];
//    }
//    else{
//
//        NSLog(@"please enable IAP");
//    }
//
//}
//
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    NSLog(@"x x x %lu",(unsigned long)products.count);
    if (products.count != 0)
    {
        self.product = products[0];
        NSLog(@"y y y %@",self.product.localizedDescription);
        [self purchase:products[0]];
    }
    else
    {
        NSLog(@"please enable IAP");
    }

    products = response.invalidProductIdentifiers;
    for (SKProduct *product in products)
    {
        NSLog(@"z z z  %@",product);
    }

}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];

//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
-(void)restorepurchase{
    //this is called when the user restores purchases, you should hook this up to a button
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            NSLog(@"Transaction state -> Restored");
            [defaults setValue:@"sub_purchased" forKey:@"user"];
//                    [defaults synchronize];
            NSLog(@"%@",user);
            [self cancelview];
            break;
            
        }
    }
}
-(void)cancelview
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if((appDelegate.CreatedNavigation==NO))
        
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNavigation];
        });
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
-(void)showAlertPurchased{
    _purChaseAlert = [[UIAlertView alloc] initWithTitle:@"Purchase Sucsess"
                                                    message:@"You have already purchased this package!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

}
-(void)changeuser{
    dispatch_async(dispatch_get_main_queue(), ^{
//        bool a = [self->_productID isEqual:@"com.lg.remote.yearly"];
        
        if ([self->_productID isEqual:@"com.lg.remote.yearly"])
        {
            
            [[NSUserDefaults standardUserDefaults] setValue:@"sub_purchased" forKey:@"user"];
//            [self->defaults synchronize];
            self->user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
            NSLog(@"vvvvv %@",self->user);
            NSLog(@"vvvvvv %@",self->_productID);
            [self->_purChaseAlert show];
            [self cancelview];
        }
        else if ([self->_productID isEqual:@"com.lg.remote.weekly"])
        {
            [self->defaults setValue:@"sub_purchased" forKey:@"user"];
//            [self->defaults synchronize];
            self->user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
            NSLog(@"vvvvv %@",self->user);
            NSLog(@"vvvvvv %@",self->_productID);
            [self->_purChaseAlert show];
            [self cancelview];
        }
        else if ([self->_productID isEqual:@"com.lg.remote.removeads"])
        {
            NSLog(@"remove ads");
            [self->defaults setValue:@"paid" forKey:@"user"];
//            [self->defaults synchronize];
            self->user = [[NSUserDefaults standardUserDefaults]stringForKey:@"user"];
            NSLog(@"%@",self->user);
            [self->_purChaseAlert show];
            [self cancelview];
        }
    });
}
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        //if you have multiple in app purchases in your app,
        //you can get the product identifier of this transaction
        //by using transaction.payment.productIdentifier
        //
        //then, check the identifier against the product IDs
        //that you have defined to check which product the user
        //just purchased

        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"ddddd %@",_productID);
            //this is called when the user has successfully purchased the package (Cha-Ching!)
//                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self changeuser];
                [self showAlertPurchased];
                NSLog(@"Transaction state -> Purchased");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                [self changeuser];
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self changeuser];
                break;
            case SKPaymentTransactionStateFailed:
                
                if(transaction.error.code == SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
           
            case SKPaymentTransactionStateDeferred:
                NSLog(@"in the deferred");
                break;
        }
    }
    
}

+ (BOOL)checkInAppPurchaseStatus
{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    
    if (receipt) {
        BOOL sandbox = [[receiptURL lastPathComponent] isEqualToString:@"sandboxReceipt"];
        NSError *error;
        NSDictionary *requestContents = @{
            @"receipt-data": [receipt base64EncodedStringWithOptions:0],@"password":Constants.App_Specific_Shared_Secret
                                                 };
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                              options:0
                                                                error:&error];

        if (requestData) {
            NSURL *storeURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
            if (sandbox) {
                storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
            }
            NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
            [storeRequest setHTTPMethod:@"POST"];
            [storeRequest setHTTPBody:requestData];

            BOOL rs = NO;
            //Can use sendAsynchronousRequest to request to Apple API, here I use sendSynchronousRequest
            NSError *error;
            NSURLResponse *response;
            NSData *resData = [NSURLConnection sendSynchronousRequest:storeRequest returningResponse:&response error:&error];

            
            if (error) {
                rs = NO;
            }
            else
            {
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:resData options:0 error:&error];
                if (!jsonResponse) {
                    rs = NO;
                }
                else
                {
                    NSLog(@"jsonResponse:%@", jsonResponse);

                    NSDictionary *dictLatestReceiptsInfo = jsonResponse[@"latest_receipt_info"];
                    long long int expirationDateMs = [[dictLatestReceiptsInfo valueForKeyPath:@"@max.expires_date_ms"] longLongValue];
//                    long long requestDateMs = [[dictLatestReceiptsInfo valueForKeyPath:@"@max.purchase_date_ms"] longLongValue];
                    long long requestDateMs = [jsonResponse[@"receipt"][@"request_date_ms"] longLongValue];
                    NSLog(@"b b b b %lld,%lld",expirationDateMs,requestDateMs);
                    NSLog(@"b b b b %lld--%lld", expirationDateMs, requestDateMs);
                    long status = [[jsonResponse objectForKey:@"status"] integerValue];
                    rs = (status==0)&&(expirationDateMs>requestDateMs) ;
                    
                }
            }
            return rs;
            
            
            
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
    
}


@end


