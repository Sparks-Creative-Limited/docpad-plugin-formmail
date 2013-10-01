nodemailer = require 'nodemailer'
captchagen = require 'captchagen'

module.exports = (BasePlugin) ->

	class FormMailPlugin extends BasePlugin
		name: 'formmail'

		config = docpad.getConfig().plugins.formmail
		smtp = nodemailer.createTransport('SMTP', config.transport)

		serverExtend: (opts) ->
			{express,server} = opts

			if(config.captcha)
				server.use express.cookieParser()
				server.use express.session secret: 'keyboard cat'
				server.use config.path, (req, res, next) ->
					if(req.body.captcha == req.session.captcha)
						next()
					else
						res.redirect '/'
				server.get config.captcha.path, (req, res) ->
					captcha = captchagen.generate config.captcha.options
					captcha.buffer (err, buf) ->
						req.session.captcha = captcha.text()
						res.send buf

			server.post config.path, (req, res) ->
				enquiry = req.body

				mailOptions = {
					to: config.to,
					from: config.transport.auth.user,
					subject: 'Enquiry from ' + enquiry.name + ' <' + enquiry.email + '>',
					text: enquiry.message,
					html: '<p>' + enquiry.message + '</p>'
				}

				smtp.sendMail mailOptions, (err, resp) ->
					if(err)
						console.log err
					else
						console.log("Message sent: " + resp.message);

				res.redirect '/'

			@