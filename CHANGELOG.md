# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Added
- Add `Lena::CurrentOrganization::Endpoint`
- Add `Lena::Message::Content#citations`
- Add `Lena::Model::OPUS_4_6` constant
- Add `Lena::Model::OPUS_4_5` constant
- Add `Lena::Model::OPUS_4_5_20251101` constant
- Add `Lena::Model::OPUS_4_1` constant
- Add `Lena::Model::OPUS_4_1_20250805` constant
- Add `Lena::Model::OPUS_4_0` constant
- Add `Lena::Model::OPUS_4_0_20250514` constant
- Add `Lena::Model::SONNET_4_6` constant
- Add `Lena::Model::SONNET_4_5` constant
- Add `Lena::Model::SONNET_4_5_20250929` constant
- Add `Lena::Model::SONNET_4_0` constant
- Add `Lena::Model::SONNET_4_0_20250514` constant
- Add `Lena::Model::HAIKU_4_5` constant
- Add `Lena::Model::HAIKU_4_5_20251001` constant
- Add `Lena::Model::HAIKU_3_0_20240307` constant

### Fixed
- Ignore response fields that are retrieved from headers when parsing JSON

### Changed
- Rename `Lena::ServiceTier` to `Lena::Usage::ServiceTier`
- Rename `Lena::StopReason` to `Lena::Message::StopReason`
- Rename `Lena::Role` to `Lena::Message::Role`

## [0.3.1] - 2026-02-26

### Fixed
- Undo repeated `String#split` call in `Lena::MessageBatch::Result::List#initialize`

## [0.3.0] - 2026-02-26

### Changed
- Normalize response outputs

### Fixed
- Add query parameters to URL in `Lena::MessageBatch::Endpoint#list`
- Remove empty lines when parsing `JSONL` in `Lena::MessageBatch::Result::List`

## [0.2.3] - 2026-02-24

### Fixed
- Fix wrong API types and properties

## [0.2.2] - 2026-02-24

### Added
- Add missing `Lena::Message::Content::ToolResult` member

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
