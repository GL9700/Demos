//
//  LottiePackageView.swift
//  TLottie
//
//  Created by liguoliang on 2023/12/15.
//

import Foundation
import Lottie

typealias BlockWithNone = ()->()
typealias BlockWithParams<T> = (T)->()

@objc class LottiePackageView : UIView {
 
    @objc public var mAnimationView = LottieAnimationView()
    @objc public var loopAnimationCount : CGFloat = 0 {
        didSet {
            mAnimationView.loopMode = loopAnimationCount == -1 ? .loop : .repeat(Float(loopAnimationCount))
        }
    }
    @objc public var speed : CGFloat = 1 {
        didSet {
            mAnimationView.animationSpeed = speed
        }
    }
    private var handle_animationCompleted : BlockWithNone?
    
    public init() {
        // 设定初始属性
        super .init(frame: .zero)
    }
    
    /// 加载本地动画
    @objc public convenience init(name:String) {
        self.init(name: name, bundle: nil, handle_AnimaCompleted: nil);
    }
    @objc public convenience init(name:String, bundle:Bundle?) {
        self.init(name: name, bundle: bundle, handle_AnimaCompleted: nil);
    }
    @objc public convenience init(name:String, bundle:Bundle?, handle_AnimaCompleted:BlockWithNone?) {
        self.init()
        var nbundle:Bundle? = bundle
        if nbundle == nil {
            nbundle = Bundle.main
        }
        if let jsonPath = nbundle!.path(forResource: name, ofType: "json"),
            let animation = LottieAnimation.filepath(jsonPath) {
            mAnimationView.animation = animation
            self.addSubview(mAnimationView)
            self.handle_animationCompleted = handle_AnimaCompleted;
            play()
        }
    }
    
    /// 加载远程动画文件
    @objc public convenience init(remoteURL:String) {
        self.init(remoteURL: remoteURL, handle_AnimaCompleted: nil, handle_AnimaError:nil)
    }
    @objc public convenience init(remoteURL:String,
                                  handle_AnimaCompleted:BlockWithNone?,
                                  handle_AnimaError:BlockWithParams<Int>?) {
        self.init()
        weak var wself = self
        if let url = URL(string: remoteURL) {
            mAnimationView = LottieAnimationView(url: url, closure: { (error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        wself?.remove()
                        handle_AnimaError?(1)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.handle_animationCompleted = handle_AnimaCompleted;
                        wself?.showRemoteLottieWhenSuccess()
                    }
                }
            })
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mAnimationView.frame = self.bounds
    }
    
    @objc func play(completion:@escaping() -> ()) {
        mAnimationView.play() { (isu) in
            if Thread.isMainThread {
                completion()
            }else{
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    @objc func play() {
        if handle_animationCompleted == nil {
            mAnimationView.play()
        }else{
            mAnimationView.play { completed in
                self.handle_animationCompleted?()
            }
        }
    }
    
    @objc func pause() {
        mAnimationView.pause()
    }
    
    @objc func stop() {
        mAnimationView.stop()
    }
    
    @objc func remove() {
        mAnimationView.stop()
        mAnimationView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    @objc func showRemoteLottieWhenSuccess() {
        mAnimationView.contentMode = .scaleAspectFit
        self.addSubview(mAnimationView)
        play()
    }
    
    
}

extension Bundle {
    static var lottieBundle : Bundle {
        return Bundle.init(path: Bundle.init(for: LottiePackageView.self).path(forResource: "Lottie_Resource", ofType: "Bundle")!)!
    }
}
