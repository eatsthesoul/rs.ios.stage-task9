//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 4.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsMaster.h"

@implementation SettingsMaster

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _strokeHex = @"#f3af22";
        _isStoriesDrawn = YES;
    }
    return self;
}

+ (instancetype)sharedInstance {
    static SettingsMaster *uniqueInstance = nil;
    if (nil == uniqueInstance) {
        uniqueInstance = [[SettingsMaster alloc] initPrivate];
    }
    return uniqueInstance;
}

@end
