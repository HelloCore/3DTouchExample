//
//  ViewController.m
//  TouchExample
//
//  Created by AKKHARAWAT CHAYAPIWAT on 12/18/2558 BE.
//  Copyright © 2558 AKKHARAWAT CHAYAPIWAT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear: animated];
	[myTableView reloadData];
}

-(IBAction) editButtonClick:(id)sender
{
	if(myTableView.isEditing){
		[myTableView setEditing:NO animated:YES];
	}else{
		[myTableView setEditing:YES animated:YES];
	}
}
-(IBAction) addButtonClick:(id)sender
{
	UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"Menu" message:@"" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSMutableArray *shortcut = [NSMutableArray arrayWithArray:[[UIApplication sharedApplication] shortcutItems]];
		
		UIMutableApplicationShortcutItem *item = [[UIMutableApplicationShortcutItem alloc] initWithType:alert.textFields[0].text localizedTitle:alert.textFields[0].text];
		[shortcut addObject: item];
		[[UIApplication sharedApplication] setShortcutItems:shortcut];
		[myTableView reloadData];
	}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	
	[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		[textField setPlaceholder: @"Menu Name"];
	}];
	
	[alert addAction: action];
	[alert addAction:cancel];
	
	[self presentViewController:alert animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[UIApplication sharedApplication] shortcutItems] count];
}

static NSString *cellIdentifier = @"CellIdent";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(!cell){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	UIApplicationShortcutItem *item = [[UIApplication sharedApplication] shortcutItems][indexPath.row];
	cell.textLabel.text = item.type;
	return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle == UITableViewCellEditingStyleDelete){
		NSMutableArray *shortcut = [NSMutableArray arrayWithArray:[[UIApplication sharedApplication] shortcutItems]];
		[shortcut removeObjectAtIndex: indexPath.row];
		[[UIApplication sharedApplication] setShortcutItems:shortcut];
		[myTableView reloadData];		
	}
}


@end
