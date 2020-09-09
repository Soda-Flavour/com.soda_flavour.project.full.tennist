/* eslint-disable no-ex-assign */
const express = require('express');
const router = express.Router();

const authMiddlewares = require('../auth/auth.middlewares');
const racket_of_users = require('./racket_of_users/racket_of_users.routes');
const user_rackets = require('./user_rackets/user_rackets.routes');
const racket_history = require('./racket_history/racket_history.routes');

router.use('/racket_of_users', racket_of_users);
router.use('/user_rackets', user_rackets);
router.use('/racket_history', racket_history);
router.use(authMiddlewares.checkUserHasToken);

module.exports = router;