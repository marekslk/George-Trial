import XCTest
@testable import TrialCore

final class TrialCoreTests: XCTestCase {
    private var initialuserWasOnboardedValue: Bool!

    override func setUp() {
        super.setUp()
        initialuserWasOnboardedValue = UserDefaultsProvider.userWasOnboarded
    }

    override func tearDown() {
        super.tearDown()

        UserDefaultsProvider.userWasOnboarded = initialuserWasOnboardedValue
    }

    func testUserWasOnboardedEqualToFalse() throws {
        UserDefaultsProvider.userWasOnboarded = false

        XCTAssert(UserDefaultsProvider.userWasOnboarded == false)
    }

    func testUserWasOnboardedEqualToTrue() throws {
        UserDefaultsProvider.userWasOnboarded = true

        XCTAssert(UserDefaultsProvider.userWasOnboarded)
    }
}
