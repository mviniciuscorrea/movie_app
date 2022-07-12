const moviesModel = require('../model/movies');

module.exports = {

    count: function (req, res) {
        if ((!req.query) || (!req.query.Title) || (req.query.Title.length == 0)) {
            res.status(400).send('Parâmetro Title em branco ou não informado corretamente')
        } else {            
            moviesModel.count(req.query, function (statusCode, response) {
                res.status(statusCode).send(response);
            })
        }
    },

}