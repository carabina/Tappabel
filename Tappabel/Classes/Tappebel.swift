//
//  Tappebel.swift
//  Pods
//
//  Created by Ahmed Abdul Badie on 1/16/17.
//
//

/// A subclass of UILabel that adds tap functionality.
open class Tappebel: UILabel {
    
    /// The action to be performed when the label is tapped.
    public var tapAction: ((_ label: Tappebel) -> ())?
    /// Indicates whether the tap action should be enabled.
    public var actionEnabled: Bool                  = true
    /// The tap gesture recognizer.
    private var tapGesture                          = UITapGestureRecognizer()
    /// The number of taps required to perform the tap action.
    /// Default is one tap.
    public var numberOfTaps: Int                    = 1 {
        didSet {
            self.tapGesture.numberOfTapsRequired    = numberOfTaps
        }
    }
    /// The number of fingers required to perform the tap action.
    /// Default is one finger.
    public var numberOfTouches: Int                 = 1 {
        didSet {
            self.tapGesture.numberOfTouchesRequired = numberOfTouches
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.isUserInteractionEnabled           = true
        self.tapGesture                         = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.tapGesture.numberOfTapsRequired    = self.numberOfTaps
        self.tapGesture.numberOfTouchesRequired = self.numberOfTouches
        self.addGestureRecognizer(tapGesture)
    }
    
    /// Performs an action when the label is tapped.
    open func tap() {
        if !self.actionEnabled {
            return
        }
        
        if let tapAction = self.tapAction {
            tapAction(self)
        }
    }
    
    
    /// Disables the tap action of the label for a certain
    /// amount of time.
    ///
    /// - Parameter seconds: Amount of time to disable the tap action for.
    public func pauseAction(_ seconds: Double) {
        self.actionEnabled      = false
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.actionEnabled = true
        }
    }
    
}
