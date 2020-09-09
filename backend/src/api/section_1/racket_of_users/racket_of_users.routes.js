/* eslint-disable no-ex-assign */
const express = require('express');
const router = express.Router();

const apiError = require('../../../lib/apiError');
const queries = require('./racket_of_users.queries');
const authMiddlewares = require('../../auth/auth.middlewares');

// const {
//   getRacketOfAllUserValidSchema,
// } = require('./racket_of_users.validSchema');

router.use(authMiddlewares.checkUserHasToken);

//
//

router.get('/', async (req, res, next) => {
  console.log('req.params', req.query);
  try {
    // const { user_racket_history_id: userRacketHistoryId } = req.query;
    // const { id } = req.user;

    // const reqParams = {
    //   userRacketHistoryId,
    //   t_user_id: id,
    // };

    // const _reqParams = await getRacketOfAllUserValidSchema.validate(
    //   reqParams,
    //   {
    //     abortEarly: false,
    //   }
    // );

    // const resultData = await queries.getRacketHistoryDetailData(_reqParams);
    const resultData = await queries.getRacketOfAllUserData();

    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: {
          list: resultData
        },
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      const _error = await apiError('E4200');
      next(_error);
    }
    next(error);
  }
});


module.exports = router;