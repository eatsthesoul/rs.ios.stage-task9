//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 4.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsMaster : NSObject

@property (nonatomic, strong) NSString *strokeHex;
@property (nonatomic, assign) BOOL isStoriesDrawn;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
