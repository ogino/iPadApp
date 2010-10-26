//
//  URLLoaderTest.m
//  iPadApp
//
//  Created by 荻野 雅 on 10/10/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLLoaderTest.h"


@implementation URLLoaderTest

- (void)setUp {
	network = [[URLLoader alloc] init];
}

- (void)testRequest {
	NSURL* url = [NSURL URLWithString:@"http://www.yahoo.com"];
	NSData* data = [network request:url];
	assertThat(data, notNilValue());
	assertThat([NSNumber numberWithInt:[data length]], greaterThan([NSNumber numberWithInt:0u]));
	NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	assertThat(response, notNilValue());
	assertThat([NSNumber numberWithInt:[response length]], greaterThan([NSNumber numberWithInt:0u]));
}

- (void)testRequestWithGET {
	NSURL* url = [NSURL URLWithString:@"http://www.pwv.co.jp/~take/TakeWiki/index.php"];
	NSString* get = @"iPhone/テスト駆動型開発の準備";
	NSData* data = [network request:url get:get];
	assertThat(data, notNilValue());
	assertThat([NSNumber numberWithInt:[data length]], greaterThan([NSNumber numberWithInt:0u]));
	NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	assertThat(response, notNilValue());
	assertThat([NSNumber numberWithInt:[response length]], greaterThan([NSNumber numberWithInt:0u]));
}

- (void)testRequestWithPOST {
	NSURL* url = [NSURL URLWithString:@"http://babelfish.yahoo.com/translate_txt"];
	NSString* post = @"ei=UTF-8&doit=done&fr=bf-res&intl=1&tt=urltext&trtext=Grazie+mille%21&lp=it_fr&btnTrTxt=Translate";
	NSData* data = [network request:url post:post];
	assertThat(data, notNilValue());
	assertThat([NSNumber numberWithInt:[data length]], greaterThan([NSNumber numberWithInt:0u]));
	NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	assertThat(response, notNilValue());
	assertThat([NSNumber numberWithInt:[response length]], greaterThan([NSNumber numberWithInt:0u]));
}

- (void)tearDown {
	[network release];
}

@end