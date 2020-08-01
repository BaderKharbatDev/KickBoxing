//
//  ViewController.m
//  kickboxing app
//
//  Created by Bader on 5/17/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, UITabBarControllerDelegate>
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UITableView *editTable;

@property (strong, nonatomic) IBOutlet UIView *timerClockView;
@property (strong, nonatomic) IBOutlet UIButton *autoButton;
@property (strong, nonatomic) IBOutlet UIView *timerSettingsView;
@property (strong, nonatomic) IBOutlet UILabel *timerCountLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timerDelay;
@property (strong, nonatomic) IBOutlet UIStepper *timerCounter;
@property (strong, nonatomic) IBOutlet UILabel *timerClockLabel;

//modal windows
@property (strong, nonatomic) IBOutlet UIView *warningWindow;

@property NSMutableArray * moveArray;
@property NSArray * editHeaderArray;
@property NSMutableArray * editActualArray;
@property MoveManager * manager;
@property BOOL isTimerOn;

//style only objects
@property (strong, nonatomic) IBOutlet UIButton *genButton;
@property (strong, nonatomic) IBOutlet UIView *backGroundUI;
@property (strong, nonatomic) IBOutlet UIView *topStyleView;
@property (strong, nonatomic) IBOutlet UIView *backGroundUI2;

//banner
@property(nonatomic, strong) GADBannerView *bannerView;

//sound
@property AVSpeechUtterance *speechutt;
@property AVSpeechSynthesizer *synthesizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* delegateInstance = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    _manager = [delegateInstance manager];
    [self setupUI];
    
    //sound synth
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVAudioSession *as = [AVAudioSession sharedInstance];
    [as setCategory:AVAudioSessionCategoryPlayback withOptions: AVAudioSessionCategoryOptionDuckOthers error:NULL];
    
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    [self addBannerViewToView:self.bannerView];
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716"; //test
    //    self.bannerView.adUnitID = @"ca-app-pub-8286027185402342/9907216040";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
      [NSLayoutConstraint constraintWithItem:bannerView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bottomLayoutGuide
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0],
      [NSLayoutConstraint constraintWithItem:bannerView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:0]
                                  ]];
}

-(void)setupUI {
    //setup UI
    self.stepper.minimumValue = 1;
    self.stepper.maximumValue = 10;
    self.stepper.value = 3;
    self.timerCounter.minimumValue = 1;
    self.timerCounter.maximumValue = 7;
    self.timerCounter.value = 3;
    
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.table.allowsSelection = false;
    [self.editTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.editTable.allowsSelection = false;
    
    self.backGroundUI.layer.shadowOffset = CGSizeMake(0, 2);
    self.backGroundUI.layer.shadowRadius = 2;
    self.backGroundUI.layer.shadowOpacity = 0.2;
    
    self.topStyleView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topStyleView.layer.shadowRadius = 5;
    self.topStyleView.layer.shadowOpacity = 0.5;
    
    self.backGroundUI2.layer.shadowOffset = CGSizeMake(0, 2);
    self.backGroundUI2.layer.shadowRadius = 2;
    self.backGroundUI2.layer.shadowOpacity = 0.2;
    
    //hides timer view to show the settings view first
    [self.timerClockView setHidden:true];
    self.isTimerOn = false;
    self.timerCountLabel.text = @"3";
    
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

//---------------TIMER METHODS-------------------------------------------------


- (IBAction)timerCounterChanged:(UIStepper *)sender {
    [self.timerCountLabel setText: [NSString stringWithFormat:@"%1.0f", sender.value]];
}

- (IBAction)timerButtonPressed:(UIButton *)sender {
    
    //check if timer is off and list is zero
    BOOL listEmpty = true;
    for(int i = 0; i < self.manager.moveList.count; i++) {
        if([(Move *)self.manager.moveList[i] isActive])
            listEmpty = false;
    }
    if(!_isTimerOn && listEmpty) { //if movelist is empty make sure timer doenst start
        [self displayWarningWindow];
        return;
    }
    
    @synchronized (self) {
        _isTimerOn = !_isTimerOn;

        //changes button text and color
        if(_isTimerOn) {
            [sender setTitle:@"STOP" forState:UIControlStateNormal];
            [sender setBackgroundColor: [UIColor redColor]];
            [self.timerClockView setHidden: false];
            [self.timerSettingsView setHidden: TRUE];
            
            int count = self.timerCounter.value;
            int delay = self.timerDelay.selectedSegmentIndex;
            dispatch_async(dispatch_get_global_queue(0, 0), ^ {
                [self startTimerShit: count : delay];
            });
        } else {
            [sender setTitle:@"START" forState:UIControlStateNormal];
            [sender setBackgroundColor: [UIColor grayColor]];
            [self.timerClockView setHidden: TRUE];
            [self.timerSettingsView setHidden: false];
            
            @try {
                self.moveArray = NULL;
                [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            } @catch (NSException *exception) {
                [self displayWarningWindow];
            }
        }
    }
}

-(void) startTimerShit: (int) strikeCount : (int) roundTime {
    int delay = 0;
    int total = 0;
    switch(roundTime) {
        case 0:
            delay = 5;
            total = 5;
            break;
        case 1:
            delay = 10;
            total = 10;
            break;
        case 2:
            delay = 15;
            total = 15;
            break;
    }

    while(self.isTimerOn) {
        //updates table
        dispatch_async(dispatch_get_main_queue(), ^{
            @synchronized (self) {
               @try {
                   self.moveArray = [self.manager generate: strikeCount];
                   [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
               } @catch (NSException *exception) {
                   [self displayWarningWindow];
               }
               [NSThread sleepForTimeInterval: 0.5];
            }
        });
        
        //plays sounds
        dispatch_async(dispatch_get_main_queue(), ^{
            @synchronized (self) {
                //play sound
                for(int i = 0; i < self->_moveArray.count; i++) {
                    NSLog(@"%@", [(Move *) self->_moveArray[i] name]);
                    //sound stuff
                    self.speechutt = [AVSpeechUtterance speechUtteranceWithString: [(Move *) self->_moveArray[i] name]];
//                    [self->_speechutt accessibilityAttributedValue
                    self->_speechutt.volume=150.0f;
                    self->_speechutt.pitchMultiplier=0.80f;
                    [self->_speechutt setRate:0.52f];
                    self->_speechutt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
                    [self->_synthesizer speakUtterance:self->_speechutt];
                }
                while([self->_synthesizer isSpeaking]) {
                    //busy wait until done
                    if(!self.isTimerOn) {
                        return;
                    }
                }
            }
        });
        
        while(delay != -1) {
            //check to ensure that the timer is off
            @synchronized (self) {
                if(!self.isTimerOn) {
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    int minutes = (int) delay / 60;
                    int seconds = (int) delay % 60;
                    self.timerClockLabel.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
                });
            }
            //sleep for a second
            for(int i = 0; i < 4; i ++) {
                @synchronized (self) {
                    [NSThread sleepForTimeInterval: 0.25];
                    if(!self.isTimerOn) {
                        return;
                    }
                }
            }
            delay -= 1;
        }
        delay = total;
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

- (IBAction)headerCheckBoxAction:(UIButton *)sender {
    int index = 0;
    for(int i = 0; i < self.editHeaderArray.count; i++) {
        if([(HeaderCell *)[(CellMenuItem *) self.editHeaderArray[i] cell] checkBoxImg] == sender) {
            index = i;
            break;
        }
    }
    HeaderCell * selCell = (HeaderCell *)[(CellMenuItem *) self.editHeaderArray[index] cell];
    [selCell checkBoxPressedAction];
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
        MainCell *cell = [[MainCell alloc] initWithCell: (Move *) self.moveArray[indexPath.row] : [tableView dequeueReusableCellWithIdentifier: @"cell"] : indexPath.row + 1];
        [cell.image setImage: [UIImage imageNamed: [(Move *) self.moveArray[indexPath.row] imgStr]]];
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
      return 75;
   }
   return 60;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    @synchronized (self) {
        self.isTimerOn = false;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"tab selected: %@", item.title);
}
@end
