//
//  ViewController.swift
//  ExScrolling
//
//  Created by 김종권 on 2023/01/30.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    private let myView = MyView()
    private let scrollButton: UIButton = {
        let button = UIButton()
        button.setTitle("scroll", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var scrollView: UIScrollView {
        myView.scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myView)
        view.addSubview(scrollButton)
        
        myView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        scrollButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        myView.items = (1...30)
            .map(String.init)
    }
    
    @objc private func tap() {
        let button = myView.buttons[7]
        
        // CGRect구하기
        
        /* point 계산: 평행이동
         1) 버튼을 frame 오른쪽으로 보내기:
         button.frame.origin.x
         ----------------------------
         |                          |button
         ----------------------------
         
         2) 버튼을 scrollView 크기의 반절에 button 크기 반절을 더하면 가운데로 갈 것이므로 계산:
         현재 버튼이 오른쪽에 있으므로 이 값을 1번값에서 빼서 구현
         (scrollView.frame.width - button.frame.size.width) / 2
         
         즉, 1) - 2) 하게되면 아래처럼 평행이동 완료
         button.frame.origin.x - (scrollView.frame.width - button.frame.size.width) / 2
         ----------------------------
         |          button          |
         ----------------------------
         */
        
        // size는 현재 보여지는 프레임 전체 크기가 보여야하므로 scrollView.frame.size 사용
        
        let point = CGPoint(
            x: button.frame.origin.x - (scrollView.frame.width - button.frame.size.width) / 2,
            y: button.frame.origin.y - (scrollView.frame.height - button.frame.size.height) / 2
        )
        let size = scrollView.frame.size
        let rect = CGRect(origin: point, size: size)
        print(button.frame.origin.x, button.frame.origin.x - (scrollView.frame.width - button.frame.size.width) / 2)
        
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}

extension UIScrollView {
    func scroll(rect: CGRect, animated: Bool) {
        let origin = CGPoint(
            x: rect.origin.x - (frame.width - rect.size.width) / 2,
            y: rect.origin.y - (frame.height - rect.size.height) / 2
        )
        let rect = CGRect(origin: origin, size: frame.size)
        
        scrollRectToVisible(rect, animated: animated)
    }
}
