nodemailer = require 'nodemailer'

module.exports = (BasePlugin) ->

	class FormMailPlugin extends BasePlugin
		name: 'formmail'

		config = docpad.getConfig().plugins.formmail
		smtp = nodemailer.createTransport('SMTP', config.transport)

		serverExtend: (opts) ->
			{server} = opts

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