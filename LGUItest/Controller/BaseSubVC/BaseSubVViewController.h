//
//  BaseSubVViewController.h
//  LGUItest
//
//  Created by Soosky on 06/07/2021.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
typedef enum {
    removeads   = 0,
    weekly      = 1,
    monthly     = 2,
    yearly      = 3,
    iap         = 4,
} RegisteredPurchase;

@interface BaseSubVViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>
   
@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;
-(void)subbutton:(RegisteredPurchase)keyname;
-(void)restorepurchase;
-(void)addPurchase:(NSString*)productID;
+(BOOL)checkInAppPurchaseStatus;
//- (void)validateRenewablePurchases:(NSArray<NSString *> *)products callback:(void (^)(NSDictionary *values, NSString *errorMessage))callback;
@end
