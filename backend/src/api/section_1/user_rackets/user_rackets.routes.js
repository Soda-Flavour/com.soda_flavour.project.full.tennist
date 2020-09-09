/* eslint-disable no-ex-assign */
const express = require('express');
const router = express.Router();

const apiError = require('../../../lib/apiError');
const queries = require('./user_rackets.queries');
const authMiddlewares = require('../../auth/auth.middlewares');

const {
  getUserRacketsValidSchema,
} = require('./user_rackets.validSchema');

router.use(authMiddlewares.checkUserHasToken);

//
//

router.get('/:id', async (req, res, next) => {

  const {
    id
  } = req.params;
  try {

    const reqParams = {
      t_user_id: id,
    };

    const _reqParams = await getUserRacketsValidSchema.validate(
      reqParams, {
        abortEarly: false,
      }
    );
    console.log(_reqParams)

    const resultData = await queries.getUserRacketsData(_reqParams);

    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: resultData
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      const _error = await apiError('E4400');
      next(_error);
    }
    next(error);
  }
});


module.exports = router;