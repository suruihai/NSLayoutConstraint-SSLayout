//
//  NSLayoutConstraint_SSLayoutDemoTests.swift
//  NSLayoutConstraint+SSLayoutDemoTests
//
//  Created by suruihai on 2017/1/23.
//  Copyright © 2017年 ruihai. All rights reserved.
//

import XCTest

class NSLayoutConstraint_SSLayoutDemoTests: XCTestCase {
    
    let view1 = UIView()
    let view2 = UIView()
    let window = (UIApplication.shared.delegate?.window!)!
    
    override func setUp() {
        super.setUp()
        window.addSubview(view1)
        window.addSubview(view2)
    }
    
    override func tearDown() {
        if let window = view1.superview {
            window.removeConstraints(window.constraints)
        }
        view1.removeConstraints(view1.constraints)
        view2.removeConstraints(view2.constraints)
        objc_removeAssociatedObjects(view1)
        
        super.tearDown()
    }
    
    func testSetConstant() {
        
        view1.height_attr.constant = 50
        XCTAssertNil(view1.constraint(accordingTo: view1.height_attr))
        XCTAssertNil(view1.constraint(accordingTo: view1.top_attr))
        
        self.view1.activateConstraints {
            self.view1.height_attr.constant = 50
            self.view1.width_attr.constant = 50
            self.view1.top_attr = self.window.top_attr
            self.view1.left_attr = self.window.left_attr
        }
        
        XCTAssertNotNil(view1.constraint(accordingTo: view1.height_attr))
        XCTAssertNotNil(view1.constraint(accordingTo: view1.width_attr))
        XCTAssertNotNil(view1.constraint(accordingTo: view1.top_attr, andAttribute: window.top_attr))
        XCTAssertNotNil(view1.constraint(accordingTo: view1.left_attr, andAttribute: window.left_attr))
        
        XCTAssertTrue(view1.constraint(accordingTo: view1.height_attr).constant == 50)
        view1.height_attr.constant = 80
        XCTAssertTrue(view1.constraint(accordingTo: view1.height_attr).constant == 80)
    }
    
    func testLesserThan() {
        var constraint = view1.height_attr.lesserThan(nil, constant: 50, priority: UILayoutPriorityDefaultHigh)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 50)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.height)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultHigh)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.lessThanOrEqual)
        
        constraint = view1.top_attr.lesserThan(view2.top_attr, constant: 0, priority: UILayoutPriorityDefaultLow)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 0)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue((constraint?.secondItem)! as! NSObject == view2)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.secondAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultLow)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.lessThanOrEqual)
    }
    
    func testGreaterThan() {
        var constraint = view1.height_attr.greaterThan(nil, constant: 50, priority: UILayoutPriorityDefaultHigh)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 50)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.height)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultHigh)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.greaterThanOrEqual)
        
        constraint = view1.top_attr.greaterThan(view2.top_attr, constant: 0, priority: UILayoutPriorityDefaultLow)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 0)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue((constraint?.secondItem)! as! NSObject == view2)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.secondAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultLow)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.greaterThanOrEqual)
    }
    
    func testEqualTo() {
        var constraint = view1.height_attr.equal(to: nil, constant: 50, priority: UILayoutPriorityDefaultHigh)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 50)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.height)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultHigh)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.equal)
        
        constraint = view1.top_attr.equal(to: view2.top_attr, constant: 0, priority: UILayoutPriorityDefaultLow)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 0)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue((constraint?.secondItem)! as! NSObject == view2)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.secondAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.priority == UILayoutPriorityDefaultLow)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.equal)
    }
    
    func testMeasureAbbreviateMethods() {
        measure {
            for _ in 0..<10000 {
                self.view1.activateConstraints {
                    self.view1.height_attr.constant = 50
                    self.view1.width_attr.constant = 50
                    self.view1.top_attr = self.window.top_attr
                    self.view1.left_attr = self.window.left_attr
                }
            }
        }
    }
    
    func testMeasureExtensionMethods() {
        measure {
            for _ in 0..<10000 {
                self.view1.activateConstraints {
                    self.view1.height_attr.equal(to: nil, constant: 50)
                    self.view1.width_attr.equal(to: nil, constant: 50)
                    self.view1.top_attr.equal(to: self.window.top_attr)
                    self.view1.left_attr.equal(to: self.window.left_attr)
                }
            }
        }
    }
    
    func testNormalLayoutMethods() {
        view1.translatesAutoresizingMaskIntoConstraints = false
        measure {
            for _ in 0..<10000 {
                let arrayM = NSMutableArray(capacity: 4)
                arrayM.add(NSLayoutConstraint(item: self.view1, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 50))
                arrayM.add(NSLayoutConstraint(item: self.view1, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 50))
                arrayM.add(NSLayoutConstraint(item: self.view1, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.window, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0))
                arrayM.add(NSLayoutConstraint(item: self.view1, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.window, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0))
                NSLayoutConstraint.activate(arrayM.copy() as! [NSLayoutConstraint])
            }
        }
    }
    
    func testAnchorLayoutMethods() {
        if #available(iOS 9.0, *) {
            view1.translatesAutoresizingMaskIntoConstraints = false
            measure {
                for _ in 0..<10000 {
                    let arrayM = NSMutableArray(capacity: 4)
                    arrayM.add(self.view1.heightAnchor.constraint(equalToConstant: 50))
                    arrayM.add(self.view1.widthAnchor.constraint(equalToConstant: 50))
                    arrayM.add(self.view1.topAnchor.constraint(equalTo: self.window.topAnchor))
                    arrayM.add(self.view1.leftAnchor.constraint(equalTo: self.window.leftAnchor))
                    NSLayoutConstraint.activate(arrayM.copy() as! [NSLayoutConstraint])
                }
            }
        }
    }
    
    func testNSLayoutConstraintExtensionMethod() {
        let constraint = NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view2, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 5, ss_priority: UILayoutPriorityDefaultLow)
        XCTAssertNotNil(constraint)
        XCTAssert(constraint?.priority == UILayoutPriorityDefaultLow, "priority should be UILayoutPriorityDefaultLow!")
    }
    
    func testDeActivateAndActivateAll() {
        
        view1.activateConstraints {
            self.view1.height_attr.constant = 50
            self.view1.width_attr.constant = 50
            self.view1.top_attr = self.window.top_attr
            self.view1.left_attr = self.window.left_attr
        }
        view2.activateConstraints {
            self.view2.height_attr.constant = 100
            self.view2.width_attr = self.view1.width_attr
            self.view2.top_attr = self.window.top_attr
            self.view2.leading_attr = self.view1.trailing_attr
        }
        
        let constraints1 = view1.allConstraints()
        let constraints2 = view2.allConstraints()
        
        view1.deactivateAllConstraints()
        for constraint in constraints1! {
            XCTAssertFalse((constraint as AnyObject).isActive)
        }
        for constraint in constraints2! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
        
        view1.activateAllConstraints()
        for constraint in constraints1! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
        for constraint in constraints2! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
        
        view2.deactivateAllConstraints()
        for constraint in constraints2! {
            XCTAssertFalse((constraint as AnyObject).isActive)
        }
        for constraint in constraints1! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
        
        view2.activateAllConstraints()
        for constraint in constraints2! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
        for constraint in constraints1! {
            XCTAssertTrue((constraint as AnyObject).isActive)
        }
    }
    
    func testDeActivateAndActivateNothing() {
        view1.activateConstraints {}
        view1.deactivateAllConstraints()
        view1.activateAllConstraints()
    }
    
    func testDeactivateAndActivateConstraint() {
        view1.activateConstraints {
            self.view1.height_attr.constant = 50
            self.view1.width_attr.constant = 50
            self.view1.top_attr = self.window.top_attr
            self.view1.left_attr = self.window.left_attr
        }
        
        let constraint = view1.constraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        view1.deactivateConstraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertFalse((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        
        view1.deactivateConstraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.greaterThanOrEqual)
        XCTAssertTrue((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.lessThanOrEqual)
        XCTAssertTrue((constraint?.isActive)!)
        
        view1.deactivateConstraint(accordingTo: view1.top_attr, andAttribute: window.centerX_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: view1.top_attr, andAttribute: window.centerX_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        
        view1.deactivateConstraint(accordingTo: view1.centerX_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: view1.centerX_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        
        view1.deactivateConstraint(accordingTo: view1.top_attr, andAttribute: nil, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: view1.top_attr, andAttribute: nil, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        
        view1.deactivateConstraint(accordingTo: nil, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
        view1.activateConstraint(accordingTo: nil, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertTrue((constraint?.isActive)!)
    }
    
    func testGetConstraint() {
        view1.activateConstraints {
            self.view1.height_attr.constant = 50
            self.view1.width_attr.constant = 50
            self.view1.top_attr = self.window.top_attr
            self.view1.left_attr = self.window.left_attr
        }
        
        var constraint = view1.constraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertNotNil(constraint)
        XCTAssertEqual(constraint?.constant, 0)
        XCTAssertTrue((constraint?.firstItem)! as! NSObject == view1)
        XCTAssertTrue((constraint?.secondItem)! as! NSObject == window)
        XCTAssertTrue(constraint?.firstAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.secondAttribute == NSLayoutAttribute.top)
        XCTAssertTrue(constraint?.relation == NSLayoutRelation.equal)
        
        constraint = view1.constraint(accordingTo: view1.top_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.greaterThanOrEqual)
        XCTAssertNil(constraint)
        
        constraint = view1.constraint(accordingTo: view1.top_attr, andAttribute: window.centerX_attr, relation: NSLayoutRelation.equal)
        XCTAssertNil(constraint)
        
        constraint = view1.constraint(accordingTo: view1.centerX_attr, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertNil(constraint)
        
        constraint = view1.constraint(accordingTo: view1.top_attr, andAttribute: nil, relation: NSLayoutRelation.equal)
        XCTAssertNil(constraint)
        
        constraint = view1.constraint(accordingTo: nil, andAttribute: window.top_attr, relation: NSLayoutRelation.equal)
        XCTAssertNil(constraint)
    }
    
}
