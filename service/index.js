const app = require('./app');

var port = process.env.PORT || 3000;

app.listen(port, function () {
    console.log(`Serviço rodando na porta ${port}`);     
});

module.exports = app;