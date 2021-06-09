import UIKit

protocol RouterProtocol: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?,
              animated: Bool)
    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?,
              animated: Bool,
              completion: (() -> Void)?)

    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)
}

final class Router: NSObject, RouterProtocol {
    // MARK: Lifecycle

    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
        super.init()
        self.rootController?.delegate = self
    }

    // MARK: Internal

    // MARK: Presentable

    func toPresent() -> UIViewController? {
        rootController
    }

    // MARK: RouterProtocol

    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?) {
        push(module, transition: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        push(module, transition: transition, animated: true)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        push(module, transition: transition, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?,
              animated: Bool,
              completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = module?.toPresent(),
              controller is UINavigationController == false
        else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    func popModule() {
        popModule(transition: nil)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        popModule(transition: transition, animated: true)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popToModule(module: Presentable?, animated: Bool) {
        if let controllers = rootController?.viewControllers, let module = module {
            for controller in controllers where controller == module as? UIViewController {
                rootController?.popToViewController(controller, animated: animated)
                break
            }
        }
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?

    // MARK: Functions

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - Extensions

// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    func navigationController(
        _: UINavigationController,
        animationControllerFor _: UINavigationController.Operation,
        from _: UIViewController,
        to _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        self.transition
    }
}
