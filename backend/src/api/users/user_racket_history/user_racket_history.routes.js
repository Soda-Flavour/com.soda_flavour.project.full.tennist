const express = require('express');
const yup = require('yup');
const apiError = require('../../../lib/apiError');
const authMiddlewares = require('../../auth/auth.middlewares');
const queries = require('./user_racket_history.queries');
const {
  getUserRacketListValidSchema,
  insertRacketHistoryValidSchema,
  getUserRacketDataValidSchema,
} = require('./user_racket_history.validSchema');

const router = express.Router();
router.use(authMiddlewares.checkUserHasToken);

router.get('/list', authMiddlewares.isLoggedIn, async (req, res, next) => {
  const { id } = req.user;
  try {
    await getUserRacketListValidSchema.validate({ id }, { abortEarly: false });

    const userRacketList = await queries.getRacketList(id);

    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: { list: userRacketList },
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

router.post('/insert', authMiddlewares.isLoggedIn, async (req, res, next) => {
  const t_racket_id = parseInt(req.body.t_racket_id, 10);
  const weight = parseInt(req.body.weight, 10);
  const balance_val = parseFloat(req.body.balance_val, 4);
  const t_gut_id = parseInt(req.body.t_gut_id, 10);
  const main_tension = parseFloat(req.body.main_tension, 4);
  const cross_tension = parseFloat(req.body.cross_tension, 4);
  const essential_grip = req.body.essential_grip;
  const over_grip_num = parseInt(req.body.over_grip_num, 10);
  const balance_type = req.body.balance_type;
  const { id } = req.user;

  try {
    const userRacketHistoryData = {
      t_user_racket_id: t_racket_id,
      weight_tune: weight,
      racket_balance_type: balance_type,
      racket_balance_val: balance_val,
      t_gut_id,
      main_gut_lb_tension: main_tension,
      cross_gut_lb_tension: cross_tension,
      replacement_grip_type: essential_grip,
      overgrip_num: over_grip_num,
      t_user_id: id,
    };

    console.log(userRacketHistoryData);
    const _userRacketHistoryData = await insertRacketHistoryValidSchema
      .validate(userRacketHistoryData, { abortEarly: true })
      .catch(async (err) => {
        console.log(err);
        const _err = await apiError(err.params.label);
        res.status(403);
        throw _err;
      });
    const insertRacketHistoryResult = await queries.insertRacketHistory(
      _userRacketHistoryData
    );

    console.log(insertRacketHistoryResult);
    res.json({
      result: {
        status: 200,
        message: '라켓 히스토리를 추가했습니다.',
        data: null,
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3900');
    }
    next(error);
  }
});

router.get(
  '/:userRacketId',
  authMiddlewares.isLoggedIn,
  async (req, res, next) => {
    const { userRacketId } = req.params;
    const { id } = req.user;
    try {
      const reqParams = {
        userRacketId,
        id,
      };
      const _reqParams = await getUserRacketDataValidSchema.validate(
        reqParams,
        {
          abortEarly: false,
        }
      );

      const userRacketList = await queries.getUserRacketHistoryData(_reqParams);

      res.json({
        result: {
          status: 200,
          message: 'send data..',
          data: { userRacketList },
        },
      });
    } catch (error) {
      console.log(error);
      if (error.errorCode == undefined) {
        error = await apiError('E3400');
      }
      next(error);
    }
  }
);

module.exports = router;
