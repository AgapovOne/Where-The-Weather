// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> Where_The_Weather.WeatherViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? Where_The_Weather.WeatherViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case placeContentViewControllerScene = "PlaceContentViewController"
    static func instantiatePlaceContentViewController() -> Where_The_Weather.PlaceContentViewController {
      guard let vc = StoryboardScene.Main.placeContentViewControllerScene.viewController() as? Where_The_Weather.PlaceContentViewController
      else {
        fatalError("ViewController 'PlaceContentViewController' is not of the expected class Where_The_Weather.PlaceContentViewController.")
      }
      return vc
    }

    case placePageViewControllerScene = "PlacePageViewController"
    static func instantiatePlacePageViewController() -> Where_The_Weather.PlacePageViewController {
      guard let vc = StoryboardScene.Main.placePageViewControllerScene.viewController() as? Where_The_Weather.PlacePageViewController
      else {
        fatalError("ViewController 'PlacePageViewController' is not of the expected class Where_The_Weather.PlacePageViewController.")
      }
      return vc
    }

    case weatherViewControllerScene = "WeatherViewController"
    static func instantiateWeatherViewController() -> Where_The_Weather.WeatherViewController {
      guard let vc = StoryboardScene.Main.weatherViewControllerScene.viewController() as? Where_The_Weather.WeatherViewController
      else {
        fatalError("ViewController 'WeatherViewController' is not of the expected class Where_The_Weather.WeatherViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}

