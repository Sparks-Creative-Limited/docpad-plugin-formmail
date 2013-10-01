nodemailer = require 'nodemailer'
captchagen = require 'captchagen'
crypto = require 'crypto'

module.exports = (BasePlugin) ->

	class FormMailPlugin extends BasePlugin
		name: 'formmail'

		config = docpad.getConfig().plugins.formmail
		smtp = nodemailer.createTransport('SMTP', config.transport)

		serverExtend: (opts) ->
			{express,server} = opts
			success = config.redirect || '/'

			if(config.captcha)
				fail = config.captcha.redirect || '/'
				secret = crypto.randomBytes(16).toString 'hex'
				server.use express.cookieParser()
				server.use express.session secret: secret
				server.use config.path, (req, res, next) ->
					if(req.body.captcha == req.session.captcha)
						next()
					else
						res.redirect fail
				server.get config.captcha.image, (req, res) ->
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

				res.redirect success

			@