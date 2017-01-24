# NSLayoutConstraint-SSLayout
A simple way to use NSLayoutConstraint.
1. simple and easy-to-use, 2files only, 17kb size.
2. similar usage as NSLayoutAnchor, but support iOS-8 and "swiftable".
2. 1.7 times faster than Masonry, nearly as fast as the system method.
3. track all constraints and easy to activate/deactivate them.

*Example:*
### Setup constraint
***
```
[self.redView activateConstraints:^{
        self.redView.height_attr.constant = 100;
        self.redView.width_attr = self.blueView.width_attr;
        self.redView.top_attr = self.blueView.top_attr;
        self.redView.leading_attr = self.blueView.trailing_attr;
    }];
```
### Alter value of a constraint
***
```
self.blueView.width_attr.constant = 100;
```
### Obtain a constraint
***
```
NSLayoutConstraint *cons = [self.titleLabel constraintAccordingToAttribute:self.titleLabel.bottom_attr andAttribute:self.subtitleLabel.top_attr];
```
## Adding to your project
### Using CocoaPods
Add pod 'SSBannerViewController' to your Podfile.

### Including Source Directly Into Your Project
Add the files under "Source" folder to your project.

# Licence
This project uses MIT License.
