README

This Virtual Wallet is a web application that allows users to create and manage a digital wallet, add multiple cards, transfer money, and perform transactions between users. It also offers Google authentication and admin functionality for managing user profiles.

Features
	User registration and login (including Google login)
	Wallet creation and management
	Multiple card management
	Money transfer between cards and wallet
	Transactions between users
	KYC (Know Your Customer) details submission
	Profile management
	Admin functionality for approving and editing user profiles
	Secure storage of sensitive information using environment variables
	QR code generation
	
Prerequisites
	Ruby 2.7.0 or higher
	Rails 6.1.4 or higher
	PostgreSQL 12.0 or higher
	Node.js 14.0 or higher
	Yarn 1.22.5 or higher

Gems/Tools Used
	SimpleCov
	Rails ERB UML Generator
	ActiveAdmin
	dotenv-rails
	OmniAuth
	OmniAuth-Google-OAuth2
	OmniAuth-Rails-CSRF-Protection
	AWS SDK SecretsManager
	RQRCode
	Contributing
	Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests.

License
	This project is licensed under the MIT License - see the LICENSE.md file for details.


Acknowledgements

A special thanks to Texas A&M University, the Computer Science Department, and Dr. Ritchey for promoting an environment of self-learning in the world of extreme programming.
Appreciation to the team members and contributors for their valuable input and hard work.
Thank you to our customer for contributing this project to our class.


Steps to run this app on your local machine: 

Environment: It is recommended to use Ubuntu or WSL with vscode. 
Packages: make sure git has been installed on your lcoal machine
Step 1: 
To install Git on Ubuntu, you can follow these steps:
Open a terminal window by pressing Ctrl + Alt + T.
Update the package list by running the following command: sudo apt update
Install Git by running the following command: sudo apt install git
Verify that Git has been installed by running the following command: git --version

Step 2:
Clone the repo. Navigate to the directory you want to place this project. 
Open a terminal in vscode or ubuntu. copy and paste the following command and press enter:
git clone https://github.com/ChunkaiFu/wallet.git 
Navigate to the directory called wallet. There you should see all the app files. 

Step 3: 
For development and testing: 
Open the terminal at the project root, create a new file called ".env", and copy and paste the following lines into the file: 

AWS_KEY= Place your AWS_KEY here 
AWS_SECRET= Place your AWS_secret here 
For detailed instructions on obtaing AWS key and secret, please refer to the following docuemntation: 
https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html 
In the root of the project terminal enter the command: bundle 
If your see errors similar to bundle commands not found, you need to install a bunlder first. 
Follow this tutorial to install bundler rails and ruby: 
https://bundler.io/guides/rails.html

Then run the command: rake db:migrate 
Then run the command: rails s 
You should see local host is active and running, open a window of your browser and type in the corresponding local address, you should see 
the app up and running. 

For production: 
1. Set master account for Mailer: you need to obtain a master mailing account for the mailer feature in this app. For details on how to set up and config the development and production 
on mailer, please refer to this tutorial: 
https://developers.google.com/workspace/guides/create-credentials 

2. Set run time variable for Heroku: you need to set the run time variable for heroku before deploying it. 
Use the following commands to set heroku run time environment variable: 
	heroku config:set AWS_KEY= <your aws key here which is the same as the local env variables above>
	heroku config:set AWS_SECRET= <your aws secret which is the same as the one you have set in the .env as well>


3. Add, commit and push all your changes to a repo of your own. Then run: git push heroku main 
	then: heroku run rake db:migrate 
	then: heroku info 
Then you should see the link for the deployed link. 

Quick tips: 
	1. Debugging: for those who are new to ruby on rails, you are likely going to encounter many bugs and errors messages and some times many confusions. 
	don't hesitate to google the error message and try to find out a fix. Pair programming is also helpful in debugging as well. 
	2. Stuck? If you get stuck on some part of the progress, seek immediate help from professor or more experienced peers, do not hold on to the bugs to yourself. 
	3. You could alwys reach out to the owner of this repo if you want to know more. 

Good luck and have fun! 




