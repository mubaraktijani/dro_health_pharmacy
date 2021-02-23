import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:catcher/catcher.dart';

import 'constants.dart';

//release error handler configuration
CatcherOptions releaseOptions = CatcherOptions(
	DialogReportMode(), 
	[
		ToastHandler(
			gravity: ToastHandlerGravity.bottom,
			length: ToastHandlerLength.long,
			backgroundColor: Colors.red,
			textColor: Colors.white,
			textSize: 12.0,
			customMessage: CUSTOM_ERROR_MESSAGE
		),

		EmailAutoHandler(
			SMTP_HOST, 
			SMTP_PORT, 
			SENDER_EMAIL,
			SENDER_NAME,
			SENDER_PASSWORD, 
			RECIPIENTS,
		),
		
		SentryHandler(SentryClient(dsn: SENTRY_CLIENT_DNS))
	]
);