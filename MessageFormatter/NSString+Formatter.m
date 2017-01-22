//
//  NSString+Formatter.m
//  MessageFormatter
//
//  Created by Sri Ram on 18/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

+ (NSString *)formatString:(NSString *)message {
  NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];//To Parse the values to Json String.
  NSMutableArray *linksArray = [NSMutableArray array];//To Save the the Links if URL Host is carlist.my
  NSError *error = nil;
  NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink |
                                            NSTextCheckingTypePhoneNumber
                                      error:&error];//To Detect Links and Phone Numbers in String.
  __block NSInteger offset = 0; // keeps track of range changes in the string
  __block NSString *formattedMessage = message;
  [detector
      enumerateMatchesInString:formattedMessage
                       options:0
                         range:NSMakeRange(0, [formattedMessage length])
                    usingBlock:^(NSTextCheckingResult *_Nullable match,
                                 NSMatchingFlags flags, BOOL *_Nonnull stop) {
                      NSRange resultRange = [match range];
                      resultRange.location += offset; // resultRange.location is updated
                      NSString *replacement = @"************";
                      if ([match resultType] == NSTextCheckingTypePhoneNumber && match.range.length <= 16) //Required Format:+CCAABBBBBBB (Min and max length of 11 digits with prefix of “+”), But Length modified to 16 to Support Various PhoneNumber Fomrats in Asia.
                      {
                        formattedMessage = [formattedMessage
                            stringByReplacingCharactersInRange:resultRange
                                                    withString:replacement];
                      } else if ([match resultType] == NSTextCheckingTypeLink) {
                        NSURL *url = [match URL];
                        if ([url.absoluteString rangeOfString:@"carlist.my"].location != NSNotFound) {
                          replacement = @"";
                          formattedMessage = [formattedMessage
                              stringByReplacingCharactersInRange:resultRange
                                                      withString:replacement];
                          [linksArray addObject:[[NSMutableDictionary alloc]
                                                    initWithObjectsAndKeys:
                                                        [url absoluteString],
                                                        @"url", nil]];//Add URL of host carlist.my to Links array.
                        } else {
                          formattedMessage = [formattedMessage
                              stringByReplacingCharactersInRange:resultRange
                                                      withString:replacement];
                        }
                        offset += ([replacement length] - resultRange.length);//Update offset after replacing the strings.
                      }
                    }];
  [contentDict setObject:[[NSArray alloc] initWithObjects:formattedMessage, nil] forKey:@"message"];
  if (linksArray.count > 0)
    [contentDict setObject:linksArray forKey:@"Links"];//Add only if it contains objects.
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDict
                                                     options:0
                                                       error:&error];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];// Retunrn NSString of Json Data.
}
@end
