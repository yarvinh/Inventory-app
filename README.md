
## Inventory tracker
This is a MVC ruby and sintra app , this app is for tracking sneaker in the inventory.
Architecture
I designed the database schema as follow: Sneakers belongs to brands, sneaker belongs to users, brands belongs to the user who created it, users have many brands, brands have many sneakers and users have many sneakers through brands.

## Features
Create and save to the database
Users can create an account and login. Logged in users can create a brand of a sneaker for example Nike. They can also store additional details such as style, size, gender, price, quantity and barcode data.

* Edit user info
The users can edit their business name, username, email, and change their password.

* Edit brands
Users can edit/rename brands.

* Edit sneaker
Users can edit their sneakers, can add to the quantity, and can subtract from sneaker quantity.

* Delete Users and brands
Users can delete their own account. Deleting an account also deletes all the brands and sneakers that are saved for the account. Users can delete individual and multiple brands, when a brand is deleted, the sneakers in the brand are deleted too, and users can delete individual and multiple sneakers.

## Installation
* First step
clone it. run `git clone https://github.com/nakajima/rack-flash.git`
$ git clone https://github.com/nakajima/rack-flash.git

* Once you clone it, next step.
Run `bundle install` to install all the gems. 
% bundle install 

* If Migrations are pending. Run `rake db:migrate` to resolve the issue.'
% rake db:migrate  


* Start it in the server
run `rackup` or `shutgun`
$ rackup

copy  `localhost:9292`  and paste it in the browser.

$ shotgun 
copy `http://127.0.0.1:9393/` and paste it in the browser.
Ready to use.



## Usage

Follow intructions



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yarvinh/Inventory-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/yarvinh/Inventory-app/blob/master/code_of_conduct.md).


## License

This MVC app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MVC Inventory-app codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yarvinh/Inventory-app/blob/master/code_of_conduct.md).
