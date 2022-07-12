const express = require('express');
const app = express();
const route = require('./routes');
const helmet = require('helmet');

app.use(helmet());
app.use('/', route);

app.use(function (_req, res, next) {
    res.status(400).send("Endpoint não encontrado");
    next();
});

module.exports = app;