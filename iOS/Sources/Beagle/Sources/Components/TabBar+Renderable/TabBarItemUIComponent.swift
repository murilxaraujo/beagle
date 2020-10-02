/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import BeagleSchema

final class TabBarItemUIComponent: UIView {
    
    // MARK: - UIComponents
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.invalidateIntrinsicContentSize()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties

    var index: Int?
    var theme: TabBarTheme? {
        didSet {
            setupSelectionAppearance()
        }
    }
    
    var isSelected: Bool? {
        didSet {
            setupSelectionAppearance()
        }
    }
    
    private var renderer: BeagleRenderer?
    
    // MARK: - Initialization
    
    init(
        index: Int,
        renderer: BeagleRenderer
    ) {
        super.init(frame: .zero)
        self.renderer = renderer
        self.index = index
        addSubview(icon)
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Setup
    
    func setupTab(with tab: TabBarItem) {
        switch tab.itemContentType {
            
        case let .both(iconName, text):
            title.text = text
            title.font = .systemFont(ofSize: 14)

            handleContextOnImage(iconName: iconName)
            
            title.style.setup(Style().display(.flex))
            icon.style.setup(Style()
                .display(.flex)
                .size(Size().width(30).height(30))
               )

        case .icon(let iconName):
            
            handleContextOnImage(iconName: iconName)
        
            title.style.setup(Style().display(.none))
            icon.style.setup(Style()
                .display(.flex)
                .size(Size().width(35).height(35))
            )

        case .title(let text):
            title.text = text
            title.font = .systemFont(ofSize: 16)

            title.style.setup(Style().display(.flex).flex(Flex().alignSelf(.center)))
            icon.style.setup(Style().display(.none))
            
        case .none:
            title.style.setup(Style().display(.none))
            icon.style.setup(Style().display(.none))
        }
        setupSelectionAppearance()
    }
    
    private func setupSelectionAppearance() {
        guard let theme = theme, let isSelected = isSelected else { return }
        switch styleVerification(theme: theme) {
        case .both:
            title.textColor = isSelected ? theme.selectedTextColor : theme.unselectedTextColor
            icon.tintColor = isSelected ? theme.selectedIconColor : theme.unselectedIconColor
        case .icon:
            icon.tintColor = isSelected ? theme.selectedIconColor : theme.unselectedIconColor
            title.textColor = isSelected ? .black : .gray
        case .text:
            title.textColor = isSelected ? theme.selectedTextColor : theme.unselectedTextColor
            icon.tintColor = isSelected ? .black : .gray
        default:
            title.textColor = isSelected ? .black : .gray
            icon.tintColor = isSelected ? .black : .gray
        }
    }
    
    private func styleVerification(theme: TabBarTheme) -> StyleEnabler {
        switch (theme.selectedIconColor, theme.unselectedIconColor, theme.selectedTextColor, theme.unselectedTextColor) {
        case let (selectedIconColor?, unselectedIconColor?, selectedTextColor?, unselectedTextColor?):
            return .both(iconSelectedColor: selectedIconColor,
                         iconUnselectedColor: unselectedIconColor,
                         textSelectedColor: selectedTextColor,
                         textUnselectedColor: unselectedTextColor)
        case let (selectedIconColor?, unselectedIconColor?, _, _):
            return .icon(selectedIconColor, unselectedIconColor)
        case let (_, _, selectedTextColor?, unselectedTextColor?):
            return .text(selectedTextColor, unselectedTextColor)
        default:
            return .none
        }
    }
    
    private func handleContextOnImage(iconName: String) {
        let expression: Expression<String> = "\(iconName)"
                   
        renderer?.observe(expression, andUpdateManyIn: self) { icon in
            if let icon = icon {
                self.icon.image = self.theme?.selectedIconColor == nil ?
                    UIImage(named: icon, in: self.renderer?.controller.dependencies.appBundle, compatibleWith: nil) :
                    UIImage(named: icon, in: self.renderer?.controller.dependencies.appBundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    private enum StyleEnabler {
        case icon(UIColor, UIColor)
        case text(UIColor, UIColor)
        case both(iconSelectedColor: UIColor, iconUnselectedColor: UIColor, textSelectedColor: UIColor, textUnselectedColor: UIColor)
        case none
    }
}
