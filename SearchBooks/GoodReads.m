//
//  GoodReads.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import "GoodReads.h"
#import "BookParserOperation.h"

static NSString * const kGoodReadsKey = @"zq1d50yk5GWoBCWhfe4LmQ";
static NSString * const kGoodReadsSecret = @"8gNv67X4myEC5hnzk5fZ5JJ1842rNz7jzalAOG4gg";

@implementation GoodReads

+(instancetype)sharedInstance {
    static GoodReads *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

-(void)searchBooksWithQuery:(NSString *)query soccess:(GoodReadsServicesSuccessBlock)success failure:(GoodReadsServicesFailureBlock)failure {

    //encode query to url string
    NSString *queryEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                   NULL,
                                                                                                   (CFStringRef)query,
                                                                                                   NULL,
                                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8 ));
    
    NSString *service = [NSString stringWithFormat:@"https://www.goodreads.com/search/index.xml?key=%@&q=%@", kGoodReadsKey, queryEncoded];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:service]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            //if get some connection error
            if (failure) failure (connectionError);
        } else {
            
            BookParserOperation *parserOperation = [[BookParserOperation alloc] initWithXMLParser:[[NSXMLParser alloc] initWithData:data]];
            
            [parserOperation parseBooksWithSucces:^(NSArray *items) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) success(items);
                });
                
            } failure:failure];
        }
        
    }];
}

@end
