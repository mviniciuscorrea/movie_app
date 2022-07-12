module.exports = {
    async sumMovies(arrayMovies, newDataMovies) {
         for await (const dm of newDataMovies) {

            const index = arrayMovies.moviesByYear.findIndex(mov => mov.year == dm.Year)

            if (index >= 0) {
                arrayMovies.moviesByYear[index].movies += 1;
            } else {
                arrayMovies.moviesByYear.push({year: dm.Year, movies: 1});
            }  

            arrayMovies.total += 1;
        }
    },  

    async orderGroupMovies(arrayMovies) {
        arrayMovies.sort((a, b) => a.year - b.year);
    }
}