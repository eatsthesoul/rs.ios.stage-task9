//
//  UIColor+HexColor.h
//  Task7
//
//  Created by Evgeniy Petlitskiy on 4.07.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

+ (instancetype)colorFromHexString:(NSString *)hexString;
+ (instancetype)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
