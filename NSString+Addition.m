//
//  NSString+Addition.m
//  Apollo
//
//  Created by xhan on 10-9-19.
//  Copyright 2010 ixHan.com. All rights reserved.
//

#import "NSString+Addition.h"
#import "PLGlobal.h"

@implementation NSString(Addition)

- (BOOL)isEmpty{
	return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}

- (BOOL)isNonEmpty
{
    return !self.isEmpty;
}


+ (BOOL)isEqual:(NSString*)a toB:(NSString*)b
{
	if (a == nil) {
		return b == nil;
	}else {
		return [a isEqualToString:b];
	}

}

+ (NSString*)localizedFileSize:(long long)fileSizeBytes
{
	int gb = fileSizeBytes / GByte;
	int mb = fileSizeBytes % GByte / MByte;
	int kb = fileSizeBytes % MByte/ KByte;
	if (gb > 0) {
		return [NSString stringWithFormat:@"%d GB %d MB",gb,mb];
	}
	if (mb > 0) {
		return [NSString stringWithFormat:@"%d%.2f MB",mb,((float)kb)/KByte];
	}
	return [NSString stringWithFormat:@"%d KB",kb];

}

- (NSString*)firstString:(int)maxLength
{
	if (maxLength > [self length]) {
		return self;
	}else {
		return [self substringToIndex:maxLength];
	}

}


- (NSString*)firstString:(int)maxLength atIndex:(NSUInteger)index
{
	NSUInteger length = self.length;
	if (index >= length) {
		return nil;
	}
	if (index + maxLength > length) {
		maxLength = length - index;
	}
	
	return [self substringWithRange:NSMakeRange(index, maxLength)];
}

@end


@implementation NSString (URLEscaped)
- (NSString *)URLEscaped {
	CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
	NSString *out = [NSString stringWithString:(NSString *)escaped];
	CFRelease(escaped);
	return [[out copy] autorelease];
}
- (NSString *)unURLEscape {
	CFStringRef unescaped = CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, (CFStringRef)@"");
	NSString *out = [NSString stringWithString:(NSString *)unescaped];
	CFRelease(unescaped);
	return [[out copy] autorelease];
}
@end