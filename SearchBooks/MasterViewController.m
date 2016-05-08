//
//  MasterViewController.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

@import MBProgressHUD;
@import AFNetworking;

#import "MasterViewController.h"
#import "BookCell.h"
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

    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    [[GoodReads sharedInstance] searchBooksWithQuery:textField.text soccess:^(NSArray * _Nullable response) {
        
        self.books = [NSArray arrayWithArray:response];
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
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
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];

    Book *book = self.books[indexPath.row];
    cell.titleLabel.text = book.title;
    cell.authorLabel.text = [NSString stringWithFormat:@"by %@", book.author];
    
    cell.imageView.image = nil; //set to nil to remove image when reusing cell
    [cell.imageView setImageWithURL:book.smalImageURL];
    
    return cell;
}

@end
