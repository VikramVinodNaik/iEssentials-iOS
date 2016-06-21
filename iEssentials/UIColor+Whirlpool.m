
#import "UIColor+Whirlpool.h"

@implementation UIColor (Whirlpool)

+ (UIColor *)whirlpoolBlueColor
{   
    return [UIColor colorWithRed:29/255.0 green:182/255.0 blue:219/255.0 alpha:1];
}

+ (UIColor *)whirlpoolOrangeColor
{
    return [UIColor colorWithRed:240/255.0 green:173/255.0 blue:0/255.0 alpha:1];
}

+ (UIColor *)whirlpoolEnergyBlueColor
{
    return [UIColor colorWithRed:91/255.0 green:156/255.0 blue:188/255.0 alpha:1.0];
}

+ (UIColor *)whirlpoolEnergyOrangeColor
{
    return [UIColor colorWithRed:242/255.0 green:142/255.0 blue:28/255.0 alpha:1];
}

+ (UIColor *)whirlpoolGrayColor
{
    // used for a lot of text, AKA #9B9B9B
    return [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
}

+ (UIColor *)whirlpoolDragHandleColor
{
    return [UIColor colorWithRed:245/255.0 green:243/255.0 blue:243/255.0 alpha:1];
}

+ (UIColor *)whirlpoolDarkGrayColor
{
    // used for a lot of text, AKA #646464
    return [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
}

+ (UIColor *)whirlpoolGreenColor
{
    return [UIColor colorWithRed:128/255.0 green:191/255.0 blue:3/255.0 alpha:1];
}

+ (UIColor *)whirlpoolYellowColor
{
    return [UIColor colorWithRed:242/255.0 green:142/255.0 blue:28/255.0 alpha:1];
}

+ (UIColor *)whirlpoolRedColor
{
    // B40000
    return [UIColor colorWithRed:180/255.0 green:0/255.0 blue:0/255.0 alpha:1];
}

+ (UIColor *)whirlpoolNoColor
{
    return [UIColor clearColor];
}

+ (UIColor *)whirlpoolContentviewYellowColor
{
    return [UIColor colorWithRed:234/255.0 green:158/255.0 blue:10/255.0 alpha:1];
}

+ (UIColor *)whirlpoolBlueBorderColor
{
    return [UIColor colorWithRed:167/255.0 green:216/255.0 blue:220/255.0 alpha:1];
}


+ (UIColor *)whirlpoolToolBarColor
{
    return [UIColor colorWithRed:54/255.0 green:56/255.0 blue:56/255.0 alpha:1];
}

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
