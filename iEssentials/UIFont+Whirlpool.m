
#import "UIFont+Whirlpool.h"

@implementation UIFont (Whirlpool)

+ (UIFont *)whirlpoolRegularFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Helvetica" size:size];
}

+ (UIFont *)whirlpoolItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Helvetica-Oblique" size:size];
}

+ (UIFont *)whirlpoolBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
}

+ (UIFont *)whirlpoolB1Font
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 30 : 16;
    return [UIFont whirlpoolBoldFontOfSize:size];
}

+ (UIFont *)whirlpoolR1Font
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 30 : 16;
    return [UIFont whirlpoolRegularFontOfSize:size];
}

+ (UIFont *)whirlpoolB2Font
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 24 : 13;
    return [UIFont whirlpoolBoldFontOfSize:size];
}

+ (UIFont *)whirlpoolR2Font
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 24 : 13;
    return [UIFont whirlpoolRegularFontOfSize:size];
}

+ (UIFont *)whirlpoolR3Font
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 18 : 12;
    return [UIFont whirlpoolRegularFontOfSize:size];
}

+ (UIFont *)whirlpoolR3ItalicFont
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 18 : 12;
    return [UIFont whirlpoolItalicFontOfSize:size];
}

+ (UIFont *)whirlpoolLargeFont
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 58 : 32;
    return [UIFont whirlpoolBoldFontOfSize:size];
}

+ (UIFont *)whirlpoolJumboFont
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 80 : 40;
    return [UIFont whirlpoolBoldFontOfSize:size];
}

+ (UIFont *)whirlpoolTabFont
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 15 : 11;
    return [UIFont whirlpoolRegularFontOfSize:size];
}

+ (UIFont *)whirlpoolPowerFont
{
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 40 : 26;
    return [UIFont whirlpoolBoldFontOfSize:size];
}

+ (UIFont *)whirlpoolAmazonNotificationFont
{
    
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 20 : 12;
    return [UIFont whirlpoolBoldFontOfSize:size];
    
}

+ (UIFont *)whirlpoolSmallItalicFont
{
    
    int size = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 14 : 8;
    return [UIFont whirlpoolItalicFontOfSize:size];
    
}

@end
