# Adaptive Cards Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased

### Added

-    Support for Image and ImageSet elements of Adaptive Cards
-    Support for specifying string enum option values using Ruby symbols, which will be automatically camelCased, e.g. specifying `spacing: :extra_large` will be generate `'spacing' : 'extraLarge'` in the JSON.

### Changed

-    `InvalidElementError` renamed to `InvalidContentError` for clarity

## 0.2.0 (2018-11-28)

### Added

-    Support for selectAction on Adaptive Cards.
-    Support for ShowCard action

### Changed

-    Overhauled options processing to use class macros

## 0.1.0 (2018-11-25)

-    Initial release with basic support for Adaptive Cards and selected elements.