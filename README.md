# FormMail Plugin for [DocPad](http://docpad.org)

A simple DocPad plugin which extends the server to handle posts to a configurable url and deliver it's contents to email
addresses with a configurable smtp account.
The typical usage scenario is adding a contact form to your DocPad site.


## Install

```
npm install --save docpad-plugin-formmail
```


## Usage

### Setup

Configure the path to be intercepted on your server and the email details for sending out form data in the DocPad
configuration file:

```coffeescript
	plugins:
		formmail:
			path: '/contact'
			transport: {
				service: 'Gmail',
				auth: {
					user: 'noreply@example.com',
					pass: 'password'
				}
			}
			to: 'enquiries@example.com'
```

Where:

 - the `path` property should match the POST action on your site's form.
 - the `to` property may be a list of destination email addresses for sending form submissions.
 - the `transport` property configures an SMTP transport instance using [nodemailer](http://www.nodemailer.com/)


## History
You can discover the history inside the `History.md` file



## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ [Sparks Creative Limited](http://www.sparks.uk.net)

