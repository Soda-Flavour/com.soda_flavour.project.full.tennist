const express = require('express');

const router = express.Router();


router.get('/privacy', async (req, res, next) => {

  res.sendfile(__dirname + "/index.html");
});


module.exports = router;