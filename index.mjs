// express

import express from 'express';
import fs from 'fs';

const app = express();
const port = process.env.WS3KP_PORT ?? 8083;

// template engine
app.set('view engine', 'ejs');

// version
const { version } = JSON.parse(fs.readFileSync('package.json'));

const index = (req, res) => {
	res.render('index', {
		production: false,
		version,
	});
};

const geoip = (req, res) => {
	res.set({
		'x-geoip-city': 'North Myrtle Beach',
		'x-geoip-country': 'US',
		'x-geoip-country-name': 'United States',
		'x-geoip-country-region': 'SC',
		'x-geoip-country-region-name': 'South Carolina',
		'x-geoip-latitude': '33.816',
		'x-geoip-longitude': '-78.6801',
		'x-geoip-postal-code': '29582',
		'x-geoip-time-zone': 'America/New_York',
		'content-type': 'application/json',
	});
	res.json({});
};

// debugging
if (process.env?.DIST === '1') {
	// distribution
	app.use('/', express.static('./dist'));
	app.use('/geoip', geoip);
} else {
	// debugging
	app.get('/index.html', index);
	app.get('/', index);
	app.get('*name', express.static('./server'));
	app.use('/geoip', geoip);
}

const server = app.listen(port, () => {
	console.log(`Server listening on port ${port}`);
});

// graceful shutdown
process.on('SIGINT', () => {
	server.close(() => {
		console.log('Server closed');
	});
});
