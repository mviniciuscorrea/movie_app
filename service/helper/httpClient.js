const axios = require('axios');
const urlRoot = require('./urlRoot');
const query = require('./queryString');

const _headers = {
    'Content-Type': 'application/json'
}

module.exports = {

    async get(params) {
        return new Promise((resolve, reject) => {            
            axios.get(urlRoot.root + query.toString(params), _headers).then(resp => {
                resolve(resp.data);
            }).catch(error => {
                reject(error);
            });
        });
    }
}