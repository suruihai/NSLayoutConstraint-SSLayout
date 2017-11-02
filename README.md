# NSLayoutConstraint-SSLayout
1. simple and easy-to-use, 2files only, 17kB size.
2. similar usage as NSLayoutAnchor, but support iOS-8 and "swiftable".
3. 1.7 times faster than Masonry, nearly as fast as the system method.
4. track all constraints and easy to activate/deactivate any one of them.
5. sufficient unit tests.
6. compatible to iOS 11, extremely easy to layout refering to safeAreaLayoutGuide.
## Example
### Setup constraints
Notice: This method will bound all the constraints written in the block to its responsible caller.
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
### Setup constraints to safeAreaLayoutGuide
```
[self.redView activateConstraints:^{
self.redView.height_attr.constant = 100;
       self.redView.width_attr.constant = 100;
              self.redView.top_attr = self.view.top_attr_safe;
                     self.redView.leading_attr = self.view.leading_attr_safe;
                        }];
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
Notice: deactivateConstraintAccordingToAttribute will deactivate and remove the constraint object, if you desire to temporary deactivate a constraint, you should obtain it and call setActive:NO.

## Adding to your project
### Using CocoaPods
Add pod 'NSLayoutConstraint-SSLayout' to your Podfile.

### Including Source Directly Into Your Project
Add the files under "Source" folder to your project.

# Licence
This project uses MIT License.
