const express = require('express');
const yup = require('yup');
const apiError = require('../../../lib/apiError');
const authMiddlewares = require('../../auth/auth.middlewares');
const queries = require('./racket_history.queries');
const {
  getUserRacketHistoryDetailValidSchema,
  insertUserRacketHistoryDetailCommentValidSchema,
  getUserRacketDataValidSchema,
} = require('./racket_history.validSchema');

const router = express.Router();
router.use(authMiddlewares.checkUserHasToken);

router.get('/detail', async (req, res, next) => {
  console.log('req.params', req.query);
  try {
    const {
      user_racket_history_id: userRacketHistoryId
    } = req.query;

    const reqParams = {
      userRacketHistoryId,

    };

    const _reqParams = await getUserRacketHistoryDetailValidSchema.validate(
      reqParams, {
        abortEarly: false,
      }
    );

    const resultData = await queries.getRacketHistoryDetailData(_reqParams);

    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: resultData,
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E4200');
    }
    next(error);
  }
});

router.post('/detail', authMiddlewares.isLoggedIn, async (req, res, next) => {
  const user_racket_history_id = parseInt(req.body.user_racket_history_id, 10);
  const comment = req.body.comment;
  const {
    id
  } = req.user;

  try {
    const reqParams = {
      t_user_racket_history_id: user_racket_history_id,
      comment,
      t_user_id: id,
    };

    const _reqParams = await insertUserRacketHistoryDetailCommentValidSchema
      .validate(reqParams, {
        abortEarly: true
      })
      .catch(async (err) => {
        console.log(err);
        const _err = await apiError(err.params.label);
        res.status(403);
        throw _err;
      });

    const resultData = await queries.insertRacketHistoryDetailComment(
      _reqParams
    );

    res.json({
      result: {
        status: 200,
        message: '코멘트를 추가했습니다.',
        data: resultData,
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E4300');
    }
    next(error);
  }
});

router.get('/', async (req, res, next) => {
  console.log('req.params', req.query);
  try {
    const {
      racket_history_id: userRacketId
    } = req.query;

    const reqParams = {
      userRacketId,
    };
    const _reqParams = await getUserRacketDataValidSchema.validate(reqParams, {
      abortEarly: false,
    });
    console.log('_reqParams', _reqParams);
    const resultData = await queries.getUserRacketHistoryData(_reqParams);

    console.log('resultData', resultData);

    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: resultData,
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E4000');
    }
    next(error);
  }
});

module.exports = router;