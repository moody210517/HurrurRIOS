//
//  NSString+NSString_HTMLTrim.m
//  Wordpress News App
//

#import "NSString+HTMLTrim.h"

@implementation NSString (HTMLTrim)

- (NSString *)stringWithTrimmedHTML
{
    NSRange range;
    NSString *string = [self copy];

    // Iterate through string and if find html tag replace it with empty character
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }

    // Remove HTML codes
    return [self unescapeHtmlCodes:string];
}

- (NSString*)unescapeHtmlCodes:(NSString*)input {
    //    NSMutableString *mutableString = [NSMutableString stringWithString:input];
    //    mutableString replaceOccurrencesOfString:@"&rsquo;" withString:@"'" options:<#(NSStringCompareOptions)#> range:<#(NSRange)#>
    input = [input stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    input = [input stringByReplacingOccurrencesOfString:@"&#039;" withString:@"&"];
    input = [input stringByReplacingOccurrencesOfString:@"&#8230;" withString:@"..."];
    input = [input stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"];
    input = [input stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    input = [input stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&Eacute;" withString:@"É"];
    input = [input stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
    input = [input stringByReplacingOccurrencesOfString:@"&Agrave;" withString:@"À"];
    input = [input stringByReplacingOccurrencesOfString:@"&agrave;" withString:@"à"];
    input = [input stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
    input = [input stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"];
    input = [input stringByReplacingOccurrencesOfString:@"&Egrave;" withString:@"È"];
    input = [input stringByReplacingOccurrencesOfString:@"&egrave;" withString:@"è"];
    input = [input stringByReplacingOccurrencesOfString:@"&Ocirc;" withString:@"Ô"];
    input = [input stringByReplacingOccurrencesOfString:@"&ocirc;" withString:@"ô"];
    input = [input stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"»"];
    input = [input stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"«"];
    

    //    NSRange rangeOfHTMLEntity = [input rangeOfString:@"&#"];
    //
    //    if (NSNotFound == rangeOfHTMLEntity.location) {
    //        return input;
    //    }
    //
    //    NSMutableString* answer = [[NSMutableString alloc] init];
    //
    //    NSScanner* scanner = [NSScanner scannerWithString:input];
    //    [scanner setCharactersToBeSkipped:nil];
    //
    //    while (![scanner isAtEnd]) {
    //
    //        NSString* fragment;
    //        [scanner scanUpToString:@"&#" intoString:&fragment];
    //        if (nil != fragment) {
    //            [answer appendString:fragment];
    //        }
    //
    //        if (![scanner isAtEnd]) {
    //            int scanLocation = (int)[scanner scanLocation];
    //            [scanner setScanLocation:scanLocation+2];
    //
    //            int htmlCode;
    //            if ([scanner scanInt:&htmlCode]) {
    //                char c = htmlCode;
    //                [answer appendFormat:@"%c", c];
    //
    //                scanLocation = (int)[scanner scanLocation];
    //                [scanner setScanLocation:scanLocation+1];
    //            }
    //        }
    //    }
    
    return input;
}

@end
