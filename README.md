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

Configure the path to be intercepted on your server, the success redirect path and the email details for sending out
form data in the DocPad configuration file. You can also enable Captcha form validation with additional configuration
options. A full configuration entry would look similar to:

```coffeescript
	plugins:
		formmail:
			path: '/contact',
			redirect: '/thanks',
			transport:
				service: 'Gmail',
				auth:
					user: 'noreply@example.com',
					pass: 'password'
			to: 'enquiries@example.com',
			captcha:
				image: '/captcha',
				redirect: '/tryagain',
				options:
					height: 150,
					width: 300
```

Where:

 - the `path` property should match the POST action on your site's form.
 - the `redirect` property (optional) references a valid route to following successful submission (defaults to '/').
 - the `to` property may be a list of destination email addresses for sending form submissions.
 - the `transport` property configures an SMTP transport instance using [nodemailer](http://www.nodemailer.com/).

 - the `captcha -> image` property sets the path to retrieve captcha images, e.g `<img src="/captcha" />`
 - the `captcha -> redirect` property (optional) references a valid route to following failed Captcha validation
 (defaults to '/')
 - the `captcha -> options` property sets options for generating images, as used by
  [captchagen](https://github.com/wearefractal/captchagen), such as image height and width.


## History
You can discover the history inside the `History.md` file



## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ [Sparks Creative Limited](http://www.sparks.uk.net)

