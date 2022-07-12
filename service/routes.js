const express = require('express');
const router = express.Router();
const moviesController = require('./controller/movies');

router.get('/api/movies/count', moviesController.count);

module.exports = router;