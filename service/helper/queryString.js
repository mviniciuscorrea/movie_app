module.exports = {

    toString(params) {
        if (params) {
        return `?` +
            Object.keys(params).map(function (key) {
                return encodeURIComponent(key) + '=' +
                    encodeURIComponent(params[key]);
            }).join('&');
        } else {
            return '';
        }
    }

}