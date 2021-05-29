import Foundation

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
