// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Localizable.strings
  ///   TMResources
  public static let languageCode = L10n.tr("Localizable", "LanguageCode", fallback: "en-US")
  public enum Common {
    public enum ErrorAlert {
      /// Unknown error occured
      public static let defaultMessageBody = L10n.tr("Localizable", "Common.ErrorAlert.DefaultMessageBody", fallback: "Unknown error occured")
      /// Tap to retry
      public static let tapToRetry = L10n.tr("Localizable", "Common.ErrorAlert.TapToRetry", fallback: "Tap to retry")
      /// Error
      public static let title = L10n.tr("Localizable", "Common.ErrorAlert.Title", fallback: "Error")
    }
  }
  public enum Error {
    /// HTTP error: %@.
    public static func httpError(_ p1: Any) -> String {
      return L10n.tr("Localizable", "Error.HTTPError", String(describing: p1), fallback: "HTTP error: %@.")
    }
    public enum ConnectionError {
      /// No internet connection
      public static let noInternet = L10n.tr("Localizable", "Error.ConnectionError.NoInternet", fallback: "No internet connection")
      /// Other connection issue
      public static let other = L10n.tr("Localizable", "Error.ConnectionError.Other", fallback: "Other connection issue")
      /// Server did not respond to request
      public static let timeout = L10n.tr("Localizable", "Error.ConnectionError.Timeout", fallback: "Server did not respond to request")
    }
  }
  public enum MovieDetails {
    /// Year: %@
    public static func releaseYear(_ p1: Any) -> String {
      return L10n.tr("Localizable", "MovieDetails.ReleaseYear", String(describing: p1), fallback: "Year: %@")
    }
  }
  public enum MoviesList {
    /// Discover
    public static let title = L10n.tr("Localizable", "MoviesList.Title", fallback: "Discover")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
