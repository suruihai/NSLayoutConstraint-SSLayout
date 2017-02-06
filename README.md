# NSLayoutConstraint-SSLayout
simple and easy-to-use, 2files only, 17kB size.  
similar usage as NSLayoutAnchor, but support iOS-8 and "swiftable".  
1.7 times faster than Masonry, nearly as fast as the system method.  
track all constraints and easy to activate/deactivate any one of them.
## Example
### Setup constraints
Notice:This method will bound all the constraints written in the block to its responsible caller.
```
[self.redView activateConstraints:^{
        self.redView.height_attr.constant = 100;
        self.redView.width_attr = self.blueView.width_attr;
        self.redView.top_attr = self.blueView.top_attr;
        self.redView.leading_attr = self.blueView.trailing_attr;
    }];
```
or like this
```
NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
[arrayM addObject:[self.redView.height_attr equalTo:nil constant:100]];
[arrayM addObject:[self.redView.width_attr equalTo:self.blueView.width_attr]];
[arrayM addObject:[self.redView.top_attr equalTo:self.blueView.top_attr]];
[arrayM addObject:[self.redView.leading_attr equalTo:self.blueView.trailing_attr]];
[NSLayoutConstraint activateConstraints:arrayM];
```
### Alter value of a constraint
```
self.blueView.width_attr.constant = 100;
```
or
```
[self.redView constraintAccordingToAttribute:self.redView.height_attr].constant = 100;
```
### Obtain a constraint
To use methods in UIView(SSLayout), you should have called the "activateConstraints" method in the first place so the constraints written in the block are bound to the caller, then the caller may call "constraintAccordingToAttribute" to obtain its constraints, as shown below,
```
NSLayoutConstraint *cons = [self.titleLabel constraintAccordingToAttribute:self.titleLabel.bottom_attr andAttribute:self.subtitleLabel.top_attr];
```
### Activate/Deactivate constraint
```
[self.redView activateConstraintAccordingToAttribute:self.redView.height_attr];
[self.redView deactivateConstraintAccordingToAttribute:self.redView.height_attr];
```

## Adding to your project
### Using CocoaPods
Add pod 'NSLayoutConstraint-SSLayout' to your Podfile.

### Including Source Directly Into Your Project
Add the files under "Source" folder to your project.

# Licence
This project uses MIT License.
