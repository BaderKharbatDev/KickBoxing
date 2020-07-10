//
//  ViewController.m
//  kickboxing app
//
//  Created by Bader on 5/17/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UITableView *editTable;

//modal windows
@property (strong, nonatomic) IBOutlet UIView *warningWindow;

@property NSMutableArray * moveArray;
@property NSArray * editHeaderArray;
@property NSMutableArray * editActualArray;
@property MoveManager * manager;

//style only objects
@property (strong, nonatomic) IBOutlet UIView *backGroundUI;
@property (strong, nonatomic) IBOutlet UIView *topStyleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* delegateInstance = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    _manager = [delegateInstance manager];
    [self setupUI];
}

-(void)setupUI {
    //setup UI
    self.stepper.minimumValue = 1;
    self.stepper.maximumValue = 10;
    self.stepper.value = 3;
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.table.allowsSelection = false;
    [self.editTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.editTable.allowsSelection = false;
    self.backGroundUI.layer.shadowOffset = CGSizeMake(0, 5);
    self.backGroundUI.layer.shadowRadius = 5;
    self.backGroundUI.layer.shadowOpacity = 0.15;
    self.topStyleView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topStyleView.layer.shadowRadius = 5;
    self.topStyleView.layer.shadowOpacity = 0.5;
    [self setupEditTable];
}

- (IBAction)onStepperChange:(UIStepper *)sender {
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
}

- (IBAction)generateListOfMoves:(UIButton *)sender {
    @try {
        self.moveArray = [self.manager generate:self.stepper.value];
//        [self.table reloadData];
        [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

    } @catch (NSException *exception) {
        [self displayWarningWindow];
    }
}

//---------------MODAL POP UP METHODS------------------------------------------

-(void) displayWarningWindow {
    //add window
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.alpha = 0.5f;
    blurEffectView.frame = self.view.frame;
    [self.view addSubview:blurEffectView];
    [self.view addSubview: self.warningWindow];
    self.warningWindow.center = self.view.center;
}
- (IBAction)warningWindowDismissed:(UIButton *)sender {
    [self.warningWindow removeFromSuperview];
    [self.view.subviews[self.view.subviews.count - 1] removeFromSuperview];
}

- (IBAction)didDropDownPressed:(UIButton *)sender forEvent:(UIEvent *)event{
    int index = 0;
    for(int i = 0; i < self.editActualArray.count; i++) {
        if([(CellMenuItem *) self.editActualArray[i] isHeader] && [(HeaderCell *)[(CellMenuItem *) self.editActualArray[i] cell] arrowButton] == sender) {
            index = i;
            break;
        }
    }
    HeaderCell * selCell = (HeaderCell *)[(CellMenuItem *) self.editActualArray[index] cell];
    if([selCell isOpen]) {
        [self.editActualArray removeObjectsInRange: NSMakeRange(index+1, selCell.moveCellArray.count)];
    } else {
        for(int i = 0; i < [selCell moveCellArray].count; i++){
            [self.editActualArray insertObject: [selCell moveCellArray][i] atIndex: index+1+i];
        }
    }
    selCell.isOpen = !selCell.isOpen;
    if(selCell.isOpen)
        [sender setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
    else
        [sender setImage:[UIImage imageNamed:@"arrowright"] forState:UIControlStateNormal];
    [self.editTable reloadData];
}

//Called whenever a move is enabled or disabled
//ensures each header cell updates its texty
- (IBAction)updateActiveStatusText:(UIButton *)sender {
    for( CellMenuItem * item in self.editHeaderArray) {
        [(HeaderCell *)[item cell] updateActiveNumber];
    }
}



-(void) setupEditTable {
    CellMenuItem * kickHeader;
    CellMenuItem * punchHeader;
    CellMenuItem * headHeader;
    CellMenuItem * footHeader;
    
    NSMutableArray * kickMoveArray = [[NSMutableArray alloc] init];
    NSMutableArray * kickHelperArray = [self.manager getMatchingMovesHelper: Kick];
    for(int i = 0; i < kickHelperArray.count; i++) {
        CellMenuItem * m = [[CellMenuItem alloc] init: false : [[MoveCell alloc] initWithCell:kickHelperArray[i] : [self.editTable dequeueReusableCellWithIdentifier:@"editsub"]]];
        [kickMoveArray addObject: m];
    }
    kickHeader = [[CellMenuItem alloc] init:true :[[HeaderCell alloc] initWithCell:@"Kicks" :[self.editTable dequeueReusableCellWithIdentifier:@"edit"] : kickMoveArray]];
    
    NSMutableArray * punchMoveArray = [[NSMutableArray alloc] init];
    NSMutableArray * punchHelperArray = [self.manager getMatchingMovesHelper: Punch];
    for(int i = 0; i < punchHelperArray.count; i++) {
        CellMenuItem * m = [[CellMenuItem alloc] init: false : [[MoveCell alloc] initWithCell:punchHelperArray[i] : [self.editTable dequeueReusableCellWithIdentifier:@"editsub"]]];
        [punchMoveArray addObject: m];
    }
    punchHeader = [[CellMenuItem alloc] init:true :[[HeaderCell alloc] initWithCell:@"Punches" :[self.editTable dequeueReusableCellWithIdentifier:@"edit"] : punchMoveArray]];
    
    NSMutableArray * headMoveArray = [[NSMutableArray alloc] init];
    NSMutableArray * headHelperArray = [self.manager getMatchingMovesHelper: HeadMovement];
    for(int i = 0; i < headHelperArray.count; i++) {
        CellMenuItem * m = [[CellMenuItem alloc] init: false : [[MoveCell alloc] initWithCell:headHelperArray[i] : [self.editTable dequeueReusableCellWithIdentifier:@"editsub"]]];
        [headMoveArray addObject: m];
    }
    headHeader = [[CellMenuItem alloc] init:true :[[HeaderCell alloc] initWithCell:@"Head Movement" :[self.editTable dequeueReusableCellWithIdentifier:@"edit"] : headMoveArray]];
    
    NSMutableArray * footMoveArray = [[NSMutableArray alloc] init];
    NSMutableArray * footHelperArray = [self.manager getMatchingMovesHelper: FootMovement];
    for(int i = 0; i < footHelperArray.count; i++) {
        CellMenuItem * m = [[CellMenuItem alloc] init: false : [[MoveCell alloc] initWithCell:footHelperArray[i] : [self.editTable dequeueReusableCellWithIdentifier:@"editsub"]]];
        [footMoveArray addObject: m];
    }
    footHeader = [[CellMenuItem alloc] init:true :[[HeaderCell alloc] initWithCell:@"Foot Movement" :[self.editTable dequeueReusableCellWithIdentifier:@"edit"] : footMoveArray]];
    
    self.editHeaderArray = @[kickHeader, punchHeader, headHeader, footHeader];
    
    //init menu containing the edit window cellmenuitems
    self.editActualArray = [[NSMutableArray alloc] init];
    for(CellMenuItem * item in self.editHeaderArray) {
        [self.editActualArray addObject: (CellMenuItem *) item];
    }
}

//--------------------TABLE VIEW METHODS------------------------------

#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.table) {
        if(_moveArray == NULL){
            return 0;
        }
        return _moveArray.count;
    } else {
        return _editActualArray.count;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(tableView == self.table) {
        MainCell *cell = [[MainCell alloc] initWithCell: (Move *) self.moveArray[indexPath.row] : [tableView dequeueReusableCellWithIdentifier: @"cell"]];
        cell.title.text = [NSString stringWithFormat:@"%ld. %@", (long)indexPath.row + 1, cell.title.text];
        return cell;
    } else {
        if([(CellMenuItem *) [self.editActualArray objectAtIndex:indexPath.row] isHeader]) {
            HeaderCell * cell = (HeaderCell *) [(CellMenuItem *)[self.editActualArray objectAtIndex:indexPath.row] cell];
            return cell;
        } else {
            MoveCell * cell = (MoveCell *) [(CellMenuItem *)[self.editActualArray objectAtIndex:indexPath.row] cell];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (tableView == self.table) {
      return 60;
   }
   return 44;
}

@end
