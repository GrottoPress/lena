# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2026-02-24

### Fixed
- Setting additional response properties once in constructor

## [0.2.0] - 2025-12-08

### Added
- Allow setting custom base URL
- Add `Lena#uri` method

### Removed
- Remove `Lena.uri` class method

## [0.1.1] - 2025-06-27

### Added
- Add `Lena::Message::Content::Image` enum member

### Fixed
- Give each `Lena` instance its own `HTTP::Client` instance

## [0.1.0] - 2025-06-24

### Added
- Add `Lena` client
- Add *Messages* endpoint
- Add *Message Batches* endpoint
- Add *Models* endpoint
