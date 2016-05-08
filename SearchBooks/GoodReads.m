//
//  GoodReads.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

@import AFNetworking;

#import "GoodReads.h"
#import "BookParser.h"

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

    NSString *service = @"https://www.goodreads.com/search/index.xml";
    
    NSDictionary *parameters = @{@"key": kGoodReadsKey,
                                 @"q": query};
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    
    [manager GET:service parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BookParser *parserOperation = [[BookParser alloc] initWithXMLParser:responseObject];

        [parserOperation parseBooksWithSucces:^(NSArray *items) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) success(items);
            });
        } failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", [error description]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) failure(error);
        });
    }];
}

@end
