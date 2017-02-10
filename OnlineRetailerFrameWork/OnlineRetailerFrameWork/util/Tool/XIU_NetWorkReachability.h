//网络判断

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HLNetWorkStatus) {
    XIUNetWorkStatusNotReachable = 0,
    XIUNetWorkStatusUnknown = 1,
    XIUNetWorkStatusWWAN2G = 2,
    XIUNetWorkStatusWWAN3G = 3,
    XIUNetWorkStatusWWAN4G = 4,
    
    XIUNetWorkStatusWiFi = 9,
};

extern NSString *kNetWorkReachabilityChangedNotification;

@interface XIU_NetWorkReachability : NSObject

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;

- (BOOL)startNotifier;

- (void)stopNotifier;

- (HLNetWorkStatus)currentReachabilityStatus;

@end
