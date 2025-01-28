const express = require('express');
const app = express();
const port = 3000;

const { log } = require('console');

app.use(express.static('public'));
app.use(express.json());

app.set('views');
app.set('view engine', 'ejs');

app.use('/api/room', (req, res) => {
    const rooms = require("./room.json").rooms;

    res.json({ rooms });
});

app.listen(port, () => {
    log('[ExpressJS] Website listen port http://localhost:' + port);
});