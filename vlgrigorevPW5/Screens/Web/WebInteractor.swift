//
//  WebInteractor.swift
//  vlgrigorevPW5

protocol WebBuisnessLogic {
    func returnButtonLogic()
}

final class WebInteractor: WebBuisnessLogic {
    private var presenter: WebPresenterProtocol?
    
    init(presenter: WebPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func returnButtonLogic() {
        presenter?.routBackNews()
    }
}
