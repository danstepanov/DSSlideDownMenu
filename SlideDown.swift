//
//  SlideDown.swift
//  SlideDownMenu
//
//  Created by Daniel Stepanov on 11/8/15.
//  Copyright © 2015 Daniel Stepanov. All rights reserved.
//

import Foundation
import UIKit

var animateInDuration: NSTimeInterval = 0.35
var animateOutDuration: NSTimeInterval = 0.133

public class SlideDownMenu: UIView, UIGestureRecognizerDelegate {
    
    private var didSetConstraints: Bool = false
    
    lazy var background: UIImageView! = {
        let view = UIImageView(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "background")
        
        return view
    }()
    
    lazy var titleLabel: UILabel! = {
        let view = UILabel(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Rules of Engagement"
        view.font = UIFont(name: "OpenSans-Semibold", size: 18)
        view.textAlignment = NSTextAlignment.Center
        view.textColor = UIColor.blackColor()
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = NSTextAlignment.Left
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 2.0
        let attrString = NSAttributedString(
            string: "Rolemance is flirtatious interactive fiction, designed to be enjoyed with a partner. \n\nEvery storyline takes dramatic twists and turns based on both your decisions. \n\nRolemance requires strategy to unlock intimacy levels. As both partners increase their intimacy through actions\nand word choices, you’ll discover new risque options in each storyline.\n\nxoxo ",
            attributes: [
                NSFontAttributeName: UIFont(name: "OpenSans", size: 14.0)!,
                NSForegroundColorAttributeName: UIColor.blackColor(),
                NSParagraphStyleAttributeName: style
            ])
        view.attributedText = attrString
        
        return view
    }()
    
    lazy var dismissButton: UIButton! = {
        let view = UIButton(type: .Custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "dismiss button"), forState: UIControlState.Normal)
        view.setImage(UIImage(named: "dismiss button selected"), forState: UIControlState.Highlighted)
        view.addTarget(self, action: "dismissButtonTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return view
    }()
    
    private var slideDownPositionConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var overlayView: OverlayView = OverlayView(frame: CGRectZero)
    
    public required init!(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(background)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dismissButton)
        addSubview(overlayView)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    public override func updateConstraints() {
        backgroundConstraints()
        titleConstraints()
        descriptionConstraints()
        dismissButtonConstraints()
        updateConstraints()
    }
    
    func backgroundConstraints() {
        self.addConstraint(NSLayoutConstraint(
            item:self.background,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.background,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Height,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.background,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterX,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.background,
            attribute:NSLayoutAttribute.CenterY,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterY,
            multiplier:1.0,
            constant:0))
        
    }
    
    func titleConstraints() {
        self.addConstraint(NSLayoutConstraint(
            item:self.titleLabel,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.titleLabel,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.titleLabel,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.07,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.titleLabel,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterX,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.titleLabel,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:0.07,
            constant:0))
    }
    
    func descriptionConstraints() {
        self.addConstraint(NSLayoutConstraint(
            item:self.descriptionLabel,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.815,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.descriptionLabel,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.descriptionLabel,
            attribute:NSLayoutAttribute.Width,
            multiplier:1.1,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.descriptionLabel,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterX,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.descriptionLabel,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:0.162,
            constant:0))
    }
    
    func dismissButtonConstraints() {
        self.addConstraint(NSLayoutConstraint(
            item:self.dismissButton,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.85,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.dismissButton,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.dismissButton,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.164,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.dismissButton,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterX,
            multiplier:1.0,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self.dismissButton,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:0.84,
            constant:0))
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.superview == nil {return}
        
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
        
        self.addConstraint(NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.superview,
            attribute:NSLayoutAttribute.Width,
            multiplier:0.877,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.superview,
            attribute:NSLayoutAttribute.Height,
            multiplier:0.71,
            constant:0))
        
        self.addConstraint(NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.superview,
            attribute:NSLayoutAttribute.CenterX,
            multiplier:1.0,
            constant:0))
        
        self.slideDownPositionConstraint = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.CenterY,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.superview,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:-(3.0*screenHeight)/2.0)
        
        self.superview?.addConstraint(slideDownPositionConstraint)
        
        layoutIfNeeded()
        
        UIView.animateWithDuration(
            animateInDuration,
            animations: {
                self.slideDownPositionConstraint.constant = -(screenHeight/2.0) + 0.1*screenHeight
                self.overlayView.alpha = 1.0
                self.layoutIfNeeded()
            },
            definitelyCompleted: {
                UIView.animateWithDuration(
                    animateOutDuration,
                    animations: {
                        self.slideDownPositionConstraint.constant = -(screenHeight/2.0)
                        self.layoutIfNeeded()
                    })
            })
    }

    func setupOverlay() {
        self.overlayView = OverlayView()
        self.overlayView.frame = self.superview!.bounds
        self.overlayView.alpha = 0.0
        self.superview?.insertSubview(self.overlayView, belowSubview: self)
        
        var dismissViewTap: UITapGestureRecognizer = UITapGestureRecognizer()
        dismissViewTap.numberOfTapsRequired = 1
        dismissViewTap = UITapGestureRecognizer.init(target: self, action: "dismissButtonTouched:")
        self.overlayView.addGestureRecognizer(dismissViewTap)
    }
    
    @IBAction func dismissButtonTouched(sender: AnyObject) {
        
    }
}

extension UIView {
    public class func animateWithDuration(
                        duration:NSTimeInterval,
                        animations:(() -> Void),
                        definitelyCompleted:() -> Void) {
        let onComplete = { (finished: Bool) in
            if finished {
                definitelyCompleted()
            } else {
                let when = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
                let queue = dispatch_get_main_queue()
                dispatch_after(when, queue, {
                    definitelyCompleted()
                })
            }
        }
    
    UIView.animateWithDuration(
                duration,
                animations: animations,
                completion: onComplete)
    
    }
}