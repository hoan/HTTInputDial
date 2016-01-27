# HTTInputDial

[![Version](https://img.shields.io/cocoapods/v/HTTInputDial.svg?style=flat)](http://cocoapods.org/pods/HTTInputDial)
[![License](https://img.shields.io/cocoapods/l/HTTInputDial.svg?style=flat)](http://cocoapods.org/pods/HTTInputDial)
[![Platform](https://img.shields.io/cocoapods/p/HTTInputDial.svg?style=flat)](http://cocoapods.org/pods/HTTInputDial)

## What is it?

`HTTInputDial` is circular input dial for iPhone apps. It is good for having an easy to use iPod click wheel style interface. It is used in the [Unplugged](http://unpluggedtime.com) app.

## Example

![alt tag](https://raw.github.com/hoan/HTTInputDial/master/example.gif)

## Usage

First install `HTTInputDial` with [CocoaPods](http://cocoapods.org):

```ruby
pod "HTTInputDial"
```

Then at the top of your View Controller add the import:

```objective-c
#import <HTTInputDial/HTTInputDial.h>
```

Create a HTTDialView:

```objective-c
HTTInputDial *dialView = [[HTTInputDial alloc] initWithFrame:CGRectMake(50, 50, 220, 220)
                                                  usingImage:[UIImage imageNamed:@"circle-and-arrow"]
                                                    minValue:0
                                                    maxValue:24*60
                                           fullRotationValue:60];
[dialView setDelegate:self];
[dialView setValue:25];
[self.view addSubview:dialView];
```

The `minValue` and `maxValue` is what the input dial will stop at. `fullRotationValue` specifies how many units in a 360 degree spin. The example above is what you would use for a clock like interface where a full spin would be 60 minutes. You can customize the image to be rotated and there is a `circle-and-arrow.png` file in the repo as an example.

Set your View Controller to have `HTTInputDialDelegate` as a protocol and then you can respond to changes in the values. For example, this will change a label to show the value in hours and minutes:

```objective-c
- (void)inputDial:(HTTInputDial *)inputDial didUpdateValue:(int)value {
    NSLog(@"value = %d", value);
    
    // Set label
    int hours = value / 60;
    int minutes = value % 60;
    
    NSString *hourText   = hours == 1   ? @"hour"   : @"hours";
    NSString *minuteText = minutes == 1 ? @"minute" : @"minutes";
    
    if(hours > 0) {
        [self.valueLabel setText:[NSString stringWithFormat:@"%d %@ %d %@",hours, hourText, minutes, minuteText]];
    } else {
        [self.valueLabel setText:[NSString stringWithFormat:@"%d %@", minutes, minuteText]];
    }
}
```

You will have to create your own label for the above example to work. Finally you can use `[inputDial getValue]` to get the current value.

## Issues

Please add any issues to the Github issue tracker, and thanks for using this library!

## Author

Hoan Ton-That, hoan.tonthat@gmail.com

## License

HTTInputDial is available under the MIT license. See the LICENSE file for more info.

## Thanks

Thanks to Dursun Koc for the original `DKTuner` this was based on: https://github.com/dursunkoc/DKTuner

Thanks to Joshua Keay for the visual design.
