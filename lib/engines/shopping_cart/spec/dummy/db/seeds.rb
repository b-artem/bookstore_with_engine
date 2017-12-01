Book.create(title: 'This is a test book 1 title', price: 100)
Book.create(title: 'This is a test book 2 title', price: 100)
Book.create(title: 'This is a test book 3 title', price: 100)
ShoppingCart::LineItem.create(product: Book.find(1),
                cart: ShoppingCart::Cart.last,
                price: Book.find(1).price,
                quantity: 1)
ShoppingCart::LineItem.create(product: Book.find(2),
                cart: ShoppingCart::Cart.last,
                price: Book.find(2).price,
                quantity: 1)
ShoppingCart::ShippingMethod.create(name: 'Pick Up In-Store',
        days_min: 5, days_max: 20, price: 10.0)
ShoppingCart::ShippingMethod.create(name: 'Delivery Next Day!',
        days_min: 3, days_max: 7, price: 5.0)
ShoppingCart::ShippingMethod.create(name: 'Expressit',
        days_min: 2, days_max: 3, price: 15.0)
