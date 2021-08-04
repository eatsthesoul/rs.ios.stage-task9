//
//  UIColor+HexColor.m
//  Task7
//
//  Created by Evgeniy Petlitskiy on 4.07.21.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (instancetype)colorFromHexString:(NSString *)hexString {
  NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
  if([cleanString length] == 3) {
      cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                     [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                     [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                     [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
  }
  if([cleanString length] == 6) {
      cleanString = [cleanString stringByAppendingString:@"ff"];
  }

  unsigned int baseValue;
  [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

  float red = ((baseValue >> 24) & 0xFF)/255.0f;
  float green = ((baseValue >> 16) & 0xFF)/255.0f;
  float blue = ((baseValue >> 8) & 0xFF)/255.0f;
  float alpha = ((baseValue >> 0) & 0xFF)/255.0f;

  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (instancetype)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha {
    UIColor *color = [self colorFromHexString:hexString];
    return [color colorWithAlphaComponent:alpha];
}

@end
