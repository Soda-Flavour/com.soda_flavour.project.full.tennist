const yup = require('yup');

const getUserRacketsValidSchema = yup.object().shape({
  t_user_id: yup.number().required().label('E4410'),
});


module.exports = {
  getUserRacketsValidSchema,
};