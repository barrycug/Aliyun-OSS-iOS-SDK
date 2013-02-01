/*
 Copyright 2012 baocai zhang. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE FREEBSD PROJECT ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.
 */
/*
 @author baocai zhang
 website:www.giser.net
 email:zhangbaocaicug@gmail.com
 */

#import "DateUtil.h"

@implementation DateUtil
+(NSString*) RFC822_DATE_FORMAT
{
    return @"EEE, dd MMM yyyy HH:mm:ss z";
}
+(NSString*) ISO8601_DATE_FORMAT
{
    return @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
};
+(NSString*)ALTERNATIVE_ISO8601_DATE_FORMAT 
{
    return @"yyyy-MM-dd'T'HH:mm:ss'Z'";
}
+(NSString*) formatRfc822Date:(NSDate*) date
{
    NSString * strDate= [[DateUtil Rfc822DateFomatter] stringFromDate:date];
    NSRange rang = [strDate rangeOfString:@"GMT+"];
    NSString * rtn=strDate;
    if (rang.length > 0) {
        rtn = [strDate substringToIndex:rang.location+3];
    }
    return rtn;
}

+(NSDate*) parseRfc822Date:(NSString*) string
{ 
    
    NSDate * date= [[DateUtil Rfc822DateFomatter] dateFromString:string];
    return date;
}
+(NSDate*) parseIso8601Date:(NSString*) string
{
    NSDate * date= [[DateUtil Iso8601DateFormat] dateFromString:string];
    return date;
}
+(NSDateFormatter*) Rfc822DateFomatter
{
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [inputFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
  //  NSString *tzStr = @"GMT-00:00";
 //   NSTimeZone *tz = [[NSTimeZone alloc] initWithName:tzStr];
    NSTimeZone *tz = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [inputFormatter setTimeZone:tz];
 //   [tz release];
    return inputFormatter ;
}
+(NSDateFormatter*)Iso8601DateFormat
{
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString *tzStr = @"GMT-00:00";
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName:tzStr];
    [inputFormatter setTimeZone:tz];
    [tz release];
    return inputFormatter ;
}

+(NSDateFormatter*)AlternativeIso8601DateFormat
{
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *tzStr = @"GMT-00:00";
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName:tzStr];
    [inputFormatter setTimeZone:tz];
    [tz release];
    return inputFormatter ;
}


@end
