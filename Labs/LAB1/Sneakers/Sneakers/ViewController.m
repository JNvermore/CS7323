//
//  ViewController.m
//  Sneakers
//
//  Created by apple on 9/8/19.
//  Copyright © 2019 SMU. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"
#import "Products.h"
#import "ScrollViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
//---------------- UI Elements----------------
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

@property (strong, nonatomic) IBOutlet UISlider *sizeSlider;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *colorPicker;

@property (weak, nonatomic) IBOutlet UIStepper *amountStepper;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *checkOutButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *moneySegment;

//---------------- Propertys --------------------
@property (strong,nonatomic) ImageModel* myImageModel;
@property (strong,nonatomic) Products* myProducts;

@end

@implementation ViewController

-(ImageModel*)myImageModel{

    if(!_myImageModel){
        _myImageModel =[ImageModel sharedInstance];
    }
    return _myImageModel;
}

-(Products*)myProducts{
    if(!_myProducts){
        _myProducts = [Products sharedInstance];
    }
    return _myProducts;
}

-(NSString*)productName{
    if(!_productName){
        _productName = @"YEEZY 350V2";
    }
    return _productName;
}

-(UIImageView*)productImageView{
    if(!_productImageView){
        _productImageView = [[UIImageView alloc] initWithImage:[[ImageModel sharedInstance] getImageWithName:self.imageName]];
    }
    return _productImageView;
}

// ------------------------ size slider change the size label ------------------
- (IBAction)sizeSliderValueChanged:(UISlider*)sender {
    self.sizeLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

// ------------------------ Stepper ---------------------------
- (IBAction)stepperClick:(id)sender {
    self.amountLabel.text = [NSString stringWithFormat:@"%d", (int)_amountStepper.value];
    if(self.moneySegment.selectedSegmentIndex == 0){
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName] * (int)_amountStepper.value];
    }else if(self.moneySegment.selectedSegmentIndex == 1){
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName] * (int)_amountStepper.value * 7];
    }
    
}

// ---------------- Check Out Button ------------------
- (IBAction)clickToCheckOut:(id)sender {
    if([self.amountLabel.text isEqual:@"amount"] || [self.sizeLabel.text isEqual:@"size"]){
        UIAlertController*amountAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Check Your Purchase Amount or Selected Size." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action){
        }];
        
        [amountAlert addAction:okAction];
        [self presentViewController:amountAlert animated:YES completion:nil];
    }else{
        UIAlertController*checkAlert = [UIAlertController alertControllerWithTitle:@"Remind" message:@"Ready to check." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action){
        }];
        
        [checkAlert addAction:okAction];
        [self presentViewController:checkAlert animated:YES completion:nil];
    }
    
}

// be called by timer and change font size
-(void)changeButtonFontSize{
    NSInteger size = 15 + (arc4random() % 5);
    self.checkOutButton.titleLabel.font = [UIFont systemFontOfSize:size];
}

// --------------------- Segment Control -------------------
- (IBAction)changeMoneyType:(id)sender {
    switch (self.moneySegment.selectedSegmentIndex) {
        case 0:
            self.priceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName]];
            break;
        case 1:
            self.priceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName]*7];
            break;
        default:
            self.priceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName]];
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productImageView.image = [self.myImageModel getImageWithName:[[self.myProducts getColorsWithName:self.productName] objectAtIndex:0]];
    // This label.text is used to pass a value of price
    if([self.colorLabel.text isEqualToString:@"Color"]){
        self.colorLabel.text = [[self.myProducts getColorsWithName:self.productName] objectAtIndex:0];
    }
    self.colorLabel.hidden = true;
    self.priceLabel.text = [NSString stringWithFormat:@"%d", (int)[self.myProducts getPriceWithName:self.productName]];
    
    // ----------------- Picker -----------------------
    self.colorPicker.dataSource = self;
    self.colorPicker.delegate = self;
    
    // ---------------- Timer -------------------------
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonFontSize) userInfo:nil repeats:YES];
}

// --------------- Picker Functions ----------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.myProducts getColorsWithName:self.productName].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    // find image with row
    return [[self.myProducts getColorsWithName:self.productName] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray* colors = [self.myProducts getColorsWithName:self.productName];
    self.productImageView.image = [self.myImageModel getImageWithName:[colors objectAtIndex:row]];
    self.colorLabel.text = [colors objectAtIndex:row];
}

// segue to next view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BOOL isVC = [[segue destinationViewController] isKindOfClass:[ScrollViewController class]];
    if(isVC){
        // ------------ Image Button to Scroll View --------------
        ScrollViewController*svc = [segue destinationViewController];
        svc.scrollableImageName = self.colorLabel.text;
    }
}

@end

