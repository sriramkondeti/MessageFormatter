//
//  NSString+Formatter.m
//  MessageFormatter
//
//  Created by Sri Ram on 18/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

+(NSString *)formatString:(NSString *)message
{
    NSMutableDictionary *contentDict =[NSMutableDictionary dictionary];
    NSMutableArray *linksArray = [NSMutableArray array];
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber
                                                               error:&error];
    NSArray *matches = [detector matchesInString:message
                                         options:0
                                           range:NSMakeRange(0, [message length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypePhoneNumber && match.range.length<=12) {
            NSString *phoneNumber = [match phoneNumber];
            if ([message containsString:phoneNumber])
            message = [message stringByReplacingOccurrencesOfString:phoneNumber withString:@"************"];
        }
        else if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            if ([message containsString:[url absoluteString]]) {
            if ([[url host] isEqual:@"www.carlist.my"]) {
                message = [message stringByReplacingOccurrencesOfString :[url absoluteString] withString:@""];
                [linksArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[url absoluteString],@"url", nil]];
            }
            else
                message = [message stringByReplacingOccurrencesOfString :[url absoluteString] withString:@"************"];
            }
        }
    }
    [contentDict setObject:[[NSArray alloc] initWithObjects:message, nil] forKey:@"message"];
    if (linksArray.count>0)
    [contentDict setObject:linksArray forKey:@"Links"];
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:contentDict options:0 error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
