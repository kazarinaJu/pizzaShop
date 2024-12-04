//
//  Texts.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.12.2024.
//

enum Texts {
    enum Login {
        static let loginTitle = "Войдите в профиль"
        static let loginDescription = "Чтобы копить додокоины и получать персональные скидки"
        static let phoneTitle = "Укажите телефон, чтобы войти в профиль"
        static let codeTitle = "Введите код из смс"
        static let profileText = "Скоро тут будет профиль"
    }
    
    enum Menu {
        static let bannerTitle = "Выгодно и вкусно"
        static let ingredientsTitle = "Добавить по вкусу"
    }
    
    enum Map {
        static let mapDescription = "Город, улица и дом"
        static let mapPlaceholder = "Ваш адрес"
    }
    
    enum Cart {
        static let bannerTitle = "Добавить к заказу?"
        static let emptyCartTitle = "Пока тут пусто"
        static let emptyCartDescription = "Добавьте пиццу. Или две!"
        static let emptyCartPrice = "А мы  доставим заказ от 599 ₽"
    }
    
    enum Coins {
        static let title = "Начислим додокоинов"
        static let description = "+50"
        static let delivery = "Доставка"
        static let deliveryPrice = "Бесплатно"
    }
}
