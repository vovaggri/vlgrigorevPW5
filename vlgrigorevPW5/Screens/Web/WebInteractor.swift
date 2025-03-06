//
//  WebInteractor.swift
//  vlgrigorevPW5

protocol WebBuisnessLogic {
    
}

final class WebInteractor: WebBuisnessLogic {
    private var presenter: WebPresenterProtocol?
    
    init(presenter: WebPresenterProtocol?) {
        self.presenter = presenter
    }
}
