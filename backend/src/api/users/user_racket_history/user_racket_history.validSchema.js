const yup = require('yup');

const getUserRacketListValidSchema = yup.object().shape({
  id: yup.number().required().label('E3610'),
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
  id: yup.number().required().label('E3410'),
  userRacketId: yup.number().required().label('E3420'),
});

module.exports = {
  getUserRacketListValidSchema,
  insertRacketHistoryValidSchema,
  getUserRacketDataValidSchema,
};
