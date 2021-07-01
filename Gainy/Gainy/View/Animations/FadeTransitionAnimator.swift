import Foundation
import UIKit

final class FadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using _: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        0.3
    }

    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let toViewController =
            transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                       animations: {
                           toViewController.view.alpha = 1
                       }, completion: { _ in
                           transitionContext.completeTransition(
                               !transitionContext.transitionWasCancelled
                           )
                       })
    }
}
