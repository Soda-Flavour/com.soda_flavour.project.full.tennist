const express = require('express');


const policy = require('./policy/policy.routes');

// const gut_company = require('./gut_company/gut_company.routes');
// const gut_company = require('./gut_company/gut_company.routes');
// const gut_company = require('./gut_company/gut_company.routes');
// const gut_company = require('./gut_company/gut_company.routes');

const router = express.Router();
// router.get('/', (req, res) => {
//   res.json({
//     message: project.message,
//   });
// });
router.use('/policy', policy);

//  router.use('/gut_company', gut_company);
//  router.use('/gut_company', gut_company);

module.exports = router;