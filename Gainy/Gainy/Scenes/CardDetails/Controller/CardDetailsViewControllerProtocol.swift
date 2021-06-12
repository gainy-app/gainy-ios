protocol CardDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDismiss: (() -> Void)? { get set }
}
