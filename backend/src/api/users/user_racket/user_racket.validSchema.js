const yup = require('yup');

const getUserRacketListValidSchema = yup.object().shape({
  id: yup.number().required().label('E3610'),
});

module.exports = {
  getUserRacketListValidSchema,
};
