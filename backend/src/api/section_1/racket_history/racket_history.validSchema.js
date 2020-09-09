const yup = require('yup');

const getUserRacketHistoryDetailValidSchema = yup.object().shape({
  userRacketHistoryId: yup.number().required().label('E4210'),
});

const insertUserRacketHistoryDetailCommentValidSchema = yup.object().shape({
  t_user_racket_history_id: yup.number().required().label('E4310'),
  comment: yup.string().trim().required().label('E4320'),
  t_user_id: yup.number().required().label('E4330'),
});

const insertRacketHistoryValidSchema = yup.object().shape({
  t_user_racket_id: yup.number().required().label('E3910'),
  weight_tune: yup.number().required().label('E3911'),
  racket_balance_type: yup.string().trim().required().label('E3912'),
  racket_balance_val: yup.number().required().label('E3913'),
  t_gut_id: yup.number().required().label('E3914'),
  main_gut_lb_tension: yup.number().required().label('E3915'),
  cross_gut_lb_tension: yup.number().required().label('E3916'),
  replacement_grip_type: yup.string().trim().required().label('E3917'),
  overgrip_num: yup.number().required().label('E3918'),
  t_user_id: yup.number().required().label('E3919'),
});

const getUserRacketDataValidSchema = yup.object().shape({
  userRacketId: yup.number().required().label('E4120'),
});

module.exports = {
  getUserRacketHistoryDetailValidSchema,
  insertUserRacketHistoryDetailCommentValidSchema,
  insertRacketHistoryValidSchema,
  getUserRacketDataValidSchema,
};