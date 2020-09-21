const express = require('express');
const apiError = require('../../../lib/apiError');
const authMiddlewares = require('../../auth/auth.middlewares');
const queries = require('./user_racket.queries');
const {
  getUserRacketListValidSchema
} = require('./user_racket.validSchema');

const router = express.Router();
router.use(authMiddlewares.checkUserHasToken);

router.get('/list', authMiddlewares.isLoggedIn, async (req, res, next) => {
  const {
    id
  } = req.user;
  try {
    await getUserRacketListValidSchema.validate({
      id
    }, {
      abortEarly: false
    });
    console.log(id);
    const userRacketList = await queries.getRacketList(id);
    console.log(userRacketList);
    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: {
          list: userRacketList
        },
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3600');
    }
    next(error);
  }
});

module.exports = router;