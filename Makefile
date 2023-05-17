.PHONY: install gen open

install:
	brew install xcodegen
	brew install swiftlint

gen:
	xcodegen generate

open:
	open FingerCrossed.xcodeproj