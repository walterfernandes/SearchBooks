//
//  MasterViewController.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import "MasterViewController.h"
#import "BookDetailViewController.h"
#import "GoodReads.h"
#import "Book.h"

@interface MasterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property NSArray *books;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135,140,50,50)];
    spinner.color = [UIColor blueColor];
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    [[GoodReads sharedInstance] searchBooksWithQuery:textField.text soccess:^(NSArray * _Nullable response) {
        
        NSLog(@"response: %@", response);
        
        self.books = [NSArray arrayWithArray:response];
        
        [self.tableView reloadData];
        
        [spinner removeFromSuperview];
        
    } failure:^(NSError * _Nonnull error) {
        [spinner removeFromSuperview];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SearchBooks"
                                                        message:@"Problems on search, I'm sorry."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];

    return YES;
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Book *book = self.books[indexPath.row];
        BookDetailViewController *controller = (BookDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:book];
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.books)
        return self.books.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.books[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

@end
