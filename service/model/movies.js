const http = require('../helper/httpClient');
const funcMovies = require('../helper/movies/functions');

module.exports = {
    count: async function (params, _callback) {
        http.get(params).then(async resp => {
            let moviesObj = {
                moviesByYear: [],
                total: 0,
            }

            if (resp.total == 0) {
                _callback(200, moviesObj);
            } else {

                const promises = [];
                await funcMovies.sumMovies(moviesObj, resp.data)

                for (let page = 2; page <= resp.total_pages; page++) {
                    await http.get({
                        'Title': params.Title,
                        'page': page,
                    }).then(async resp => {
                        promises.push(await funcMovies.sumMovies(moviesObj, resp.data));
                    });
                }

                await funcMovies.orderGroupMovies(moviesObj.moviesByYear);
                await Promise.all(promises);
                _callback(200, moviesObj);
            }
        }).catch(error => {
            _callback(400, error)
        })

    }
}