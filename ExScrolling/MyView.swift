//
//  MyView.swift
//  ExScrolling
//
//  Created by 김종권 on 2023/01/30.
//

import UIKit
import Then
import SnapKit

final class MyView: UIView {
    let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
    }
    
    var items = [String]() {
        didSet { setUpData() }
    }
    var buttons = [UIButton]()
    private var selectedIndex: Int? {
        didSet {
            guard let selectedIndex else { return }
            
            if let oldValue {
                buttons[oldValue].isSelected = false
            }
            buttons[selectedIndex].isSelected = true
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUp() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.height.equalToSuperview()
        }
    }
    
    private func setUpData() {
        clearData()
        items
            .enumerated()
            .map { index, title in
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(.lightGray, for: .normal)
                button.setTitleColor(.blue, for: .highlighted)
                button.setTitleColor(.systemBlue, for: .selected)
                button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
                button.tag = index
                buttons.append(button)
                return button
            }
            .forEach(stackView.addArrangedSubview)
    }
    
    private func clearData() {
        buttons.forEach { $0.removeFromSuperview() }
    }
    
    @objc private func tapButton(_ sender: UIButton) {
        print(sender.tag)
        selectedIndex = sender.tag
    }
}

