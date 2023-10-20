//
//  ColorSchemaViewModel.swift
//
//
//  Created by morse on 14/7/2023.
//

import Combine
import HamsterKeyboardKit
import UIKit

class KeyboardColorViewModel {
  // MARK: properties

  public var enableColorSchema: Bool {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableColorSchema ?? false
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.enableColorSchema = newValue
    }
  }

  public var useColorSchemaForLight: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useColorSchemaForLight ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useColorSchemaForLight = newValue
    }
  }

  public var useColorSchemaForDark: String {
    get {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useColorSchemaForDark ?? ""
    }
    set {
      HamsterAppDependencyContainer.shared.configuration.Keyboard?.useColorSchemaForDark = newValue
    }
  }

  public var keyboardColorList: [HamsterKeyboardColor] = []

  public func reloadKeyboardColorList(style: UIUserInterfaceStyle) {
    self.keyboardColorList = style == .light ? keyboardColorListForLight : keyboardColorListForDark
  }

  public var keyboardColorListForLight: [HamsterKeyboardColor] {
    if let colorSchemas = HamsterAppDependencyContainer.shared.configuration.Keyboard?.colorSchemas, !colorSchemas.isEmpty {
      return colorSchemas
        .sorted()
        .compactMap {
          HamsterKeyboardColor(colorSchema: $0, userInterfaceStyle: .dark)
        }
    }
    return []
  }

  public var keyboardColorListForDark: [HamsterKeyboardColor] {
    if let colorSchemas = HamsterAppDependencyContainer.shared.configuration.Keyboard?.colorSchemas, !colorSchemas.isEmpty {
      return colorSchemas
        .sorted()
        .compactMap {
          HamsterKeyboardColor(colorSchema: $0, userInterfaceStyle: .dark)
        }
    }
    return []
  }

  public var segmentActionSubject = CurrentValueSubject<UIUserInterfaceStyle, Never>(.light)
  public var segmentActionPublished: AnyPublisher<UIUserInterfaceStyle, Never> {
    segmentActionSubject.eraseToAnyPublisher()
  }

  @objc func segmentChangeAction(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      segmentActionSubject.send(.light)
    case 1:
      segmentActionSubject.send(.dark)
    default:
      return
    }
  }
}
